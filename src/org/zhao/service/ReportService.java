package org.zhao.service;

import java.util.List;
import java.util.Map;

import org.zhao.entity.DurationRank;
import org.zhao.entity.Host;
import org.zhao.entity.page.Page;
import org.zhao.entity.page.ReportPage;

public interface ReportService {
	
	int findBillRows();
	
	List<Map<String, Object>> findCustDurationByPage(Page page);
	
	List<Host> findCostUsingTimesByPage(Page page);

	int findHostRows();
	
	Host findByUnixHost(String unix_host);
	
	void addHost(Host host);

	void addHostTimeByType(int costType, Integer host_id);

	int findDurationRankRows();

	List<DurationRank> findDurationRanksByPage(ReportPage page);
	
	
	
}
