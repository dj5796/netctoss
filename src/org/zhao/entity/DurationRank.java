package org.zhao.entity;

public class DurationRank extends BaseEntity {
	
	private static final long serialVersionUID = 1248701007700831808L;
	
	private Integer id;
	private Integer account_id;
	private String real_name;
	private String login_name;
	private String idcard_no;
	private Integer host_id;
	private String unix_host;
	private Long sofar_duration;
	private String sofar_duration_str;
	private Integer rank;
	
	public Integer getRank() {
		return rank;
	}
	public void setRank(Integer rank) {
		this.rank = rank;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getAccount_id() {
		return account_id;
	}
	public void setAccount_id(Integer account_id) {
		this.account_id = account_id;
	}
	public String getLogin_name() {
		return login_name;
	}
	public void setLogin_name(String login_name) {
		this.login_name = login_name;
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
	public Long getSofar_duration() {
		return sofar_duration;
	}
	public void setSofar_duration(Long sofar_duration) {
		this.sofar_duration = sofar_duration;
	}
	public String getSofar_duration_str() {
		return sofar_duration_str;
	}
	public void setSofar_duration_str(String sofar_duration_str) {
		this.sofar_duration_str = sofar_duration_str;
	}
	@Override
	public String toString() {
		return "DurationRank [id=" + id + ", account_id=" + account_id + ", real_name=" + real_name + ", login_name="
				+ login_name + ", idcard_no=" + idcard_no + ", host_id=" + host_id + ", unix_host=" + unix_host
				+ ", sofar_duration=" + sofar_duration + ", sofar_duration_str=" + sofar_duration_str + ", rank=" + rank
				+ ", getNum()=" + getNum() + "]";
	}
	
}
