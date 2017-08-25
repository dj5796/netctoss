package org.zhao.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zhao.entity.Bill;
import org.zhao.entity.ServiceDetail;
import org.zhao.entity.page.BillPage;
import org.zhao.service.BillService;

@Controller
@RequestMapping("/bill")
@SessionAttributes({"billPage","billItemPage","billDetailPage"})
public class BillController extends BaseController {

	@Resource
	private BillService billService;

	/**1.查看账单管理**/
	@RequestMapping("/findBill.do")
	public String findBill(BillPage page, Model model) {
		page.setRows(billService.findRowsFromBill(page));
		model.addAttribute("billPage", page);
		List<Bill> bills = billService.findBillsByPage(page);
		model.addAttribute("bills", bills);
		return "bill/bill_list";
	}
	
	/**2.查看账单明细**/
	@RequestMapping("/findBillItem.do")
	public String billItem(@RequestParam("billId")Integer billId,BillPage page,Model model,HttpSession session) {
		Bill bill=billService.findBillByBillId(billId);
		model.addAttribute("bill", bill);
		//使用session在多个页面间传值,以便在后面使用账户账号
		session.setAttribute("login_name",bill.getLogin_name());
		
		//根据账单id进行分页查找帐单条目
		page.setRows(billService.findRowsFromBillItem(billId));
		model.addAttribute("billItemPage", page);
		model.addAttribute("billId", billId);
		
		List<Map<String, Object>> billItems = billService.findBillItemsByBillIdPage(billId,page);
		model.addAttribute("billItems", billItems);
		return "bill/bill_item";
	}
	
	/**3.查看业务详单**/
	@RequestMapping("/findBillDetail.do")
	public String billDetail(@RequestParam("itemId")Integer itemId,BillPage page,Model model) {
		Map<String, Object> billItem=billService.findBillItemByItemId(itemId);
		model.addAttribute("billItem", billItem);
		
		//根据帐单条目itemId进行分页查找账单业务详情
		page.setBillYearMonth(billItem.get("month_id").toString().trim());
		page.setRows(billService.findRowsFromServiceDetail(itemId,page));
		model.addAttribute("billDetailPage", page);
		model.addAttribute("itemId", itemId);
		
		List<ServiceDetail> serviceDetails = billService.findServiceDetailsByItemIdPage(itemId,page);
		model.addAttribute("serviceDetails", serviceDetails);
		return "bill/bill_service_detail";
	}
	
}
