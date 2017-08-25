<%@page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>中国电信计费系统</title>
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath}/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath}/styles/global_color.css" /> 
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.js"></script>
        <script type="text/javascript">
	        $(function(){
	        	$('#adminCode').on('blur',checkUserName); 
	        	
	        	$('#password').on('blur',checkPassword);
	        	
	        	$('#identifyingCode').on('blur',checkIdentifyingCode).on('keydown',enterLogin);
	        	
	        	$('#image').on('click',flushImageCode);
	   		});
	        
        	function checkUserName(){
        		var adminCode = $("#adminCode").val();
        		if(adminCode == "") {
        			$("#adminCode_msg").text("输入账号")
        				.removeClass("not_required").addClass("required");
        			return false;
        		}
        		var reg = /^\w{2,10}$/;
        		if (!reg.test(adminCode)) {
        			$("#adminCode_msg").text("输入2~10字符")
        				.removeClass("not_required").addClass("required");
        			return false;
        		}
       			$('#adminCode_msg').empty();
        		return true;
        	}	
        
        	function checkPassword(){
        		var password = $("#password").val();
        		if(password == "") {
        			$("#password_msg").text("输入密码")
        				.removeClass("not_required").addClass("required");
        			return false;
        		}
        		var reg = /^\w{6,20}$/;
        		if (!reg.test(password)) {
        			$("#password_msg").text("输入6~20字符")
        				.removeClass("not_required").addClass("required");
        			return false;
        		}
        		$('#password_msg').empty();
	        	return true;
        	}
        	
        	function checkIdentifyingCode(){
        		var code = $("#identifyingCode").val();
        		if(code == "") {
        			$("#identifyingCode_msg").text("输入验证码")
        				.removeClass("not_required").addClass("required");
        			return false;
        		}
        		var reg = /^\w{4}$/;
        		if (!reg.test(code)) {
        			$("#identifyingCode_msg").text("输入4位验证码")
        				.removeClass("not_required").addClass("required");
        			return false;
        		}
        		$('#identifyingCode_msg').empty();
        		return true;
        	}	
        
	      	function checkLogin() {
	      		var adminCode = checkUserName();
	      		var password = checkPassword();
	      		var code = checkIdentifyingCode();
	      		if(!(adminCode && password && code)){
	      			return false;
	      		}
	      		$.post(
	      			"${pageContext.request.contextPath}/login/login.do",
	      			$("#myform").serialize(),
	      			function(data) {
	      				if(data.flag==1) {
	      					//账号错误
	      					$("#login_error").text("账号错误");
	      					flushImageCode();
	      				} else if(data.flag==2) {
	      					//密码错误
	      					$("#login_error").text("密码错误");
	      					flushImageCode();
	      				} else if(data.flag==3) {
	      					//验证码错误
	      					$("#login_error").text("验证码错误");
	      					flushImageCode();
	      				} else {
	      					//成功
	      					location.href = "${pageContext.request.contextPath}/login/toIndex.do";
	      				}
	      			}
	      		);
	      	}
	      	
        	//刷新验证码
        	function flushImageCode() {
        		$("#image").attr("src","${pageContext.request.contextPath}/login/createImage.do?date="+new Date().getTime());
        		$('#identifyingCode').val("");
        	}
        	
        	//输入验证码直接按下enter键登录
        	function enterLogin() {
        		var keynum = event.keyCode||event.which;
        		if (keynum == 13){
			    	checkLogin();
			  	}
			}
        </script>
    </head>
    <body class="index">
        <div class="login_box">
        	<form action="login.do" method="post" id="myform">
	            <table>
	                <tr>
	                    <td class="login_info">账&nbsp;&nbsp;&nbsp;号：</td>
	                    <td colspan="2">
	                    	<input type="text" name="adminCode" id="adminCode" value="${param.adminCode}" class="width150" maxlength="10" placeholder="请输入2~10个字符" />
	                    </td>
	                    <td class="login_error_info">
	                    	<span class="required">* </span>
	                    	<span class="not_required" id="adminCode_msg"></span>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="login_info">密&nbsp;&nbsp;&nbsp;码：</td>
	                    <td colspan="2">
	                    	<input type="password" name="password" id="password" value="${param.password}" class="width150" maxlength="20" placeholder="请输入6~20个字符" />
	                    </td>
	                    <td>
	                    	<span class="required">* </span>
	                    	<span class="not_required" id="password_msg"></span>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="login_info">验证码：</td>
	                    <td class="width70">
	                    	<input type="text" name="identifyingCode" id="identifyingCode" style="width:65px;" class="width70" maxlength="4" placeholder="4位验证码" />
	                    </td>
	                    <td>
	                    	<img src="${pageContext.request.contextPath}/login/createImage.do" alt="验证码" title="点击更换" id="image"/>
	                    </td>  
	                    <td>
	                    	<span class="required">* </span>
	                    	<span class="not_required" id="identifyingCode_msg"></span>
	                    </td>
	                </tr>
	                <tr>
	                    <td></td>
	                    <td class="login_button" colspan="2">
	                    	<a href="javascript:checkLogin();"><img src="${pageContext.request.contextPath}/images/login_btn.png"/></a>
	                    </td>    
	                    <td><span class="required" id="login_error" style="font-size:22px;"></span></td>                
	                </tr>
	            </table>
            </form>
        </div>
    </body>
</html>