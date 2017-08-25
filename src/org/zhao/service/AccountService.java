package org.zhao.service;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Account;
import org.zhao.entity.page.Page;

public interface AccountService {

	List<Account> findByPage(Page page);

	int findRows(Page page);

	void updateStatus(Account account);
	
	Account findById(Integer id);

	void update(Account account);

	void save(Account account);

	Account findByIdcardNo(String idcardNo);

	Account findAccountByLoginName(String loginName);

	Map<String, Object> getAccountInfoById(int id);

	List<Account> findAll();
	
}
