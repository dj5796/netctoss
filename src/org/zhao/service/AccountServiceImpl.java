package org.zhao.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.zhao.dao.AccountDao;
import org.zhao.entity.Account;
import org.zhao.entity.page.Page;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

	@Resource
	private AccountDao accountDao;

	public List<Account> findByPage(Page page) {
		int rows = findRows(page);
		page.setRows(rows);
		List<Account> list = accountDao.findByPage(page);
		return list;
	}

	public int findRows(Page page) {
		int rows = accountDao.findRows(page);
		return rows;
	}

	public void updateStatus(Account account) {
		accountDao.updateStatus(account);
	}

	public Account findById(Integer id) {
		Account account = accountDao.findById(id);
		return account;
	}

	public void update(Account account) {
		accountDao.update(account);
	}

	public void save(Account account) {
		accountDao.save(account);
	}

	public Account findByIdcardNo(String idcardNo) {
		Account account = accountDao.findByIdcardNo(idcardNo);
		return account;
	}

	public Account findAccountByLoginName(String loginName) {
		return accountDao.findAccountByLoginName(loginName);
	}

	public Map<String, Object> getAccountInfoById(int id) {
		return accountDao.getAccountInfoById(id);
	}

	public List<Account> findAll() {
		return accountDao.findAll();
	}
	
	

}
