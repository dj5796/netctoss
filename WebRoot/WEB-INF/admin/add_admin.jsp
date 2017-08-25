<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
        <!--SweetAlert提示框插件-->
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/styles/sweetalert.css" /> 
        <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/sweetalert.min.js"></script> 
        <script language="javascript" type="text/javascript" src="../js/jquery-1.11.1.js"></script>
        <script language="javascript" type="text/javascript">
        	$(function(){
        		$("#name")
        			.on('focus',function(){
        				$("#name_msg").text('2~20长度以内的汉字、字母、数字的组合').removeClass("error_msg");
        			})
        			.on('blur',checkName)
        			.focus();
        		
        		$("#admin_code")
        			.on('focus',function(){
        				$("#admin_code_msg").text('3~30长度以内的字母、数字和下划线的组合').removeClass("error_msg").removeClass("green");
        			})
        			.on('blur',checkAdminCode);
        		
        		$("#password")
        			.on('focus',function(){
        				$("#password_msg").text('6~30长度以内的字母、数字和下划线的组合').removeClass("error_msg");
        			})
        			.on('blur',checkPassword);
        		 
        		$("#confirm_password")
        			.on('focus',function(){
        				$("#confirm_password_msg").text('两次密码必须相同').removeClass("error_msg");
        			})
        			.on('blur',checkConfirmPassword);
        		
        		$("#telephone")
        			.on('focus',function(){
        				$("#telephone_msg").text('正确的电话号码格式：手机或固话').removeClass("error_msg");
        			})
        			.on('blur',checkTelephone);
        		
        		$("#email")
        			.on('focus',function(){
        				$("#email_msg").text('请输入正确的 email 格式').removeClass("error_msg");
        			})
        			.on('blur',checkEmail);
        	});
        	
        	//姓名
        	function checkName(){
        		var name = $("#name").val();
        		if(name == "") {
        			$("#name_msg").text("请输入姓名").addClass("error_msg");
        			return false;
        		}
        		var reg = /^[a-zA-Z0-9\u4e00-\u9fa5]{2,20}$/;
        		if (!reg.test(name)) {
        			$("#name_msg").text("2~20长度以内的汉字、字母、数字的组合").addClass("error_msg");
        			return false;
        		}
        		$('#name_msg').empty();
        		return true;
        	}	
        	
        	//管理员账号
        	var adminCodeFlag=null;
        	function checkAdminCode(){
        		var admin_code = $("#admin_code").val();
        		if(admin_code == "") {
        			$("#admin_code_msg").text("请输入管理员账号").addClass("error_msg");
        			adminCodeFlag=false;
        			return false;
        		}
        		var reg = /^[a-zA-Z0-9_]{3,30}$/;
        		if (!reg.test(admin_code)) {
        			$("#admin_code_msg").text("3~30长度以内的字母、数字和下划线的组合").addClass("error_msg");
        			adminCodeFlag=false;
        			return false;
        		}
        		
        		$.post(
           			"checkAdminCode.do",
           			{adminCode:admin_code},
           			function(data){
           				if(data) {
   							$("#admin_code_msg").text("账号 \""+admin_code+"\" 尚未注册,可以使用!").removeClass("error_msg").addClass("green");
   							adminCodeFlag=true;
   						} else {
   							$("#admin_code_msg").text("该账号已存在").addClass("error_msg");
   							adminCodeFlag=false;
   						}
           			}
           		);
        	}	
        
        	//密码
        	function checkPassword(){
        		var password = $("#password").val();
        		if(password == "") {
        			$("#password_msg").text("请输入密码").addClass("error_msg");
        			return false;
        		}
        		var reg = /^[a-zA-Z0-9_]{6,30}$/;
        		if (!reg.test(password)) {
        			$("#password_msg").text("6~30长度以内的字母、数字和下划线的组合").addClass("error_msg");
        			return false;
        		}
       			$('#password_msg').empty();
        		return true;
        	}
        	
        	//确认密码
        	function checkConfirmPassword(){
        		var password = $("#password").val();
        		var confirm_password = $("#confirm_password").val();
        		if(confirm_password == "") {
        			$("#confirm_password_msg").text("请输入确认密码").addClass("error_msg");
        			return false;
        		}
        		if (password!=confirm_password) {
        			$("#confirm_password_msg").text("两次密码必须相同").addClass("error_msg");
        			return false;
        		}
       			$('#confirm_password_msg').empty();
        		return true;
        	}
        	
        	//电话
        	function checkTelephone(){
        		var telephone = $("#telephone").val();
        		if(telephone == "") {
        			$("#telephone_msg").text("请输入手机或者固话号码").addClass("error_msg");
        			return false;
        		}
        		var reg1 = /^1[34578]\d{9}$/;
        		var reg2 = /^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}$/;
        		if(!(reg1.test(telephone)||reg2.test(telephone))){
        			$("#telephone_msg").text("正确的电话号码格式：手机或固话").addClass("error_msg");
        			return false;
        		}
       			$('#telephone_msg').empty();
        		return true;
        	}
        
        	//Email
        	function checkEmail(){
        		var email = $("#email").val();
        		if(email == "") {
        			$("#email_msg").text("请输入 email").addClass("error_msg");
        			return false;
        		}
        		var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        		if (!reg.test(email)) {
        			$("#email_msg").text("请输入正确的 email 格式").addClass("error_msg");
        			return false;
        		}
       			$('#email_msg').empty();
        		return true;
        	}
        	
        	//角色
        	function checkRole() {
        		var roleIds = $(":checkbox[name='roleIds']:checked");
        		if(roleIds.length == 0) {
        			$("#role_msg").text("请至少选择一个角色").addClass("error_msg");
        			return false;
        		} else {
        			$("#role_msg").text("").removeClass("error_msg");
        			return true;
        		}
        	}
        	
        	//提交检查
        	function saveAction(){
        		var flag=checkName() && checkPassword() && checkConfirmPassword() && checkTelephone() && checkEmail() && checkRole();
        		if(!flag){
	       			swal({
	       				title:'Oh, My God !',
	       				html:true,
	       				text:'<span class="swal_error">表单中存在不符合规则的数据，请检查 !</span>',
	       				type:'error',
	       				timer:3000
	       			});
	       			return false;
        		}
        		
        		sweetAlert({
			        title: "您确定要增加该管理员吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        animation: "slide-from-top",
			        closeOnConfirm: false
			    }, function() {
	        		document.forms[0].submit();
			    });
        	}
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <div id="header">
            <jsp:include page="../main/logo.jsp"/>   
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <div id="navi">
        	<jsp:include page="../main/menu.jsp"/>
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <!-- <div id="save_result_info" class="save_success">保存成功！</div> -->
	    	<form action="addAdmin.do" method="post" class="main_form">
	    		<div class="text_info clearfix"><span>姓名：</span></div>
	            <div class="input_info">
	                <input type="text" class="width180" name="name" id="name"/>
	             	<span class="required">*</span>
	             	<div class="validate_msg_medium" id="name_msg">2~20长度以内的汉字、字母、数字的组合</div>
	            </div>
	            
	            <div class="text_info clearfix"><span>管理员账号：</span></div>
	            <div class="input_info">
	                <input type="text" class="width180" name="admin_code" id="admin_code"/>
	                <span class="required">*</span>
	                <div class="validate_msg_medium" id="admin_code_msg">3~30长度以内的字母、数字和下划线的组合</div>
	            </div>
	            
	            <div class="text_info clearfix"><span>密码：</span></div>
	            <div class="input_info">
	                <input type="password" class="width180" name="password" id="password"/>
	                <span class="required">*</span>
	                <div class="validate_msg_medium" id="password_msg">6~30长度以内的字母、数字和下划线的组合</div>
	            </div>
	            
	            <div class="text_info clearfix"><span>确认密码：</span></div>
	            <div class="input_info">
	                <input type="password" class="width180" name="confirm_password" id="confirm_password"/>
	                <span class="required">*</span>
	                <div class="validate_msg_medium" id="confirm_password_msg">两次密码必须相同</div>
	            </div>  
	                
	            <div class="text_info clearfix"><span>电话：</span></div>
	            <div class="input_info">
	                <input type="text" class="width180" name="telephone" id="telephone"/>
	                <span class="required">*</span>
	                <div class="validate_msg_medium" id="telephone_msg">正确的电话号码格式：手机或固话</div>
	            </div>
	            
	            <div class="text_info clearfix"><span>Email：</span></div>
	            <div class="input_info">
	                <input type="text" class="width280" name="email" id="email"/>
	                <span class="required">*</span>
	                <div class="validate_msg_short" id="email_msg">请输入正确的 email 格式</div>
	            </div>
	            
	            <div class="text_info clearfix"><span>角色：</span></div>
	            <div class="input_info_high">
	                <div class="input_info_scroll">
	                    <ul>
	                        <c:forEach items="${roles}" var="r">
	                    		<li><input type="checkbox" value="${r.role_id }" name="roleIds" onclick="checkRole();"/>${r.name }</li>
	                    	</c:forEach>
	                    </ul>
	                </div>
	                <span class="required">*</span>
	                <div class="validate_msg_tiny" id="role_msg">请至少选择一个角色</div>
	            </div>
	            
	            <div class="button_info clearfix">
	                <input type="button" value="保存" class="btn_save" onclick="saveAction();"/>
	                <input type="button" value="取消" class="btn_save" onclick="history.back();"/>
	            </div>
	        </form>  
        </div>
        <!--主要区域结束:版权区域-->
        <jsp:include page="../main/copyright.jsp"/> 
    </body>
</html>