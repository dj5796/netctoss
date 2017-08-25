package org.zhao.entity;

public class BillItem extends BaseEntity {
	
	private static final long serialVersionUID = -6363617218753434789L;
	
	private Integer id;
	private Integer bill_id;
	private Integer service_id;
	private Integer cost_id;
	private Double cost;
	private String month_id;
	private Long sofar_duration;
	private String sofar_duration_str;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getBill_id() {
		return bill_id;
	}
	public void setBill_id(Integer bill_id) {
		this.bill_id = bill_id;
	}
	public Integer getService_id() {
		return service_id;
	}
	public void setService_id(Integer service_id) {
		this.service_id = service_id;
	}
	public Integer getCost_id() {
		return cost_id;
	}
	public void setCost_id(Integer cost_id) {
		this.cost_id = cost_id;
	}
	public Double getCost() {
		return cost;
	}
	public void setCost(Double cost) {
		this.cost = cost;
	}
	public String getMonth_id() {
		return month_id;
	}
	public void setMonth_id(String month_id) {
		this.month_id = month_id;
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
		return "BillItem [id=" + id + ", bill_id=" + bill_id + ", service_id=" + service_id + ", cost_id=" + cost_id
				+ ", cost=" + cost + ", month_id=" + month_id + ", sofar_duration=" + sofar_duration
				+ ", sofar_duration_str=" + sofar_duration_str + ", getNum()=" + getNum() + "]";
	}
	
}
