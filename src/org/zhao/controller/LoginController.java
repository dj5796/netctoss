package org.zhao.controller;

import java.awt.image.BufferedImage;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.service.AdminService;
import org.zhao.util.ImageUtil;
import org.zhao.util.MD5Util;

@Controller
@RequestMapping("/login")
@Scope("prototype")
public class LoginController extends BaseController {
	private final static int SUCCESS = 0;
	private final static int ADMIN_CODE_ERROR = 1;
	private final static int PASSWORD_ERROR = 2;
	private final static int IMAGE_CODE_ERROR = 3;

	@Resource
	private AdminService adminService;

	@RequestMapping("/toLogin.do")
	public String toLogin() {
		return "main/login";
	}

	@RequestMapping("/login.do")
	@ResponseBody
	public Map<String, Object> login(String adminCode, String password,
			String identifyingCode, HttpSession session,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		// 检查验证码是否正确
		String imageCode = (String)	session.getAttribute("imageCode");
		if (identifyingCode == null || !identifyingCode.equalsIgnoreCase(imageCode)) {
			result.put("flag", IMAGE_CODE_ERROR);
			return result;
		}
		
		// 检查是否有该用户,并检查密码是否正确
		Admin admin = adminService.findByCode(adminCode);
		// 将浏览器发过来的密码进行加密后和数据库中的用户密码进行比较
		password=MD5Util.md5Salt(password);
		if (admin == null) {
			result.put("flag", ADMIN_CODE_ERROR);
			return result;
		} else if (!admin.getPassword().equals(password)) {
			result.put("flag", PASSWORD_ERROR);
			return result;
		} else {
			// 当用户第一次登录时,保存用户登录状态的唯一标识Token,用于实现单点登录
			String token=UUID.randomUUID().toString();
			admin.setToken(token);
			adminService.updateAdmin(admin);
			
			// 下发token到客户端浏览器
			Cookie cookie = new Cookie(admin.getAdmin_code(), admin.getAdmin_id()+","+token);
			cookie.setPath("/");
			response.addCookie(cookie);
			
			// 在session中保存用户，用于实现登录检查拦截功能
			session.setAttribute("admin", admin);
			// 在session中保存用户的所有权限，用于实现权限检查拦截
			List<Module> modules = adminService.findModulesByAdminId(admin.getAdmin_id());
			session.setAttribute("allModules", modules);

			result.put("flag", SUCCESS);
			return result;
		}
	}

	@RequestMapping("/createImage.do")
	public void createImage(HttpServletResponse response, HttpSession session) throws Exception {
		Map<String, BufferedImage> imageMap = ImageUtil.createImage();
		String code = imageMap.keySet().iterator().next();
		session.setAttribute("imageCode", code);
		
		System.out.println("图片验证码=====" + session.getAttribute("imageCode"));
		
		BufferedImage image = imageMap.get(code);
		response.setContentType("image/jpeg");
		OutputStream ops = response.getOutputStream();
		ImageIO.write(image, "jpeg", ops);
		ops.close();
	}

	@RequestMapping("/toIndex.do")
	public String toIndex() {
		return "main/index";
	}

	@RequestMapping("/nopower.do")
	public String nopower() {
		return "main/nopower";
	}
	
	@RequestMapping("/logout.do")
	/**登出操作：销毁session对象后，重定向到登录界面**/
	public String logout(HttpServletRequest request){
		request.getSession().invalidate();//销毁session
		return "redirect:toLogin.do";
	}
	
	@RequestMapping("/toSingleSignOn.do")
	public String toSingleSignOn(){
		return "main/singleSignOn";
	}

}
