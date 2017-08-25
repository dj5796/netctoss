package org.zhao.entity.page;


public class ReportPage extends Page {
	private static final long serialVersionUID = 6943285468882609445L;
	int type=-1;
	int page0=1;
	int page1=1;
	int page2=1;
	
	public ReportPage() {
		super();
		this.setPageSize(8);
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getPage0() {
		return page0;
	}

	public void setPage0(int page0) {
		this.page0 = page0;
	}

	public int getPage1() {
		return page1;
	}

	public void setPage1(int page1) {
		this.page1 = page1;
	}

	public int getPage2() {
		return page2;
	}

	public void setPage2(int page2) {
		this.page2 = page2;
	}

	@Override
	public String toString() {
		return "ReportPage [type=" + type + ", page0=" + page0 + ", page1=" + page1 + ", page2=" + page2
				+ ", getBegin()=" + getBegin() + ", getEnd()=" + getEnd() + ", getTotalPage()=" + getTotalPage()
				+ ", getCurrentPage()=" + getCurrentPage() + ", getPageSize()=" + getPageSize() + ", getRows()="
				+ getRows() + "]";
	}
	
	
}
