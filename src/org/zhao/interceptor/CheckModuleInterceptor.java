package org.zhao.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.zhao.entity.Module;

public class CheckModuleInterceptor extends HandlerInterceptorAdapter {

	@SuppressWarnings("unchecked")
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, 
			Object obj) throws Exception {
		// 获取登录用户所有权限的模块
		List<Module> modules = (List<Module>) request.getSession().getAttribute("allModules");
		// 获取用户当前要访问的模块
		int currentModule = (Integer) request.getSession().getAttribute("currentModule");
		// 判断用户有权限的模块是否包含当前模块
		for (Module module : modules) {
			if (module.getModule_id() == currentModule) {
				return true;// 有当前访问模块的权限
			}
		}
		// 没有当前访问模块的权限
		response.sendRedirect(request.getContextPath() + "/login/nopower.do");
		return false;
	}

}
