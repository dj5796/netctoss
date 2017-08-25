package org.zhao.entity;

import java.io.Serializable;

public abstract class BaseEntity implements Serializable {
	private static final long serialVersionUID = -7765947001790690570L;
	
	//给每一个实体类增加一个序号
	private Integer num;
	
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	@Override
	public String toString() {
		return "BaseEntity [num=" + num + "]";
	}
}
