package org.zhao.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.zhao.entity.Admin;
import org.zhao.service.AdminService;

public class SingleSignOnInterceptor extends HandlerInterceptorAdapter {

	@Resource
	private AdminService adminService;

	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, 
			Object handler) throws Exception {
		Admin admin=(Admin)request.getSession().getAttribute("admin");
		String name = admin.getAdmin_code(), value = null;
		value = getCookie(request, name, value);
		if (!checkToken(value)) {
			request.getRequestDispatcher("../login/toSingleSignOn.do").forward(request, response);
			return false;
		}
		return true;
	}

	// 获取Cookie的value值
	private String getCookie(HttpServletRequest request, String name,String value) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(name)) {
					value = cookie.getValue();
				}
			}
		}
		return value;
	}
	
	//检验登录标示
	private boolean checkToken(String value) {
		if (value == null) {
			return false;
		}
		String[] data = value.split(",");
		if (data.length != 2) {
			return false;
		}
		String adminId = data[0],token = data[1];
		boolean pass = adminService.checkToken(Integer.parseInt(adminId), token);
		return pass;
	}

}
