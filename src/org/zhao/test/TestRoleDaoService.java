package org.zhao.test;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.zhao.dao.RoleDao;
import org.zhao.entity.page.Page;
import org.zhao.entity.page.RolePage;
import org.zhao.service.RoleService;

public class TestRoleDaoService {
	
	private RoleDao roleDao;
	
	private RoleService roleService;
	
	@Before
	public void init(){
	     //启动spring容器
	     ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext.xml");
	     //默认的id是首字母小写的映射器名
//	     roleDao=context.getBean("roleDao", RoleDao.class);
	     roleService=context.getBean("roleService", RoleService.class);
//	     System.out.println("roleDao=========="+roleDao);
//	     System.out.println("roleService=========="+roleService);
	}
	
	@Test
	public void isAdminUseRole(){
		int count = roleService.isAdminUseRole(500);
		System.out.println(count);
	}

	@Test
	public void findRows2(){
		Page page=new RolePage();
		int rows = roleService.findRows(page);
		System.out.println(rows);
	}
	
	@Test
	public void findRows(){
		Page page=new RolePage();
		System.out.println(page);
		int rows = roleDao.findRows(page);
		System.out.println(rows);
	}
}
