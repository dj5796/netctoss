package org.zhao.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.zhao.entity.Cost;
import org.zhao.entity.page.CostPage;
import org.zhao.service.CostService;

public class TestCostDaoService {
	
	private CostService costService;
	
	@Before
	public void init(){
	     //启动spring容器
	     ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext.xml");
	     //默认的id是首字母小写的映射器名
	     costService=context.getBean("costService", CostService.class);
	}
	
	@Test
	public void findByPage(){
		List<Cost> list = costService.findByPage(new CostPage());
		for (Cost cost : list) {
			System.out.println(cost);
		}
	}
	
	@Test
	public void updateStatus(){
		costService.startCost(134);
	}
	
}
