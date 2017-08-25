package org.zhao.test;

import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.zhao.dao.AccountDao;
import org.zhao.entity.Account;
import org.zhao.service.AccountService;
import org.zhao.util.MD5Util;

public class TestAccountDaoService {
	private AccountDao accountDao;
	
	private AccountService accountService;
	
	@Before
	public void init(){
	     //启动spring容器
	     ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext.xml");
	     //默认的id是首字母小写的映射器名
	     accountDao=context.getBean("accountDao", AccountDao.class);
	     accountService=context.getBean("accountService", AccountService.class);
	}
	
	@Test
	public void update(){
		Account account = accountDao.findById(2026);
		System.out.println(account);
		
		account.setLogin_passwd(MD5Util.md5Salt("555555555"));
		account.setEmail("5555555555@qq.com");
		accountService.update(account);
		
		account = accountDao.findById(2026);
		System.out.println(account);
	}
	
	@Test
	public void getAccountInfoById(){
		Map<String, Object> map = accountDao.getAccountInfoById(2002);
		System.out.println("size=========="+map.size());
		Set<Entry<String, Object>> entrySet = map.entrySet();
		for (Entry<String, Object> entry : entrySet) {
			System.out.println(entry);
		}
	}
	
	@Test
	public void findById(){
		Account account = accountDao.findById(2002);
		System.out.println(account);
	}
	
	@Test
	public void findByIdcardNo(){
		Account account = accountDao.findByIdcardNo("");
		System.out.println(account);
	}
	
	@Test
	public void findAccountByLoginName(){
		Account account=accountService.findAccountByLoginName("");
		System.out.println(account);
	}
	
}
