package org.zhao.dao;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Service;
import org.zhao.entity.page.Page;

public interface ServiceDao {

	List<Map<String, Object>> findByPage(Page page);

	int findRows(Page page);

	void updateStatus(Service service);

	void pauseByAccount(int accountId);

	void deleteByAccount(int accountId);

	Service findById(int id);

	void save(Service service);

	Service findFromBak(int id);
	
	void updateToAdd(Service service);
	
	void updateCostId(Service service);
	
	void updateServiceCostType(Service service);
	
	List<String> findOS_UsernameByIP(String ip);

	Map<String, Object> getServiceDetailInfo(Integer serviceId);
	
	/**清空service_update_bak表**/
	void clearServiceUpdateBak();
	
	
	
	
}
