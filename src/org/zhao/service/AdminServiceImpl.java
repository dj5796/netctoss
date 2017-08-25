package org.zhao.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.zhao.dao.AdminDao;
import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.page.Page;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

	@Resource
	private AdminDao adminDao;

	public List<Admin> findByPage(Page page) {
		int rows = findRows(page);
		page.setRows(rows);
		List<Admin> list = adminDao.findByPage(page);
		return list;
	}

	public int findRows(Page page) {
		int rows = adminDao.findRows(page);
		return rows;
	}
	
	public void updatePassword(Map<String, Object> param) {
		adminDao.updatePassword(param);
	}
	
	public Admin findByAdminId(int adminId) {
		Admin admin = adminDao.findByAdminId(adminId);
		return admin;
	}

	public void saveAdmin(Admin admin) {
		adminDao.saveAdmin(admin);
	}

	public void saveAdminRoles(Map<String, Object> adminRoles) {
		adminDao.saveAdminRoles(adminRoles);
	}

	public void updateAdmin(Admin admin) {
		adminDao.updateAdmin(admin);
	}

	public void deleteAdminRoles(int adminId) {
		adminDao.deleteAdminRoles(adminId);
	}

	public void deleteAdmin(int id) {
		adminDao.deleteAdmin(id);
	}

	public Admin findByCode(String adminCode) {
		Admin admin = adminDao.findByCode(adminCode);
		return admin;
	}

	public Admin findAdminByName(String name) {
		return adminDao.findAdminByName(name);
	}

	public Admin findAdminByCode(String adminCode) {
		return adminDao.findAdminByCode(adminCode);
	}
	
	public Admin getAdminInfoByAdminId(Integer adminId) {
		return adminDao.getAdminInfoByAdminId(adminId);
	}
	
	public boolean checkToken(int adminId, String token) {
		Admin admin = adminDao.findByAdminId(adminId);
		return token.equals(admin.getToken());
	}
	
	public List<Module> findModulesByAdminId(Integer adminId) {
		return adminDao.findModulesByAdminId(adminId);
	}

}
