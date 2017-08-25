package org.zhao.dao;

import java.util.List;

import org.zhao.entity.Cost;
import org.zhao.entity.page.Page;

public interface CostDao {

	List<Cost> findAllIsUsing();

	void save(Cost cost);

	Cost findById(int id);

	void update(Cost cost);

	void delete(int id);

	List<Cost> findByPage(Page page);

	int findRows();

	void startCost(Integer id);
	
	int findCostTypeById(int id);

}
