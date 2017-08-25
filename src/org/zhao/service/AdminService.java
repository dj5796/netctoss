package org.zhao.service;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.page.Page;

public interface AdminService {

	List<Admin> findByPage(Page page);

	int findRows(Page page);

	/**批量更改密码:param中传入id的集合,以及要修改的密码**/
	void updatePassword(Map<String, Object> param);

	Admin findByAdminId(int adminId);

	void saveAdmin(Admin admin);

	void saveAdminRoles(Map<String, Object> adminRoles);

	void updateAdmin(Admin admin);

	void deleteAdminRoles(int adminId);

	void deleteAdmin(int id);

	Admin findByCode(String adminCode);

	Admin findAdminByName(String name);

	Admin findAdminByCode(String adminCode);
	
	Admin getAdminInfoByAdminId(Integer adminId);
	
	boolean checkToken(int adminId, String token);
	
	List<Module> findModulesByAdminId(Integer adminId);

}
