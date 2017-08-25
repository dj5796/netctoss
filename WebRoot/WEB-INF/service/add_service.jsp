<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
        <script language="javascript" type="text/javascript" src="../js/jquery-1.11.1.js"></script>
        <script language="javascript" type="text/javascript">
	        $(function(){
	    		$("#idcard_no")
	    			.on('focus',function(){
	    				$("#idcard_no_msg").removeClass("error_msg").removeClass("green").text('请输入正确格式的身份证');
	    				$("#login_name_required").show();
	    			})
	    			.on('blur',check_idcard_no)
	    			.focus();
	    		
	    		$("#unix_host")
	    			.on('focus',function(){
	    				$("#unix_host_msg").removeClass("error_msg").text('15长度且符合地址规范的IP');
	    			})
	    			.on('blur',check_unix_host);
	    		
	    		$("#os_username")
	    			.on('focus',function(){
	    				$("#os_username_msg").removeClass("error_msg")
	    				.removeClass("green").text('3~8长度的字母、数字和下划线的组合');
	    			})
	    			.on('blur',check_os_username);
	    		
	    		$("#login_passwd")
	    			.on('focus',function(){
	    				$("#login_passwd_msg").removeClass("error_msg").text('6~30长度以内的字母、数字和下划线的组合');
	    			})
	    			.on('blur',check_login_passwd);
	    		 
	    		$("#confirm_password")
	    			.on('focus',function(){
	    				$("#confirm_password_msg").removeClass("error_msg").text('两次密码必须相同');
	    			})
	    			.on('blur',check_confirm_password);
	    		
	    	}); 
	        
            //查询账务账号
            //saveAction中调用find_account返回值为undefined,因为前台通过ajax进行异步验证需要时间,
            //但是程序依然往下执行,此时校验还没有完成,返回值为undefined,可以通过定义全局变量来解决
            var idcardNoFlag=null;
            function check_idcard_no() {
            	var idcard_no = $("#idcard_no").val();
            	if(idcard_no == "") {
            		$("#idcard_no_msg").text("身份证不能为空").addClass("error_msg");
            		idcardNoFlag=false;
            		return false;
            	}
            	var reg = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
            	if(!reg.test(idcard_no)) {
            		$("#idcard_no_msg").text("请输入正确格式的身份证").addClass("error_msg");
            		idcardNoFlag=false;
            		return false;
            	}
            	
            	//身份证格式正确后提醒查询账户账号是否存在
            	$("#idcard_no_msg").text("请查询账户账号").removeClass("error_msg").addClass("green");
            	idcardNoFlag=true;
            }
            
            function find_account() {
            	if(!idcardNoFlag) {
            		return false;
            	}
            	var idcard_no = $("#idcard_no").val();
            	$.post(
            		"findAccount.do",
            		{"idcardNo":idcard_no},
            		function(data) {
            			if(data) {
            				if(data.status==0){
	            				$("#idcard_no_msg").text("有效的身份证.").removeClass("error_msg");
	            				$("#login_name").val(data.login_name);
	            				$("#account_id").val(data.account_id);
	            				$('#login_name_msg').empty();
				            	$("#login_name_required").hide();
	            				idcardNoFlag=true;
            				} else{
	            				$("#idcard_no_msg").text("此身份证对应的账务账号还没有开通！").addClass("error_msg");
	            				$("#login_name").val(data.login_name);
	            				$("#account_id").val(data.account_id);
	            				idcardNoFlag=false;
            				}
            			} else {
            				$("#idcard_no_msg").text("此身份证没有对应的账务账号.").addClass("error_msg");
            				$('#login_name').val("");
            				idcardNoFlag=false;
            			}
            		}
            	);
            }
            

            function check_unix_host(){
            	var unix_host=$('#unix_host').val();
	            if(unix_host==""){
	            	$('#unix_host_msg').text("请输入IP的地址").addClass("error_msg");
	            	return false;
	            }
	            
	            var reg = /^(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$/;
        		if (!reg.test(unix_host)) {
        			$("#unix_host_msg").text("15长度且符合地址规范的IP").addClass("error_msg");
        			return false;
        		}
        		
       			$('#unix_host_msg').empty();
        		return true;
            }
            
            //同一个服务器上的os账号必须唯一
            var os_usernameFlag=null;
            function check_os_username(){
            	var os_username=$('#os_username').val();
	            if(os_username==""){
	            	$('#os_username_msg').text("请输入 OS 账号").addClass("error_msg");
	            	os_usernameFlag=false;
	            	return false;
	            }
	            
	            var reg = /^[a-zA-Z0-9_]{3,8}$/;
        		if (!reg.test(os_username)) {
        			$("#os_username_msg").text("3~8长度的字母、数字和下划线的组合").addClass("error_msg");
        			os_usernameFlag=false;
        			return false;
        		}
        		
        		var unix_host=$('#unix_host').val();
        		if(unix_host==""){
        			$("#os_username_msg").text("服务器IP不能为空").addClass("error_msg");
        			os_usernameFlag=false;
        			return false;
        		}
        		
        		$.post(
               		"checkOS_UsernameByIP.do",
               		{os_username:os_username,ip:unix_host},
               		function(data) {
               			if(data) {
               				$("#os_username_msg").text(unix_host+' 尚未开通该 OS 账号,可以注册')
               					.removeClass("error_msg").addClass("green");
               				os_usernameFlag=true;
               			} else {
               				$("#os_username_msg").text(unix_host+'服务器上已经开通过 OS 账号 "'+os_username+'"').addClass("error_msg");
               				os_usernameFlag=false;
               			}
               		}
               	);
            }
            
	        function check_login_passwd(){
        		var login_passwd = $("#login_passwd").val();
        		if(login_passwd == "") {
        			$("#login_passwd_msg").text("请输入密码").addClass("error_msg");
        			return false;
        		}
        		
        		var reg = /^[a-zA-Z0-9_]{6,30}$/;
        		if (!reg.test(login_passwd)) {
        			$("#login_passwd_msg").text("6~30长度以内的字母、数字和下划线的组合").addClass("error_msg");
        			return false;
        		}
        		
       			$('#login_passwd_msg').empty();
        		return true;
        	}
        	
        	function check_confirm_password(){
        		var confirm_password = $("#confirm_password").val();
        		if(confirm_password == "") {
        			$("#confirm_password_msg").text("请输入确认密码").addClass("error_msg");
        			return false;
        		}
        		
        		var login_passwd = $("#login_passwd").val();
        		if (login_passwd!=confirm_password) {
        			$("#confirm_password_msg").text("两次密码必须相同").addClass("error_msg");
        			return false;
        		}
        		
       			$('#confirm_password_msg').empty();
        		return true;
        	}
        	
        	function saveAction(){
        		var login_name=$('#login_name').val();
        		if(!login_name){
        			$('#login_name_msg').text("账务账号不能为空").addClass("error_msg");
        			return false;
        		}
        		
        		var flag=idcardNoFlag && check_unix_host() && os_usernameFlag 
        				 && check_login_passwd() && check_confirm_password();
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
			        title: "您确定要增加吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
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
            <form action="addService.do" method="post" class="main_form">
                <!--内容项-->
                <div class="text_info clearfix"><span>身份证：</span></div>
                <div class="input_info">
                    <input type="text" class="width180" id="idcard_no"/>
                    <span class="required">*</span>
                    <input type="button" value="查询账务账号" class="btn_search_large" onclick="find_account();"/>
                    <div class="validate_msg_short" id="idcard_no_msg"></div>
                </div>
                
                <div class="text_info clearfix"><span>账务账号：</span></div>
                <div class="input_info">
                	<input type="hidden" class="width180" name="account_id" id="account_id"/>
                    <input type="text" readonly="readonly" class="readonly width180" id="login_name"/>
                	<span class="required">*</span><span class="green" id="login_name_required">&nbsp;&nbsp;通过身份证查询出来</span>
                    <div class="validate_msg_short" id="login_name_msg"></div>
                </div>
                
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info">
                    <select name="cost_id" style="width:185px;">
                        <c:forEach items="${costs}" var="cost">
                        	<option value="${cost.cost_id}">${cost.name }</option>
                        </c:forEach>
                    </select>                        
	                <span class="required">*</span> 
                </div>
                
                <div class="text_info clearfix"><span>服务器IP：</span></div>
                <div class="input_info">
                    <input type="text" class="width180" name="unix_host" id="unix_host"/>
                    <span class="required">*</span>
                    <div class="validate_msg_medium" id="unix_host_msg"></div>
                </div>                   
                
                <div class="text_info clearfix"><span>登录OS账号：</span></div>
                <div class="input_info">
                    <input type="text" class="width180" name="os_username" id="os_username"/>
                    <span class="required">*</span>
                    <div class="validate_msg_medium error_msg" id="os_username_msg"></div>
                </div>
                
                 <div class="text_info clearfix"><span>密码：</span></div>
                 <div class="input_info">
                     <input type="password" class="width180" name="login_passwd" id="login_passwd"/>
                     <span class="required">*</span>
                     <div class="validate_msg_medium error_msg" id="login_passwd_msg"></div>
                 </div>
                 
                 <div class="text_info clearfix"><span>确认密码：</span></div>
                 <div class="input_info">
                     <input type="password" class="width180" name="confirm_password" id="confirm_password"/>
                     <span class="required">*</span>
                     <div class="validate_msg_medium error_msg" id="confirm_password_msg"></div>
                 </div>  
                
                <!--操作按钮-->
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