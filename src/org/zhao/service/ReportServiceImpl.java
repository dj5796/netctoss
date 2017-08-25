package org.zhao.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.zhao.dao.ReportDao;
import org.zhao.entity.DurationRank;
import org.zhao.entity.Host;
import org.zhao.entity.page.Page;
import org.zhao.entity.page.ReportPage;

@Service("reportService")
public class ReportServiceImpl implements ReportService {

	@Resource
	private ReportDao reportDao;
	
	public int findBillRows() {
		return reportDao.findBillRows();
	}

	public List<Map<String, Object>> findCustDurationByPage(Page page) {
		return reportDao.findCustDurationByPage(page);
	}

	public List<Host> findCostUsingTimesByPage(Page page) {
		return reportDao.findCostUsingTimesByPage(page);
	}

	public int findHostRows() {
		return reportDao.findHostRows();
	}

	public Host findByUnixHost(String unix_host) {
		return reportDao.findByUnixHost(unix_host);
	}

	public void addHost(Host host) {
		reportDao.addHost(host);
	}

	public void addHostTimeByType(int costType, Integer host_id) {
		reportDao.addHostTimeByType(costType,host_id);
	}

	public int findDurationRankRows() {
		return reportDao.findDurationRankRows();
	}

	public List<DurationRank> findDurationRanksByPage(ReportPage page) {
		return reportDao.findDurationRanksByPage(page);
	}

	
}
