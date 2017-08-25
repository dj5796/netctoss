package org.zhao.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import org.zhao.entity.Admin;

public class LoginInterceptor implements HandlerInterceptor {

	public void afterCompletion(HttpServletRequest request,HttpServletResponse response, 
			Object obj, Exception exception)throws Exception {
	}

	public void postHandle(HttpServletRequest request,HttpServletResponse response, 
			Object obj, ModelAndView model) throws Exception {
	}

	//登录拦截器原理:在进行地址访问时,先检查session中是否有admin用户
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, 
			Object obj) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		if (admin == null) {
			response.sendRedirect(request.getContextPath()+ "/login/toLogin.do");
			return false;
		}
		
		return true;
	}

}
