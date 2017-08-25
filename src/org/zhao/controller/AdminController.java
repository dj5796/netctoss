package org.zhao.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
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
import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.AdminPage;
import org.zhao.entity.page.RolePage;
import org.zhao.service.AdminService;
import org.zhao.service.RoleService;
import org.zhao.util.MD5Util;

@Controller
@RequestMapping("/admin")
@SessionAttributes("adminPage")
public class AdminController {
	@Resource
	/** 注入管理员业务层接口  **/
	private AdminService adminService;
	@Resource
	/** 注入角色业务层接口  **/
	private RoleService roleService;
	
	@RequestMapping("/findAdmin.do")// 访问路径
	public String find(AdminPage page, Model model) { 
		// page用于接受请求参数，model用于向页面传值
		page.setRows(adminService.findRows(page));
		model.addAttribute("adminPage", page);
		
		List<Admin> admins = adminService.findByPage(page);
		model.addAttribute("admins", admins);
		
		List<Module> modules = roleService.findAllModules();
		model.addAttribute("modules", modules);
		return "admin/admin_list"; // 转发到哪一个页面
	}
	
	@RequestMapping("/findAdminByName.do")
	public String findAdminByName(String name) {
		return "admin/admin_list";
	}

	@RequestMapping("/resetPassword.do")
	@ResponseBody
	public Map<String, Object> resetPassword(@RequestParam("ids") String ids) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("ids", buildIdList(ids));
		param.put("password", MD5Util.md5Salt("123456"));
		adminService.updatePassword(param);
	
		Map<String, Object> info = new HashMap<String, Object>();
		info.put("success", true);
		info.put("message", "密码重置成功.");
		return info;
	}
	
	private List<Integer> buildIdList(String ids) {
		if (ids == null || ids.length() == 0) return null;
		List<Integer> list = new ArrayList<Integer>();
		String[] idsArray = ids.split(",");
		for (String id : idsArray) {
			list.add(Integer.valueOf(id));
		}
		return list;
	}

	@RequestMapping("/toAddAdmin.do")
	public String toAdd(Model model) {
		RolePage page = new RolePage();
		page.setPageSize(100000);
		List<Role> roles = roleService.findByPage(page);
		model.addAttribute("roles", roles);
		return "admin/add_admin";
	}

	@RequestMapping("/addAdmin.do")
	public String add(Admin admin, Model model) {
		admin.setPassword(MD5Util.md5Salt(admin.getPassword()));
		admin.setEnrolldate(new Timestamp(System.currentTimeMillis()));
		adminService.saveAdmin(admin); // 将管理员信息传入到管理员表

		// 获取角色ID集合，逐一遍历，为管理员设置权限
		List<Integer> roleIds = admin.getRoleIds();
		for (Integer roleId : roleIds) {
			Map<String, Object> adminRoles = new HashMap<String, Object>();
			adminRoles.put("admin_id", admin.getAdmin_id());
			adminRoles.put("role_id", roleId);
			adminService.saveAdminRoles(adminRoles);
		}
		return "redirect:findAdmin.do";
	}

	@RequestMapping("/toUpdateAdmin.do")
	public String toUpdate(@RequestParam("id") int id, Model model) {
		RolePage page = new RolePage();
		page.setPageSize(100000);
		List<Role> roles = roleService.findByPage(page);
		model.addAttribute("roles", roles);

		Admin admin = adminService.findByAdminId(id);
		model.addAttribute("admin", admin);
		return "admin/update_admin";
	}

	@RequestMapping("/updateAdmin.do")
	@ResponseBody
	public String update(Admin admin, Model model) {
		adminService.updateAdmin(admin);

		adminService.deleteAdminRoles(admin.getAdmin_id());

		List<Integer> roleIds = admin.getRoleIds();
		for (Integer roleId : roleIds) {
			Map<String, Object> adminRoles = new HashMap<String, Object>();
			adminRoles.put("admin_id", admin.getAdmin_id());
			adminRoles.put("role_id", roleId);
			adminService.saveAdminRoles(adminRoles);
		}

		return "findAdmin.do";
	}

	@RequestMapping("/deleteAdmin.do")
	@ResponseBody
	public String delete(@RequestParam("admin_id") int id) {
		adminService.deleteAdminRoles(id);
		adminService.deleteAdmin(id);
		return "findAdmin.do";
	}
	
	@RequestMapping("/checkAdminName.do")
	@ResponseBody
	public boolean checkAdminName(@RequestParam("name") String name) {
		Admin admin = adminService.findAdminByName(name);
		if (admin==null) {
			return true;
		}
		return false;
	}
	
	@RequestMapping("/checkAdminCode.do")
	@ResponseBody
	public boolean checkAdminCode(@RequestParam("adminCode") String adminCode) {
		Admin admin = adminService.findAdminByCode(adminCode);
		if (admin==null) {
			return true;
		}
		return false;
	}

}
