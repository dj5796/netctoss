package org.zhao.entity;

import java.io.Serializable;

public class Module implements Serializable {
	private static final long serialVersionUID = 422588590695814040L;
	
	private Integer module_id;
	private String name;

	public Integer getModule_id() {
		return module_id;
	}

	public void setModule_id(Integer module_id) {
		this.module_id = module_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "Module [module_id=" + module_id + ", name=" + name + "]";
	}

}
