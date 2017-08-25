package org.zhao.entity.page;

/** 管理员查询专用的实体类  **/
public class AdminPage extends Page {
	private static final long serialVersionUID = -5408415428233325251L;
	
	/** 根据模块id查询 **/
	private Integer moduleId;
	/** 根据角色名称查询  **/
	private String roleName;

	public AdminPage() {
		super();
		this.setPageSize(8);
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Integer getModuleId() {
		return moduleId;
	}

	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}

	@Override
	public String toString() {
		return "AdminPage [roleName=" + roleName + ", moduleId=" + moduleId + "]";
	}

}
