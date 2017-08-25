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
        		$("#oldPassword")
        			.on('focus',function(){
        				$("#oldPassword_msg").text('6~30长度以内的字母、数字和下划线的组合').removeClass("error_msg");
        			})
        			.on('blur',checkOldPassword)
        			.focus();
        		
        		$("#newPassword")
        			.on('focus',function(){
        				$("#newPassword_msg").text('6~30长度以内的字母、数字和下划线的组合').removeClass("error_msg");
        			})
        			.on('blur',checkNewPassword);
        		 
        		$("#confirmPassword")
        			.on('focus',function(){
        				$("#confirmPassword_msg").text('两次新密码必须相同').removeClass("error_msg");
        			})
        			.on('blur',checkConfirmPassword);
        	});
        	
        	function checkOldPassword(){
        		var oldPassword = $("#oldPassword").val();
        		if(oldPassword == "") {
        			$("#oldPassword_msg").text("请输入旧密码").addClass("error_msg");
        			return false;
        		}
        		
        		var reg = /^[a-zA-Z0-9_]{6,30}$/;
        		if (!reg.test(oldPassword)) {
        			$("#oldPassword_msg").text("6~30长度以内的字母、数字和下划线的组合").addClass("error_msg");
        			return false;
        		}
        		
        		var newPassword = $("#newPassword").val();
        		if (oldPassword==newPassword) {
        			$("#oldPassword_msg").text("新旧密码不能相同").addClass("error_msg");
        			return false;
        		}
        		
       			$('#oldPassword_msg').empty();
        		return true;
        	}
        	
        	function checkNewPassword(){
        		var newPassword = $("#newPassword").val();
        		if(newPassword == "") {
        			$("#newPassword_msg").text("请输入新密码").addClass("error_msg");
        			return false;
        		}
        		
        		var reg = /^[a-zA-Z0-9_]{6,30}$/;
        		if (!reg.test(newPassword)) {
        			$("#newPassword_msg").text("6~30长度以内的字母、数字和下划线的组合").addClass("error_msg");
        			return false;
        		}
        		
        		var oldPassword = $("#oldPassword").val();
        		if (oldPassword==newPassword) {
        			$("#newPassword_msg").text("新旧密码不能相同").addClass("error_msg");
        			return false;
        		}
        		
        		$('#oldPassword_msg').empty();
       			$('#newPassword_msg').empty();
        		return true;
        	}
        	
        	function checkConfirmPassword(){
        		var confirmPassword = $("#confirmPassword").val();
        		if(confirmPassword == "") {
        			$("#confirmPassword_msg").text("请输入确认密码").addClass("error_msg");
        			return false;
        		}
        		var newPassword = $("#newPassword").val();
        		if (newPassword!=confirmPassword) {
        			$("#confirmPassword_msg").text("两次新密码必须相同").addClass("error_msg");
        			return false;
        		}
       			$('#confirmPassword_msg').empty();
        		return true;
        	}
        	
        	function saveAction(){
        		var flag=checkOldPassword() && checkNewPassword() && checkConfirmPassword();
        		if(!flag){
        			swal({
        				title:'Oh, My God !',
        				html:true,
        				text:'<span class="swal_error">新旧密码不符合规则,请检查 !</span>',
        				type:'error',
        				timer:2000
        			});
        			return false;
        		}
        		
        		sweetAlert({
			        title: "您确定要更改密码吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        closeOnConfirm: false
			    }, function() {
	        		var newPassword = $("#newPassword").val();
	        		$.post(
	        			"updatePassword.do",
	        			$("#updatePassword").serialize(),
				      	function(data) {
				      		if(data.success) {
				      			swal(data.message,"","success");
				      			setTimeout(function(){
				      				location.reload();
				       			}, 2000);
				      		} else {
				   				swal({
				       				title:'Oh, My God !',
				       				html:true,
				       				text:'<span class="swal_error">'+data.message+'</span>',
				       				type:'error',
				       				timer:2000
				          		});
				      		}
				      	}
				     );
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
        <div id="main">      
            <form action="#" method="post" class="main_form" id="updatePassword">
                <div class="text_info clearfix"><span>旧密码：</span></div>
                <div class="input_info">
                    <input type="password" class="width200" name="oldPassword" id="oldPassword"/>
                    <span class="required">*</span>
                    <div class="validate_msg_medium" id="oldPassword_msg">6~30长度以内的字母、数字和下划线的组合</div>
                </div>
                
                <div class="text_info clearfix"><span>新密码：</span></div>
                <div class="input_info">
                    <input type="password"  class="width200" name="newPassword" id="newPassword"/>
                    <span class="required">*</span>
                    <div class="validate_msg_medium" id="newPassword_msg">6~30长度以内的字母、数字和下划线的组合</div>
                </div>
                
                <div class="text_info clearfix"><span>确认密码：</span></div>
                <div class="input_info">
                    <input type="password" class="width200" id="confirmPassword"/>
                    <span class="required">*</span>
                    <div class="validate_msg_medium" id="confirmPassword_msg">两次新密码必须相同</div>
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
