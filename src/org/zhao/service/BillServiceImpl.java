package org.zhao.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.zhao.dao.BillDao;
import org.zhao.entity.Account;
import org.zhao.entity.Bill;
import org.zhao.entity.BillItem;
import org.zhao.entity.DurationRank;
import org.zhao.entity.ServiceDetail;
import org.zhao.entity.ServiceUpdateBak;
import org.zhao.entity.page.Page;

@Service("billService")
public class BillServiceImpl implements BillService {

	@Resource
	private BillDao billDao;
	
	public void calculateMonthDuration(String billYearMonth) {
		billDao.calculateMonthDuration(billYearMonth);		
	}

	public void calculateCostAndDuration(List<ServiceDetail> serviceDetails) {
		billDao.calculateCostAndDuration(serviceDetails);
	}

	public List<Map<String, Object>> findBillServiceCostInfo(String billYearMonth) {
		return billDao.findBillServiceCostInfo(billYearMonth);
	}

	public void batchAddBills(List<Bill> bills) {
		billDao.batchAddBills(bills);
	}

	public List<BillItem> getBillItemInfoToCal(Integer serviceId,String billYearMonth) {
		return billDao.getBillItemInfoToCal(serviceId,billYearMonth);
	}

	public void batchAddBillItems(List<BillItem> billItems) {
		billDao.batchAddBillItems(billItems);
	}

	public List<Integer> findBillIdsByMonth(String billYearMonth) {
		return billDao.findBillIdsByMonth(billYearMonth);
	}

	public void batchUpdateBills(List<Bill> bills) {
		billDao.batchUpdateBills(bills);
	}

	public int findRowsFromBill(Page page) {
		return billDao.findRowsFromBill(page);
	}

	public List<Bill> findBillsByPage(Page page) {
		return  billDao.findBillsByPage(page);
	}


	public Map<String, Object> findBillItemByItemId(Integer itemId){
		return billDao.findBillItemByItemId(itemId);
	}

	public int findRowsFromBillItem(Integer billId) {
		return billDao.findRowsFromBillItem(billId);
	}
	
	public Bill findBillByBillId(Integer billId) {
		return billDao.findBillByBillId(billId);
	}

	public List<Map<String, Object>> findBillItemsByBillIdPage(Integer billId, Page page) {
		return billDao.findBillItemsByBillIdPage(billId,page);
	}

	public int findRowsFromServiceDetail(Integer itemId,Page page) {
		return billDao.findRowsFromServiceDetail(itemId,page);
	}
	
	public List<ServiceDetail> findServiceDetailsByItemIdPage(Integer itemId, Page page) {
		return billDao.findServiceDetailsByItemIdPage(itemId,page);
	}

	public List<BillItem> findBillItemsByBillId(Integer id){
		return billDao.findBillItemsByBillId(id);
	}

	public List<ServiceDetail> findServiceDetailByBillMonth(String billYearMonth, Integer service_id) {
		return billDao.findServiceDetailByBillMonth(billYearMonth, service_id);
	}

	public List<Account> findUsingServiceAccounts() {
		return billDao.findUsingServiceAccounts();
	}

	public List<ServiceUpdateBak> findAllServiceUpdateBak() {
		return billDao.findAllServiceUpdateBak();
	}

	public List<DurationRank> getDurationRankInfoToCal(String billYearMonth) {
		return billDao.getDurationRankInfoToCal(billYearMonth);
	}

	public DurationRank findDurationRankByAccountIdHostId(Integer account_id, Integer host_id) {
		return billDao.findDurationRankByAccountIdHostId(account_id, host_id);
	}

	public void addDurationRank(DurationRank durationRank) {
		billDao.addDurationRank(durationRank);
	}

	public void updateDurationRank(DurationRank durationRank) {
		billDao.updateDurationRank(durationRank);
	}

	


	

}
