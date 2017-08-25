package org.zhao.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zhao.entity.DurationRank;
import org.zhao.entity.Host;
import org.zhao.entity.page.ReportPage;
import org.zhao.service.ReportService;

@Controller
@RequestMapping("/report")
@SessionAttributes({"custPage","custs","hostPage","hosts","durationPage","durationRanks"})
public class ReportController extends BaseController {

	@Resource
	private ReportService reportService;

	@RequestMapping("/findReport.do")
	public String findReport(ReportPage page,Model model) {
		int type=page.getType();
		int page0=page.getPage0();
		int page1=page.getPage1();
		int page2=page.getPage2();
		if (type==-1) {
			/**刚开始时为-1三个都查询**/
			
			/**type==0:客户使用时长报表:显示每位客户每月的累计时间,数据以时间和客户id升序排序**/
			page.setRows(reportService.findBillRows());
			List<Map<String, Object>> custs = reportService.findCustDurationByPage(page);
			model.addAttribute("custPage", page);
			model.addAttribute("custs", custs);
			
			/**type==1:时长排行榜:显示每台服务器上累计时长最高的前三名客户**/
			page=new ReportPage();
			page.setRows(reportService.findDurationRankRows());
			List<DurationRank> durationRanks=reportService.findDurationRanksByPage(page);
			model.addAttribute("durationPage", page);
			model.addAttribute("durationRanks", durationRanks);
			
			/**type==2:资费使用率报表:显示每台服务器上每种资费标准的使用次数**/
			page=new ReportPage();
			page.setRows(reportService.findHostRows());
			List<Host> hosts = reportService.findCostUsingTimesByPage(page);
			model.addAttribute("hostPage", page);
			model.addAttribute("hosts", hosts);
			
			type=0;
		} else if (type==0) {
			page.setCurrentPage(page0);
			page.setRows(reportService.findBillRows());
			List<Map<String, Object>> custs = reportService.findCustDurationByPage(page);
			model.addAttribute("custPage", page);
			model.addAttribute("custs", custs);
		} else if (type==1) {
			page.setCurrentPage(page1);
			page.setRows(reportService.findDurationRankRows());
			List<DurationRank> durationRanks=reportService.findDurationRanksByPage(page);
			model.addAttribute("durationPage", page);
			model.addAttribute("durationRanks", durationRanks);
		} else if (type==2) {
			page.setCurrentPage(page2);
			page.setRows(reportService.findHostRows());
			List<Host> hosts = reportService.findCostUsingTimesByPage(page);
			model.addAttribute("hostPage", page);
			model.addAttribute("hosts", hosts);
		}
		
		model.addAttribute("type", type);
		return "report/report_list";
	}
	
}
