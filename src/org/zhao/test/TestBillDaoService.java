package org.zhao.test;


import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.zhao.entity.BillItem;
import org.zhao.service.BillService;
import org.zhao.util.CalendarUitl;

public class TestBillDaoService {
	
	
	private BillService billService;
	
	@Before
	public void init(){
		//启动spring容器
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext.xml");
		//默认的id是首字母小写的映射器名
		billService=context.getBean("billService", BillService.class);
	}
	
	String billYearMonth=CalendarUitl.getBillYearMonth();
	
	@Test
	public void test(){
		List<BillItem> billItems = billService.getBillItemInfoToCal(3001, billYearMonth);
		for (BillItem billItem : billItems) {
			System.out.println(billItem);
		}
	}
	
	
}