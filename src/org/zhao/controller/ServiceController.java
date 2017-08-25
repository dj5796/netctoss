package org.zhao.controller;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zhao.entity.Account;
import org.zhao.entity.Cost;
import org.zhao.entity.Host;
import org.zhao.entity.Service;
import org.zhao.entity.page.ServicePage;
import org.zhao.service.AccountService;
import org.zhao.service.CostService;
import org.zhao.service.ReportService;
import org.zhao.service.ServiceService;
import org.zhao.util.MD5Util;

@Controller
@RequestMapping("/service")
@SessionAttributes("servicePage")
public class ServiceController extends BaseController {

	@Resource
	private ServiceService serviceService;

	@Resource
	private AccountService accountService;

	@Resource
	private CostService costService;
	
	@Resource
	private ReportService reportService;

	@RequestMapping("/findService.do")
	public String find(ServicePage page, Model model) {
		page.setRows(serviceService.findRows(page));
		model.addAttribute("servicePage", page);

		List<Map<String, Object>> list = serviceService.findByPage(page);
		model.addAttribute("services", list);

		return "service/service_list";
	}

	@RequestMapping("/startService.do")
	@ResponseBody
	public Map<String, Object> updateStart(@RequestParam("service_id") int id) {
		Map<String, Object> info = new HashMap<String, Object>();

		// 判断对应的账务账号是否处于开通态
		Service service = serviceService.findById(id);
		Account account = accountService.findById(service.getAccount_id());
		if (!account.getStatus().equals("0")) {
			info.put("success", false);
			info.put("message", "账务账号没有开通，不允许开通当前业务账号!");
			return info;
		}

		Service s = new Service();
		s.setService_id(id);
		s.setStatus("0");
		try {
			serviceService.updateStatus(s);
			info.put("success", true);
			info.put("message", "开通此业务成功!");
		} catch (Exception e) {
			e.printStackTrace();
			info.put("success", false);
			info.put("message", "开通此业务失败，系统发生异常!");
		}
		return info;
	}

	@RequestMapping("/pauseService.do")
	@ResponseBody
	public Map<String, Object> updatePause(@RequestParam("service_id") int id) {
		Map<String, Object> info = new HashMap<String, Object>();

		Service service = new Service();
		service.setService_id(id);
		service.setStatus("1");
		try {
			serviceService.updateStatus(service);
			info.put("success", true);
			info.put("message", "暂停此业务成功!");
		} catch (Exception e) {
			e.printStackTrace();
			info.put("success", false);
			info.put("message", "暂停失败，系统异常,请稍后重试!");
		}
		return info;
	}

	@RequestMapping("/deleteService.do")
	@ResponseBody
	public Map<String, Object> updateDelete(@RequestParam("service_id") int id) {
		Map<String, Object> info = new HashMap<String, Object>();
		Service service = new Service();
		service.setService_id(id);
		service.setStatus("2");
		try {
			serviceService.updateStatus(service);
			info.put("success", true);
			info.put("message", "删除此业务成功!");
		} catch (Exception e) {
			e.printStackTrace();
			info.put("success", false);
			info.put("message", "删除失败，系统异常,请稍后重试!");
		}
		return info;
	}

	@RequestMapping("/toAddService.do")
	public String toAdd(Model model) {
		List<Cost> list = costService.findAllIsUsing();
		model.addAttribute("costs", list);
		return "service/add_service";
	}

	@RequestMapping("/findAccount.do")
	@ResponseBody
	public Account findAccount(@RequestParam("idcardNo") String idcardNo) {
		return accountService.findByIdcardNo(idcardNo);
	}

	@RequestMapping("/addService.do")
	public String add(Service service) {
		//保存业务账号信息
		service.setStatus("0");
		service.setLogin_passwd(MD5Util.md5Salt(service.getLogin_passwd()));
		service.setCreate_date(new Timestamp(System.currentTimeMillis()));
		serviceService.save(service);
		
		//根据资费类型为服务器IP增加使用资费类型次数
		Host host=reportService.findByUnixHost(service.getUnix_host().trim());
		//1.包月,2.套餐,3.计时
		int costType = costService.findCostTypeById(service.getCost_id());
		if(host==null){
			Host host2=new Host();
			if (costType==1) {
				host2.setMonthly(1);
			} else if (costType==2) {
				host2.setMeal(1);
			} else {
				host2.setHourly(1);
			}
			host2.setUnix_host(service.getUnix_host());
			reportService.addHost(host2);
		} else {
			reportService.addHostTimeByType(costType,host.getHost_id());
		}
		
		return "redirect:findService.do";
	}

	@RequestMapping("/toUpdateService.do")
	public String toUpdate(@RequestParam("id") int id, Model model) {
		Service service = serviceService.findById(id);
		model.addAttribute("service", service);
		List<Cost> list = costService.findAllIsUsing();
		model.addAttribute("costs", list);
		return "service/update_service";
	}
	
	//修改资费类型，并保存成功后，新的资费标准从下月生效
	@RequestMapping("/updateService.do")
	@ResponseBody
	public boolean updateService(Service service) {
		try {
			Service service2 = serviceService.findFromBak(service.getService_id());
			if (service2==null) {
				serviceService.updateToAdd(service);
			} else {
				serviceService.updateCostId(service);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@RequestMapping("/checkOS_UsernameByIP.do")
	@ResponseBody
	public boolean checkOS_UsernameByIP(String os_username,String ip){
		try {
			List<String> names = serviceService.findOS_UsernameByIP(ip);
			if (names==null||names.size()==0) {
				return true;
			}
			for (String name : names) {
				if (os_username.trim().equalsIgnoreCase(name)) {
					return false;
				}
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@RequestMapping("/serviceDetail.do")
	public String serviceDetail(String serviceId,Model model){
		Map<String, Object> service = serviceService.getServiceDetailInfo(new Integer(serviceId.trim()));
		model.addAttribute("service", service);
		return "service/service_detail";
	}
	
}
