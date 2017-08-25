package org.zhao.dao;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.page.Page;

public interface AdminDao {

	List<Admin> findByPage(Page page);

	int findRows(Page page);

	Admin findByAdminId(int adminId);
	
	Admin findByCode(String adminCode);
	
	List<Module> findModulesByAdminId(Integer adminId);
	
	Admin findAdminByName(String name);
	
	Admin findAdminByCode(String adminCode);
	
	Admin getAdminInfoByAdminId(Integer adminId);

	void saveAdmin(Admin admin);

	void saveAdminRoles(Map<String, Object> adminRoles);

	void updateAdmin(Admin admin);
	
	/**批量更改密码:param中传入id的集合**/
	void updatePassword(Map<String, Object> param);

	void deleteAdminRoles(int adminId);

	void deleteAdmin(int id);
}
