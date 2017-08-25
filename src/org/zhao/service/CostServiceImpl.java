package org.zhao.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.zhao.dao.CostDao;
import org.zhao.entity.Cost;
import org.zhao.entity.page.Page;

@Service("costService")
public class CostServiceImpl implements CostService {

	@Resource
	private CostDao costDao;

	public List<Cost> findAllIsUsing() {
		List<Cost> list = costDao.findAllIsUsing();
		return list;
	}

	public void save(Cost cost) {
		costDao.save(cost);
	}

	public Cost findById(int id) {
		Cost cost = costDao.findById(id);
		return cost;
	}

	public void update(Cost cost) {
		costDao.update(cost);
	}

	public void delete(int id) {
		costDao.delete(id);
	}

	public List<Cost> findByPage(Page page) {
		int rows = findRows();
		page.setRows(rows);
		List<Cost> list = costDao.findByPage(page);
		return list;
	}

	public int findRows() {
		int rows = costDao.findRows();
		return rows;
	}

	public void startCost(Integer id) {
		costDao.startCost(id);
	}

	public int findCostTypeById(int id) {
		return costDao.findCostTypeById(id);
	}

}
