package org.zhao.entity;

import java.util.List;

public class Role extends BaseEntity {

	private static final long serialVersionUID = 8161931999305468144L;
	
	private Integer role_id;
	private String name;
	private List<Module> modules;
	private List<Integer> moduleIds;
	
	public List<Integer> getModuleIds() {
		return moduleIds;
	}
	public void setModuleIds(List<Integer> moduleIds) {
		this.moduleIds = moduleIds;
	}
	public Integer getRole_id() {
		return role_id;
	}
	public void setRole_id(Integer role_id) {
		this.role_id = role_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<Module> getModules() {
		return modules;
	}
	public void setModules(List<Module> modules) {
		this.modules = modules;
	}

	@Override
	public String toString() {
		return "Role [role_id=" + role_id + ", name=" + name + ", modules="
				+ modules + ", moduleIds=" + moduleIds + ", getNum()="
				+ getNum() + "]";
	}

}
