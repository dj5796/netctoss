package org.zhao.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.zhao.entity.DurationRank;
import org.zhao.entity.Host;
import org.zhao.entity.page.Page;
import org.zhao.entity.page.ReportPage;

public interface ReportDao {
	
	int findBillRows();
	
	List<Map<String, Object>> findCustDurationByPage(Page page);
	
	int findHostRows();

	List<Host> findCostUsingTimesByPage(Page page);
	
	Host findByUnixHost(String unix_host);
	
	void addHost(Host host);

	void addHostTimeByType(@Param("costType")int costType, @Param("host_id")Integer host_id);

	int findDurationRankRows();

	List<DurationRank> findDurationRanksByPage(ReportPage page);
	
	
}
