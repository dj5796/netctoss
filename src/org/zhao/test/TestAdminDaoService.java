package org.zhao.test;

import java.util.List;
import java.util.UUID;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.zhao.dao.AdminDao;
import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.service.AdminService;

public class TestAdminDaoService {
	
	private AdminDao adminDao;
	
	private AdminService adminService;
	
	@Before
	public void init(){
	     //启动spring容器
	     ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext.xml");
	     //默认的id是首字母小写的映射器名
	     adminDao=context.getBean("adminDao", AdminDao.class);
	     adminService=context.getBean("adminService", AdminService.class);
	}
	
	@Test
	public void getAdminInfoByCode(){
		Admin admin = adminDao.getAdminInfoByAdminId(5000);
		System.out.println(admin);
	}
	
	@Test
	public void updateAdmin(){
		Admin admin = adminDao.findByAdminId(2000);
		System.out.println(admin);
		String token=UUID.randomUUID().toString();
		admin.setToken(token);
		adminDao.updateAdmin(admin);
		admin = adminDao.findByAdminId(2000);
		System.out.println(admin);
	}
	
	@Test
	public void findModulesByAdminId(){
		List<Module> modules = adminDao.findModulesByAdminId(5000);
		for (Module module : modules) {
			System.out.println(module);
		}
	}
	
	@Test
	public void findAdminByName2(){
		Admin admin = adminService.findAdminByName("admin");
		System.out.println(admin);
	}

	@Test
	public void findAdminByName(){
		Admin admin = adminDao.findAdminByName("ADMIN");
		System.out.println(admin);
	}
}
