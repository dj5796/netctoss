package org.zhao.entity;

public class Bill extends BaseEntity {
	
	private static final long serialVersionUID = 2989717607845270009L;
	
	private Integer id;
	private Integer account_id;
	private String real_name;
	private String idcard_no;
	private String login_name;
	private String bill_month;
	private Double cost;
	private String payment_mode;
	private String pay_state;
	private String sofar_duration_str;
	
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
	public String getBill_month() {
		return bill_month;
	}
	public void setBill_month(String bill_month) {
		this.bill_month = bill_month;
	}
	public Double getCost() {
		return cost;
	}
	public void setCost(Double cost) {
		this.cost = cost;
	}
	public String getPayment_mode() {
		return payment_mode;
	}
	public void setPayment_mode(String payment_mode) {
		this.payment_mode = payment_mode;
	}
	public String getPay_state() {
		return pay_state;
	}
	public void setPay_state(String pay_state) {
		this.pay_state = pay_state;
	}
	public String getSofar_duration_str() {
		return sofar_duration_str;
	}
	public void setSofar_duration_str(String sofar_duration_str) {
		this.sofar_duration_str = sofar_duration_str;
	}
	@Override
	public String toString() {
		return "Bill [id=" + id + ", account_id=" + account_id + ", real_name=" + real_name + ", idcard_no=" + idcard_no
				+ ", login_name=" + login_name + ", bill_month=" + bill_month + ", cost=" + cost + ", payment_mode="
				+ payment_mode + ", pay_state=" + pay_state + ", sofar_duration_str=" + sofar_duration_str
				+ ", getNum()=" + getNum() + "]";
	}

}
