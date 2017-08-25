package org.zhao.test;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.zhao.dao.ServiceDao;
import org.zhao.entity.Service;
import org.zhao.entity.page.Page;
import org.zhao.entity.page.ServicePage;
import org.zhao.service.ServiceService;

public class TestServiceDaoService {
	
	private ServiceDao serviceDao;
	
	private ServiceService serviceService;
	
	@Before
	public void init(){
	     //启动spring容器
	     ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext.xml");
	     //默认的id是首字母小写的映射器名
	     serviceDao=context.getBean("serviceDao", ServiceDao.class);
	     serviceService=context.getBean("serviceService", ServiceService.class);
	     //System.out.println("roleDao=========="+serviceDao);
	     //System.out.println("roleService=========="+serviceServ);
	}
	
	@Test
	public void getServiceDetailInfo(){
		Map<String, Object> info = serviceService.getServiceDetailInfo(3047);
		Set<Entry<String, Object>> entrySet = info.entrySet();
		for (Entry<String, Object> entry : entrySet) {
			System.out.println(entry);
		}
	}
	
	@Test
	public void updateCostId(){
		Service service=new Service();
		service.setCost_id(1);
		service.setService_id(2005);
		serviceService.updateCostId(service);
	}
	
	@Test
	public void findOS_UsernameByIP(){
		List<String> list = serviceDao.findOS_UsernameByIP("192.168.0.26");
		for (String name : list) {
			System.out.println(name);
		}
	}
	
	@Test
	public void findByPage(){
		Page page=new ServicePage();
		List<Map<String, Object>> list = serviceDao.findByPage(page);
		for (Map<String, Object> map : list) {
			Set<Entry<String, Object>> entrySet = map.entrySet();
			for (Entry<String, Object> entry : entrySet) {
				System.out.println(entry);
			}
		}
	}
	
}
