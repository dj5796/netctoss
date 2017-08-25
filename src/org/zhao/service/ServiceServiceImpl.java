package org.zhao.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.zhao.dao.ServiceDao;
import org.zhao.entity.Service;
import org.zhao.entity.page.Page;

@org.springframework.stereotype.Service("serviceService")
public class ServiceServiceImpl implements ServiceService {
	@Resource
	private ServiceDao serviceDao;

	public List<Map<String, Object>> findByPage(Page page) {
		int rows = findRows(page);
		page.setRows(rows);
		List<Map<String, Object>> list = serviceDao.findByPage(page);
		return list;
	}

	public int findRows(Page page) {
		int rows = serviceDao.findRows(page);
		return rows;
	}

	public void updateStatus(Service service) {
		serviceDao.updateStatus(service);
	}

	public void pauseByAccount(int accountId) {
		serviceDao.pauseByAccount(accountId);
	}

	public void deleteByAccount(int accountId) {
		serviceDao.deleteByAccount(accountId);
	}

	public Service findById(int id) {
		Service service = serviceDao.findById(id);
		return service;
	}

	public void save(Service service) {
		serviceDao.save(service);
	}

	public void updateToAdd(Service service) {
		serviceDao.updateToAdd(service);
	}
	
	public void updateCostId(Service service) {
		serviceDao.updateCostId(service);
	}

	public List<String> findOS_UsernameByIP(String ip) {
		return serviceDao.findOS_UsernameByIP(ip);
	}

	public Service findFromBak(int id) {
		return serviceDao.findFromBak(id);
	}

	public Map<String, Object> getServiceDetailInfo(Integer serviceId) {
		return serviceDao.getServiceDetailInfo(serviceId);
	}

	public void updateServiceCostType(Service service) {
		serviceDao.updateServiceCostType(service);
	}

	public void clearServiceUpdateBak() {
		serviceDao.clearServiceUpdateBak();
	}
	
	
	
	
	

}
