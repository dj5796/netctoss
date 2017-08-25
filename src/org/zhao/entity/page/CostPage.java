package org.zhao.entity.page;


public class CostPage extends Page {
	private static final long serialVersionUID = 1706638893211619992L;
	//基本时长排序
	private String baseDurationSort;
	//基本费用排序
	private String baseCostSort;

	public CostPage() {
		super();
		this.setPageSize(6);
	}

	public String getBaseDurationSort() {
		return baseDurationSort;
	}

	public void setBaseDurationSort(String baseDurationSort) {
		this.baseDurationSort = baseDurationSort;
	}

	public String getBaseCostSort() {
		return baseCostSort;
	}

	public void setBaseCostSort(String baseCostSort) {
		this.baseCostSort = baseCostSort;
	}

	@Override
	public String toString() {
		return "CostPage [baseDurationSort=" + baseDurationSort + ", baseCostSort=" + baseCostSort + "]";
	}
	
}
