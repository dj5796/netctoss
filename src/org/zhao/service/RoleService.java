package org.zhao.service;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.Page;

public interface RoleService {

	List<Role> findByPage(Page page);

	int findRows(Page page);

	List<Module> findAllModules();

	Role findById(int id);

	void saveRole(Role role);

	void saveRoleModules(Map<String, Object> roleModules);

	void updateRole(Role role);
	
	int isAdminUseRole(int roleId);

	void deleteRoleModules(int roleId);

	void deleteRole(int roleId);

	Role findByName(String name);
}
