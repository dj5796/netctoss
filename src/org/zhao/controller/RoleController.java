package org.zhao.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.RolePage;
import org.zhao.service.RoleService;

@Controller
@RequestMapping("/role")
@SessionAttributes("rolePage")
public class RoleController {

	@Resource
	private RoleService roleService;

	@RequestMapping("/findRole.do")
	public String findRole(RolePage page, Model model) {
		page.setRows(roleService.findRows(page));
		model.addAttribute("rolePage", page);
		List<Role> roles = roleService.findByPage(page);
		model.addAttribute("roles", roles);
		return "role/role_list";
	}

	@RequestMapping("/toAddRole.do")
	public String toAddRole(Model model) {
		List<Module> modules = roleService.findAllModules();
		model.addAttribute("modules", modules);
		return "role/add_role";
	}

	@RequestMapping("/addRole.do")
	@ResponseBody
	public String addRole(Role role, Model model) {
		roleService.saveRole(role);

		List<Integer> moduleIds = role.getModuleIds();
		for (Integer moduleId : moduleIds) {
			Map<String, Object> roleModules = new HashMap<String, Object>();
			roleModules.put("role_id", role.getRole_id());
			roleModules.put("module_id", moduleId);
			roleService.saveRoleModules(roleModules);
		}
		return "findRole.do";
	}

	@RequestMapping("/toUpdateRole.do")
	public String toUpdateRole(@RequestParam("id") int id, Model model) {
		List<Module> modules = roleService.findAllModules();
		model.addAttribute("modules", modules);
		Role role = roleService.findById(id);
		model.addAttribute("role", role);
		return "role/update_role";
	}

	@RequestMapping("/updateRole.do")
	@ResponseBody
	public String updateRole(Role role, Model model) {
		roleService.updateRole(role);

		roleService.deleteRoleModules(role.getRole_id());

		List<Integer> moduleIds = role.getModuleIds();
		for (Integer moduleId : moduleIds) {
			Map<String, Object> roleModules = new HashMap<String, Object>();
			roleModules.put("role_id", role.getRole_id());
			roleModules.put("module_id", moduleId);
			roleService.saveRoleModules(roleModules);
		}

		return "findRole.do";
	}

	@RequestMapping("/deleteRole.do")
	@ResponseBody
	public Map<String, Object> deleteRole(@RequestParam("id") int id) {
		Map<String, Object> info = new HashMap<String, Object>();
		
		//先判断该角色是否有管理员在使用，没有可以删除，否则无法删除
		int count=roleService.isAdminUseRole(id);
		
		if (count==0) {
			//该角色没有管理员在使用,可以删除
			roleService.deleteRoleModules(id);
			roleService.deleteRole(id);
			info.put("success", true);
			info.put("message", "删除角色成功!");
			info.put("url", "findRole.do");
		} else {
			//有在使用，不能删除
			info.put("success", false);
			info.put("message", "删除错误！该角色被使用，不能删除！");
		}
		
		return info;
	}

	@RequestMapping("/checkRoleName.do")
	@ResponseBody
	public boolean checkRoleName(String name) {
		Role role = roleService.findByName(name);
		if (role == null)
			return true;
		else
			return false;
	}

}
