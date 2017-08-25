package org.zhao.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.zhao.dao.RoleDao;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.Page;

@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Resource
	private RoleDao roleDao;

	public List<Role> findByPage(Page page) {
		int rows = findRows(page);
		page.setRows(rows);
		List<Role> list = roleDao.findByPage(page);
		return list;
	}

	public int findRows(Page page) {
		int rows = roleDao.findRows(page);
		return rows;
	}

	public List<Module> findAllModules() {
		List<Module> list = roleDao.findAllModules();
		return list;
	}

	public Role findById(int id) {
		Role role = roleDao.findById(id);
		return role;
	}

	public void saveRole(Role role) {
		roleDao.saveRole(role);
	}

	public void saveRoleModules(Map<String, Object> roleModules) {
		roleDao.saveRoleModules(roleModules);
	}

	public void updateRole(Role role) {
		roleDao.updateRole(role);
	}
	
	public int isAdminUseRole(int roleId) {
		return roleDao.isAdminUseRole(roleId);
	}

	public void deleteRoleModules(int roleId) {
		roleDao.deleteRoleModules(roleId);
	}

	public void deleteRole(int roleId) {
		roleDao.deleteRole(roleId);
	}

	public Role findByName(String name) {
		Role role = roleDao.findByName(name);
		return role;
	}

}
