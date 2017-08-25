package org.zhao.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.zhao.entity.Account;
import org.zhao.entity.Bill;
import org.zhao.entity.BillItem;
import org.zhao.entity.DurationRank;
import org.zhao.entity.ServiceDetail;
import org.zhao.entity.ServiceUpdateBak;
import org.zhao.entity.page.Page;

public interface BillDao {
	
	/**根据登入登出时间,计算service_detail表中每月的时长**/
	void calculateMonthDuration(String billYearMonth);
	
	/**根据service_detail表中的时长,计算费用**/
	void calculateCostAndDuration(List<ServiceDetail> serviceDetails);
	
	/**查询所有处于开通状态的账单id,业务账号id及其资费信息**/
	List<Map<String, Object>> findBillServiceCostInfo(String billYearMonth);
	
	/**查询某个业务在某年某月份的登录详情信息**/
	List<ServiceDetail> findServiceDetailByBillMonth(@Param("billYearMonth")String currYearMonth,@Param("service_id")Integer service_id);

	/**查询账户账号状态为开通并且至少有一个业务账号为开通状态的账户**/
	List<Account> findUsingServiceAccounts();
	
	/**批量创建月账单**/
	void batchAddBills(List<Bill> bills);
	
	/**从service_detail表中获取数据进行计算,以便存到bill_item中**/
	List<BillItem> getBillItemInfoToCal(@Param("serviceId")Integer serviceId,@Param("billYearMonth")String billYearMonth);

	/**批量增加账单条目**/
	void batchAddBillItems(List<BillItem> billItems);
	
	/**查找某一月份的所有账单id**/
	List<Integer> findBillIdsByMonth(String billYearMonth);
	
	/**更新批量账单信息**/
	void batchUpdateBills(List<Bill> bills);
	
	/**查询所有需要更新业务id和资费id**/
	List<ServiceUpdateBak> findAllServiceUpdateBak();
	
	/**获取用户每月每项业务使用时长,来计算用户在某一个服务器上至今积累的时长**/
	List<DurationRank> getDurationRankInfoToCal(String billYearMonth);
	
	/**根据账户id和服务器id查找DurationRank**/
	DurationRank findDurationRankByAccountIdHostId(@Param("account_id")Integer account_id, @Param("host_id")Integer host_id);
	
	/**创建DurationRank**/
	void addDurationRank(DurationRank durationRank);
	
	/**更新durationRank时长信息**/
	void updateDurationRank(DurationRank durationRank);
	
	
	
	
	/**根据page查找有多少条记录**/
	int findRowsFromBill(Page page);
	
	/**分页查找账单**/
	List<Bill> findBillsByPage(Page page);
	
	/**根据账单idbillId查找所有的账单条目**/
	List<BillItem> findBillItemsByBillId(Integer billId);
	
	/**根据账单条目id查找账单项**/
	Map<String, Object> findBillItemByItemId(Integer itemId);
	
	/**根据账单id查找账单**/
	Bill findBillByBillId(Integer billId);

	/**一个账单有多少账单项**/
	int findRowsFromBillItem(Integer billId);
	
	/**根据账单id进行分页查找帐单条目**/
	List<Map<String, Object>> findBillItemsByBillIdPage(@Param("billId") Integer billId,@Param("page") Page page);

	/**一个帐单项有多少回登录登出信息**/
	int findRowsFromServiceDetail(@Param("itemId") Integer itemId,@Param("page") Page page);
	
	/**根据帐单条目itemId进行分页查找账单业务详情**/
	List<ServiceDetail> findServiceDetailsByItemIdPage(@Param("itemId") Integer itemId,@Param("page") Page page);


	

	
	
	
}
