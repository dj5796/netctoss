package org.zhao.entity;

public class Host extends BaseEntity {
	
	private static final long serialVersionUID = -8748094167761950720L;
	
	private Integer host_id;
	private String unix_host;
	private Integer monthly=0;
	private Integer meal=0;
	private Integer hourly=0;
	
	public Integer getHost_id() {
		return host_id;
	}
	public void setHost_id(Integer host_id) {
		this.host_id = host_id;
	}
	public String getUnix_host() {
		return unix_host;
	}
	public void setUnix_host(String unix_host) {
		this.unix_host = unix_host;
	}
	public Integer getMonthly() {
		return monthly;
	}
	public void setMonthly(Integer monthly) {
		this.monthly = monthly;
	}
	public Integer getMeal() {
		return meal;
	}
	public void setMeal(Integer meal) {
		this.meal = meal;
	}
	public Integer getHourly() {
		return hourly;
	}
	public void setHourly(Integer hourly) {
		this.hourly = hourly;
	}
	@Override
	public String toString() {
		return "Host [host_id=" + host_id + ", unix_host=" + unix_host + ", monthly=" + monthly + ", meal=" + meal
				+ ", hourly=" + hourly + ", getNum()=" + getNum() + "]";
	}
	
}
