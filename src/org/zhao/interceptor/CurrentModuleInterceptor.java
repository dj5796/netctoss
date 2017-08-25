package org.zhao.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CurrentModuleInterceptor extends HandlerInterceptorAdapter {
	
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response,
			Object obj) throws Exception {
		
		// 判断当前用户访问的模块
		String url = request.getRequestURL().toString();
		int currentModule = 0; // 默认0是NetCTOSS首页
		if (url.contains("role")) {
			currentModule = 1;
		} else if (url.contains("admin")) {
			currentModule = 2;
		} else if (url.contains("cost")) {
			currentModule = 3;
		} else if (url.contains("account")) {
			currentModule = 4;
		} else if (url.contains("service")) {
			currentModule = 5;
		} else if (url.contains("bill")) {
			currentModule = 6;
		} else if (url.contains("report")) {
			currentModule = 7;
		} else if (url.contains("user") && url.contains("viewPersonalInfo")) {
			currentModule = 8;
		} else if (url.contains("user") && url.contains("changePassword")) {
			currentModule = 9;
		}
		
		request.getSession().setAttribute("currentModule", currentModule);
		return true;
	}

}
