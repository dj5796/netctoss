package org.zhao.entity;

import java.sql.Timestamp;
import java.util.List;

public class Admin extends BaseEntity {
	
	private static final long serialVersionUID = 7207559055943372531L;
	
	private Integer admin_id;
	private String admin_code;
	private String password;
	private String name;
	private String telephone;
	private String email;
	private Timestamp enrolldate;
	private String token;

	private List<Role> roles;
	private List<Integer> roleIds;
	
	public Integer getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(Integer admin_id) {
		this.admin_id = admin_id;
	}
	public String getAdmin_code() {
		return admin_code;
	}
	public void setAdmin_code(String admin_code) {
		this.admin_code = admin_code;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Timestamp getEnrolldate() {
		return enrolldate;
	}
	public void setEnrolldate(Timestamp enrolldate) {
		this.enrolldate = enrolldate;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public List<Role> getRoles() {
		return roles;
	}
	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	public List<Integer> getRoleIds() {
		return roleIds;
	}
	public void setRoleIds(List<Integer> roleIds) {
		this.roleIds = roleIds;
	}
	
	@Override
	public String toString() {
		return "Admin [admin_id=" + admin_id + ", admin_code=" + admin_code + ", password=" + password + ", name="
				+ name + ", telephone=" + telephone + ", email=" + email + ", enrolldate=" + enrolldate + ", token="
				+ token + ", roles=" + roles + ", roleIds=" + roleIds + ", getNum()=" + getNum() + "]";
	}

}
