package org.zhao.controller;

import java.sql.Timestamp;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zhao.entity.Cost;
import org.zhao.entity.page.CostPage;
import org.zhao.service.CostService;

@Controller
@RequestMapping("/cost")
@SessionAttributes("costPage")
public class CostController extends BaseController {

	@Resource
	private CostService costService;

	@RequestMapping("/findCost.do")
	public String find(CostPage page, Model model) {
		page.setRows(costService.findRows());
		model.addAttribute("costPage", page);
		List<Cost> list = costService.findByPage(page);
		model.addAttribute("costs", list);
		return "cost/cost_list";
	}

	@RequestMapping("/toAddCost.do")
	public String toAdd() {
		return "cost/add_cost";
	}

	@RequestMapping("/addCost.do")
	@ResponseBody
	public String add(Cost cost) {
		cost.setStatus("1");
		cost.setCreatime(new Timestamp(System.currentTimeMillis()));
		costService.save(cost);
		return "findCost.do";
	}

	@RequestMapping("/toUpdateCost.do")
	public String toUpdate(@RequestParam("id") int id, Model model) {
		Cost cost = costService.findById(id);
		model.addAttribute("cost", cost);
		return "cost/update_cost";
	}

	@RequestMapping("/updateCost.do")
	@ResponseBody
	public String update(Cost cost) {
		costService.update(cost);
		return "findCost.do";
	}

	@RequestMapping("/deleteCost.do")
	@ResponseBody
	public String delete(@RequestParam("id") int id) {
		costService.delete(id);
		return "findCost.do";
	}
	
	@RequestMapping("/startCost.do")
	@ResponseBody
	public String startCost(@RequestParam("id") int id) {
		costService.startCost(id);
		return "findCost.do";
	}
	
	@RequestMapping("/costDetail.do")
	public String costDetail(@RequestParam("id") int id,Model model) {
		Cost cost = costService.findById(id);
		model.addAttribute("cost", cost);
		return "cost/cost_detail";
	}
	
	
	
	
	
	
	

}
