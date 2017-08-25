package org.zhao.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zhao.entity.Admin;
import org.zhao.service.AdminService;
import org.zhao.util.MD5Util;

@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private AdminService adminService;

	@RequestMapping("/viewPersonalInfo.do")
	public String viewPersonalInfo(HttpSession session) {
		Admin admin=(Admin)session.getAttribute("admin");
		Integer adminId = admin.getAdmin_id();
		admin = adminService.getAdminInfoByAdminId(adminId);
		session.setAttribute("admin", admin);
		return "user/user_info";
	}
	
	@RequestMapping("/updatePersonalInfo.do")
	@ResponseBody
	public boolean updatePersonalInfo(Admin admin) {
		try {
			adminService.updateAdmin(admin);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@RequestMapping("/changePassword.do")
	public String changePassword() {
		return "user/user_modi_pwd";
	}
	
	@RequestMapping("/updatePassword.do")
	@ResponseBody
	public Map<String, Object> updatePassword(String oldPassword,String newPassword,HttpSession session) {
		Admin admin=(Admin)session.getAttribute("admin");
		admin=adminService.findByAdminId(admin.getAdmin_id());
		
		oldPassword=MD5Util.md5Salt(oldPassword.trim());
		newPassword=MD5Util.md5Salt(newPassword.trim());
		
		Map<String, Object> result=new HashMap<String, Object>();
		if (!admin.getPassword().equals(oldPassword)) {
			result.put("success", false);
			result.put("message", "旧密码错误,请检查!");
			return result;
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		List<Integer> ids = new ArrayList<Integer>();
		ids.add(admin.getAdmin_id());
		map.put("ids", ids);
		map.put("password", newPassword);
		adminService.updatePassword(map);
		result.put("success", true);
		result.put("message", "密码更改成功!");
		return result;
	}
	

	

}
