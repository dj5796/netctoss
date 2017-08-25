package org.zhao.entity;

import java.sql.Timestamp;

public class ServiceDetail extends BaseEntity {
	
	private static final long serialVersionUID = -5907669786631275886L;
	
	private Integer id;
	private Integer service_id;
	private String unix_host;
	private String os_username;
	private Integer pid;
	private Timestamp login_time;
	private Timestamp logout_time;
	private Long duration;
	private String duration_str;
	private Double cost;
	private Double sum_cost;
	public Double getSum_cost() {
		return sum_cost;
	}
	public void setSum_cost(Double sum_cost) {
		this.sum_cost = sum_cost;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getService_id() {
		return service_id;
	}
	public void setService_id(Integer service_id) {
		this.service_id = service_id;
	}
	public String getUnix_host() {
		return unix_host;
	}
	public void setUnix_host(String unix_host) {
		this.unix_host = unix_host;
	}
	public String getOs_username() {
		return os_username;
	}
	public void setOs_username(String os_username) {
		this.os_username = os_username;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Timestamp getLogin_time() {
		return login_time;
	}
	public void setLogin_time(Timestamp login_time) {
		this.login_time = login_time;
	}
	public Timestamp getLogout_time() {
		return logout_time;
	}
	public void setLogout_time(Timestamp logout_time) {
		this.logout_time = logout_time;
	}
	public Long getDuration() {
		return duration;
	}
	public void setDuration(Long duration) {
		this.duration = duration;
	}
	public String getDuration_str() {
		return duration_str;
	}
	public void setDuration_str(String duration_str) {
		this.duration_str = duration_str;
	}
	public Double getCost() {
		return cost;
	}
	public void setCost(Double cost) {
		this.cost = cost;
	}
	@Override
	public String toString() {
		return "ServiceDetail [id=" + id + ", service_id=" + service_id + ", unix_host=" + unix_host + ", os_username=" + os_username + ", pid=" + pid + ", login_time=" + login_time
				+ ", logout_time=" + logout_time + ", duration=" + duration + ", duration_str=" + duration_str + ", cost=" + cost + ", sum_cost=" + sum_cost + "]";
	}
	
}
