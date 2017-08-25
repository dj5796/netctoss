package org.zhao.entity.page;

import org.zhao.util.CalendarUitl;

public class BillPage extends Page {
	private static final long serialVersionUID = 1486788554930102292L;
	
	private String real_name;
	private String idcard_no;
	private String login_name;
	//年份默认为当前账单年
	private int year=CalendarUitl.getBillYear();
	//月份默认为当前账单月
	private int month=CalendarUitl.getBillMonth();
	
	private String billYearMonth;
	
	public BillPage() {
		super();
		this.setPageSize(8);
	}
	
	public String getBillYearMonth() {
		if (billYearMonth==null || billYearMonth.equals("")) {
			return year+"-"+month;
		}
		return billYearMonth;
	}

	public void setBillYearMonth(String billYearMonth) {
		this.billYearMonth = billYearMonth;
	}

	public String getReal_name() {
		return real_name;
	}
	public void setReal_name(String real_name) {
		this.real_name = real_name;
	}
	public String getIdcard_no() {
		return idcard_no;
	}
	public void setIdcard_no(String idcard_no) {
		this.idcard_no = idcard_no;
	}
	public String getLogin_name() {
		return login_name;
	}
	public void setLogin_name(String login_name) {
		this.login_name = login_name;
	}
	
	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	@Override
	public String toString() {
		return "BillPage [real_name=" + real_name + ", idcard_no=" + idcard_no + ", login_name=" + login_name
				+ ", year=" + year + ", month=" + month + ", billYearMonth=" + billYearMonth + "]";
	}
	
}
