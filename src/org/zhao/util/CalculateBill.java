package org.zhao.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.zhao.entity.Account;
import org.zhao.entity.Bill;
import org.zhao.entity.BillItem;
import org.zhao.entity.DurationRank;
import org.zhao.entity.Host;
import org.zhao.entity.Service;
import org.zhao.entity.ServiceDetail;
import org.zhao.entity.ServiceUpdateBak;
import org.zhao.service.BillService;
import org.zhao.service.CostService;
import org.zhao.service.ReportService;
import org.zhao.service.ServiceService;

/**每月的月初定时计算账单数据**/
@Component("calculateBill")
public class CalculateBill {
	
	@Resource
	private BillService billService;
	
	@Resource
	private ReportService reportService;
	
	@Resource
	private CostService costService;
	
	@Resource
	private ServiceService serviceService;
	
	//每月月初开始计算费用数据,获取账单日期年月
	String billYearMonth=CalendarUitl.getBillYearMonth();
	//执行时间:每月月初
	//               秒 /分/时/日/月/周几,spring task不支持年份
	@Scheduled(cron="50 00 19 1 * ?")//每月1日凌晨6点触发
	public void calculateBills() {    
		System.out.println("1=============createBill");
		System.out.println("为至少开通一项业务且该业务存于开启状态的账户账号创建月账单");
		createBill();//为至少开通一项业务且该业务存于开启状态的账户账号创建月账单
		
		System.out.println("2=============calculateDuration");
		System.out.println("根据登录登出时间计算每一个业务账号每一次的登录时长");
		calculateDuration();//根据登录登出时间计算每一个业务账号每一次的登录时长
		
		System.out.println("3=============calculateCost");
		System.out.println("根据业务账号的资费类型，计算每一次的登录时长的费用");
		calculateCost();//根据业务账号的资费类型，计算每一次的登录时长的费用
		
		System.out.println("4=============calculateTotalCost");
		System.out.println("计算每个业务账号的总费用,将其存到bill_item中");
		calculateTotalCost();//计算每个业务账号的总费用,将其存到bill_item中
		
		System.out.println("5=============calculateBillTotalCost");
		System.out.println("计算每个账户账号每月的总费用");
		calculateBillTotalCost();//计算每个账户账号每月的总费用
		
		System.out.println("6=============updateServiceCostType");
		System.out.println("更新业务账号的资费类型,并根据资费类型为服务器IP增加使用资费类型次数");
		updateServiceCostType();//更新业务账号的资费类型,并根据资费类型为服务器IP增加使用资费类型次数
		
		System.out.println("7=============calculateAccountSofaDurationOnHost");
		System.out.println("计算用户在服务器上的至今累计时长");
		calculateAccountSofaDurationOnHost();//计算用户在服务器上的至今累计时长
		
	}  
	
	/**1.为至少开通一项业务且该业务存于开启状态的账户账号创建月账单**/
	public void createBill(){
		List<Account> accounts = billService.findUsingServiceAccounts();
		if (accounts==null || accounts.size()==0) {
			return;
		}
		
		List<Bill> bills=new ArrayList<Bill>();
		for (Account account : accounts) {
			Bill bill=new Bill();
			bill.setAccount_id(account.getAccount_id());
			bill.setBill_month(billYearMonth);
			bill.setIdcard_no(account.getIdcard_no());
			bill.setLogin_name(account.getLogin_name());
			bill.setReal_name(account.getReal_name());
			bill.setPay_state("1");
			bills.add(bill);
		}
		billService.batchAddBills(bills);
	}
	
	/**2.根据登录登出时间计算时长**/
	public void calculateDuration(){
		//计算登录在线时间,单位为秒
		billService.calculateMonthDuration(billYearMonth);
	}
	
	/**3.根据时长计算费用**/
	public void calculateCost(){
		//查询所有处于开通状态的业务账号id及其资费信息
		List<Map<String, Object>> serviceAndCostInfo = billService.findBillServiceCostInfo(billYearMonth);
		//都没有就直接结束
		if (serviceAndCostInfo==null || serviceAndCostInfo.size()==0) {
			return;
		}
		
		for (Map<String, Object> info : serviceAndCostInfo) {
			Integer serviceId=new Integer(info.get("service_id").toString().trim());
			List<ServiceDetail> serviceDetails = billService.findServiceDetailByBillMonth(billYearMonth,serviceId);
			//如果没有该业务账号的登录记录就结束本次循环,继续下一次循环
			if (serviceDetails==null || serviceDetails.size()==0) {
				continue;
			}
			
			//资费类型:1.包月,2.套餐,3.计时
			String costType=info.get("cost_type").toString().trim();
			
			//包月只有基本费用
			if(costType.equals("1")){
				List<ServiceDetail> list=new ArrayList<ServiceDetail>();
				for (ServiceDetail serviceDetail : serviceDetails) {
					Long duration = serviceDetail.getDuration();
					serviceDetail.setDuration_str(FormatTime.formatToDDHHMMSS(duration));
					serviceDetail.setCost(0.00);
					list.add(serviceDetail);
				}
				billService.calculateCostAndDuration(list);
			} 
			
			//套餐三个都有
			if(costType.equals("2")){
				Integer baseDuration=Integer.parseInt(info.get("base_duration").toString().trim());
				Double unitCost=new Double(info.get("unit_cost").toString().trim());
				
				long totalDuration=new Integer(0);//单位是秒
				boolean durationFlag=false;
				
				List<ServiceDetail> list=new ArrayList<ServiceDetail>();
				for (ServiceDetail serviceDetail : serviceDetails) {
					Long duration = serviceDetail.getDuration();
					serviceDetail.setDuration_str(FormatTime.formatToDDHHMMSS(duration));
					
					totalDuration+=duration;
					double durationHour=totalDuration*1d / 3600;//单位是小时
					
					if (durationHour<=baseDuration) {
						serviceDetail.setCost(0.00);
					} else {
						if (durationFlag==false) {
							double cost=(durationHour-baseDuration)*unitCost;
							serviceDetail.setCost((double)Math.round(cost*100)/100);
							durationFlag=true;
						} else {
							double cost=serviceDetail.getDuration()*1d / 3600*unitCost;
							serviceDetail.setCost((double)Math.round(cost*100)/100);
						}
					}
					list.add(serviceDetail);
				}
				billService.calculateCostAndDuration(list);
			}
			
			//计时只有单位费用
			if(costType.equals("3")){
				Double unitCost=new Double(info.get("unit_cost").toString().trim());
				List<ServiceDetail> list=new ArrayList<ServiceDetail>();
				for (ServiceDetail serviceDetail : serviceDetails) {
					Long duration = serviceDetail.getDuration();
					serviceDetail.setDuration_str(FormatTime.formatToDDHHMMSS(duration));
					double cost=duration*1d / 3600*unitCost;
					serviceDetail.setCost((double)Math.round(cost*100)/100);
					list.add(serviceDetail);
				}
				billService.calculateCostAndDuration(list);
			} 
		}
	}
	
	
	/**4.计算每个业务账号的总费用,将其存到bill_item中**/
	public void calculateTotalCost(){
		//查询所有处于开通状态的业务账号id及其资费信息
		List<Map<String, Object>> billServiceCostInfo = billService.findBillServiceCostInfo(billYearMonth);
		if (billServiceCostInfo==null || billServiceCostInfo.size()==0) {
			return;//都没有就直接结束
		}
		
		//将计算好的结果BillItem封装到list,用于批量增加账单条目
		List<BillItem> list = new ArrayList<BillItem>();
		
		for (Map<String, Object> info : billServiceCostInfo) {
			Integer serviceId=new Integer(info.get("service_id").toString().trim());
			
			//资费类型:1.包月,2.套餐,3.计时
			String costType=info.get("cost_type").toString().trim();
			
			//从登录信息表service_detail获取数据计算业务账号的总时长和总费用
			List<BillItem> billItems = billService.getBillItemInfoToCal(serviceId, billYearMonth);
			if (billItems==null||billItems.size()==0) {
				//尽管用户没有登录,但是资费类型为包月和套餐的,每月都有基本费用
				BillItem billItem=new BillItem();
				billItem.setBill_id(new Integer(info.get("bill_id").toString().trim()));
				billItem.setService_id(serviceId);
				billItem.setCost_id(new Integer(info.get("cost_id").toString().trim()));
				billItem.setMonth_id(billYearMonth);
				billItem.setSofar_duration(0L);
				billItem.setSofar_duration_str("0秒");
				if (costType.equals("1") || costType.equals("2")) {
					billItem.setCost(new Double(info.get("base_cost").toString().trim()));
				} else {
					billItem.setCost(0.0);
				}
				list.add(billItem);
				
				continue;//结束本次循环继续下一次循环
			}
			
			double totalCost=0.00;//总费用
			long totalDuration=0L;//总时长
			BillItem billItem=billItems.get(0);
			
			if (costType.equals("1")) {
				Double baseCost=new Double(info.get("base_cost").toString().trim());
				for (BillItem item : billItems) {
					totalDuration+=item.getSofar_duration();
				}
				billItem.setSofar_duration(totalDuration);
				billItem.setSofar_duration_str(FormatTime.formatToDDHHMMSS(totalDuration));
				billItem.setCost((double)Math.round(baseCost*100)/100);
				list.add(billItem);
			} else if (costType.equals("2")) {
				Double baseCost=new Double(info.get("base_cost").toString().trim());
				for (BillItem item : billItems) {
					totalDuration+=item.getSofar_duration();
					totalCost+=item.getCost();
				}
				totalCost+=baseCost;
				billItem.setCost((double)Math.round(totalCost*100)/100);
				billItem.setSofar_duration(totalDuration);
				billItem.setSofar_duration_str(FormatTime.formatToDDHHMMSS(totalDuration));
				list.add(billItem);
			} else if (costType.equals("3")) {
				for (BillItem item : billItems) {
					totalDuration+=item.getSofar_duration();
					totalCost+=item.getCost();
				}
				billItem.setSofar_duration(totalDuration);
				billItem.setSofar_duration_str(FormatTime.formatToDDHHMMSS(totalDuration));
				billItem.setCost((double)Math.round(totalCost*100)/100);
				list.add(billItem);
			}
		}
		billService.batchAddBillItems(list);
	}
	
	
	/**5.计算每个账户账号每月的总资费**/
	public void  calculateBillTotalCost(){
		List<Integer> billIds = billService.findBillIdsByMonth(billYearMonth);
		if (billIds==null || billIds.size()==0) {
			return;
		}
		
		List<Bill> bills=new ArrayList<Bill>();
		for (Integer billId : billIds) {
			//因为是为至少开通一项业务且该业务存于开启状态的账户账号创建月账单,所以billItems一定>=1
			List<BillItem> billItems = billService.findBillItemsByBillId(billId);
			
			double totalCost=0;
			long sofar_duration=0L;
			for (BillItem billItem : billItems) {
				totalCost+=billItem.getCost();
				sofar_duration+=billItem.getSofar_duration();
			}
			
			Bill bill=new Bill();
			bill.setId(billItems.get(0).getBill_id());
			bill.setCost(totalCost);
			bill.setSofar_duration_str(FormatTime.formatToDDHHMMSS(sofar_duration));
			bills.add(bill);
		}
		billService.batchUpdateBills(bills);
	}
	
	/**6.更新业务账号的资费类型,并根据资费类型为服务器IP增加使用资费类型次数**/
	public void updateServiceCostType(){
		List<ServiceUpdateBak> serviceUpdateBaks = billService.findAllServiceUpdateBak();
		if (serviceUpdateBaks==null || serviceUpdateBaks.size()==0) {
			return;
		}
		
		for (ServiceUpdateBak serviceUpdateBak : serviceUpdateBaks) {
			//1.更新业务账号的资费类型
			Service service = serviceService.findById(serviceUpdateBak.getService_id());
			int costType = costService.findCostTypeById(service.getCost_id());
			service.setCost_id(serviceUpdateBak.getCost_id());
			serviceService.updateServiceCostType(service);
			
			//2.根据资费类型为服务器IP增加使用资费类型次数
			costType = costService.findCostTypeById(service.getCost_id());
			Host host=reportService.findByUnixHost(service.getUnix_host().trim());
			reportService.addHostTimeByType(costType,host.getHost_id());
			
			//清空service_update_bak表
			serviceService.clearServiceUpdateBak();
		}
	}
	
	/**7.计算用户在服务器上的至今累计时长**/
	public void calculateAccountSofaDurationOnHost(){
		List<DurationRank> durationRanks = billService.getDurationRankInfoToCal(billYearMonth);
		if (durationRanks==null || durationRanks.size()==0) {
			return;
		}
		
		//每月账单都没有数据就直接退出
		if (durationRanks==null||durationRanks.size()==0) {
			return;
		}
		
		for (DurationRank durationRank : durationRanks) {
			//查询数据库中是否已经创建该用户在该服务器的使用时长记录
			DurationRank dRank=billService.findDurationRankByAccountIdHostId(durationRank.getAccount_id(),durationRank.getHost_id());
			
			//为空就创建记录,否则就计算至今的累计时长
			if (dRank==null) {
				billService.addDurationRank(durationRank);
				continue;
			}
			
			//如果这个月使用时间为0,就不在需要计算了
			if(durationRank.getSofar_duration()==0) continue;
			
			long sofar_duration=durationRank.getSofar_duration()+dRank.getSofar_duration();
			dRank.setSofar_duration(sofar_duration);
			dRank.setSofar_duration_str(FormatTime.formatToDDHHMMSS(sofar_duration));
			billService.updateDurationRank(dRank);
		}
	}
	
}
