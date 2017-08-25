package org.zhao.entity;

import java.io.Serializable;

public class ServiceUpdateBak implements Serializable {
	private static final long serialVersionUID = 577510301532590036L;
	
	private Integer id;
	private Integer service_id;
	private Integer cost_id;
	
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
	public Integer getCost_id() {
		return cost_id;
	}
	public void setCost_id(Integer cost_id) {
		this.cost_id = cost_id;
	}
	@Override
	public String toString() {
		return "ServiceUpdateBak [id=" + id + ", service_id=" + service_id + ", cost_id=" + cost_id + "]";
	}
	
}
