package org.zhao.controller;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zhao.entity.Account;
import org.zhao.entity.page.AccountPage;
import org.zhao.service.AccountService;
import org.zhao.service.ServiceService;
import org.zhao.util.MD5Util;

@Controller
@RequestMapping("/account")
@SessionAttributes("accountPage")
public class AccountController extends BaseController {

	@Resource
	private AccountService accountService;

	@Resource
	private ServiceService serviceService;

	@RequestMapping("/findAccount.do")
	public String find(AccountPage page, Model model) {
		
		//int i = 1/0; // 模拟系统故障
		
		page.setRows(accountService.findRows(page));
		model.addAttribute("accountPage", page);

		List<Account> list = accountService.findByPage(page);
		model.addAttribute("accounts", list);
		
		return "account/account_list";
	}

	@RequestMapping("/startAccount.do")
	@ResponseBody
	public boolean updateStart(@RequestParam("account_id") int id) {
		try {
			// 开通账务账号
			Account a = new Account();
			a.setAccount_id(id);
			a.setStatus("0");
			accountService.updateStatus(a);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@RequestMapping("/pauseAccount.do")
	@ResponseBody
	public boolean updatePause(@RequestParam("account_id") int id) {
		try {
			// 暂停账务账号，将账务账号的状态改为1
			Account account = new Account();
			account.setAccount_id(id);
			account.setStatus("1");
			accountService.updateStatus(account);
			
			// 暂停其下属的业务账号，将业务账号的状态改为1
			serviceService.pauseByAccount(id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@RequestMapping("/deleteAccount.do")
	@ResponseBody
	public boolean updateDelete(@RequestParam("account_id") int id) {
		try {
			// 删除账务账号，将账务账号的状态改为2
			Account account = new Account();
			account.setAccount_id(id);
			account.setStatus("2");
			accountService.updateStatus(account);
			// 删除其下属的业务账号，将业务账号的状态改为2
			serviceService.deleteByAccount(id);
			// 删除成功，返回true 
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			// 出现异常，删除失败，返回FALSE
			return false;
		}
	}

	@RequestMapping("/toUpdateAccount.do")
	public String toUpdate(@RequestParam("account_id") int id, Model model) {
		Map<String, Object> map = accountService.getAccountInfoById(id);
		model.addAttribute("account", map);
		return "account/update_account";
	}

	@RequestMapping("/updateAccount.do")
	@ResponseBody
	public Map<String, Object> update(Account account,String oldPassword) {
		Map<String, Object> result=new HashMap<String, Object>();
		
		//要修改密码时,要判断旧密码是否与数据库的密码相同
		if (oldPassword!=null && !oldPassword.equals("")) {
			String originalPassword = accountService.findById(account.getAccount_id()).getLogin_passwd();
			oldPassword=MD5Util.md5Salt(oldPassword.trim());
			//旧密码错误
			if (!originalPassword.equals(oldPassword)) {
				result.put("success", false);
				result.put("message", "旧密码错误,请检查!");
				return result;
			}
			//旧密码正确,进行MD5加密处理
			account.setLogin_passwd(MD5Util.md5Salt(account.getLogin_passwd()));
		}
		
		//不修改密码,就直接更新信息
		accountService.update(account);
		result.put("success", true);
		result.put("message", "修改账号信息成功!");
		return result;
	}

	@RequestMapping("/toAddAccount.do")
	public String toAdd() {
		return "account/add_account";
	}
	
	@RequestMapping("/findAccountByLoginName.do")
	@ResponseBody
	public Map<String, Object> findAccountByLoginName(String loginName) {
		Account account=accountService.findAccountByLoginName(loginName);
		Map<String, Object> result=new HashMap<String, Object>();
		if (account==null) {
			result.put("success",true);
			result.put("message", "账号 \""+loginName+"\" 尚未开通,可以注册!");
		} else {
			result.put("success",false);
			result.put("message", "无效的登录账号，账号 \""+loginName+"\" 已经存在!");
		}
		return result;
	}

	@RequestMapping("/searchAccount.do")
	@ResponseBody
	public Account searchAccount(String idcardNo) {
		return accountService.findByIdcardNo(idcardNo);
	}
	
	@RequestMapping("/addAccount.do")
	@ResponseBody
	public boolean add(Account account) {
		try {
			account.setStatus("0");
			account.setCreate_date(new Timestamp(System.currentTimeMillis()));
			account.setLogin_passwd(MD5Util.md5Salt(account.getLogin_passwd()));
			accountService.save(account);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@RequestMapping("/accountDetail.do")
	public String accountDetail(String accountId,Model model) {
		Map<String, Object> account = accountService.getAccountInfoById(new Integer(accountId));
		model.addAttribute("account",account);
		return "account/account_detail";
	}

}
