package org.zhao.entity.page;


public class ServicePage extends Page {
	private static final long serialVersionUID = -4318619014498180072L;
	
	private String os_username;
	private String unix_host;
	private String idcard_no;
	private String status;

	public String getOs_username() {
		return os_username;
	}

	public void setOs_username(String os_username) {
		this.os_username = os_username;
	}

	public String getUnix_host() {
		return unix_host;
	}

	public void setUnix_host(String unix_host) {
		this.unix_host = unix_host;
	}

	public String getIdcard_no() {
		return idcard_no;
	}

	public void setIdcard_no(String idcard_no) {
		this.idcard_no = idcard_no;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "ServicePage [os_username=" + os_username + ", unix_host=" + unix_host + ", idcard_no=" + idcard_no
				+ ", status=" + status + "]";
	}

}
