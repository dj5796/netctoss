<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
        		
        		$("#real_name")
	    			.on('focus',function(){
	    				$("#real_name_msg").removeClass("error_msg")
	    				.text('2~20长度以内的汉字、字母和数字的组合');
	    			})
	    			.on('blur',checkRealName);
        		
        		$("#telephone")
	    			.on('focus',function(){
	    				$("#telephone_msg").text('正确的电话号码格式：手机或固话').removeClass("error_msg");
	    			})
	    			.on('blur',checkTelephone);
        		
        		$("#qq")
	    			.on('focus',function(){
	    				$("#qq_msg").text('5到13位数字').removeClass("error_msg");
	    			})
	    			.on('blur',checkQQ); 
        		
        		$("#email")
	    			.on('focus',function(){
	    				$("#email_msg").text('50长度以内，合法的 Email 格式').removeClass("error_msg");
	    			})
	    			.on('blur',checkEmail); 
        		
        		$("#mailaddress")
	    			.on('focus',function(){
	    				$("#mailaddress_msg").text('50长度以内').removeClass("error_msg");
	    			})
	    			.on('blur',checkMailAddress); 
        		
        		$("#zipcode")
	    			.on('focus',function(){
	    				$("#zipcode_msg").text('6位数字').removeClass("error_msg");
	    			})
	    			.on('blur',checkZipcode); 
        		
        		$("#recommender_idcardno")
	    			.on('focus',function(){
	    				$("#recommender_msg").text('正确的身份证号码格式')
	    				.removeClass("error_msg").removeClass("green");
	    			})
	    			.on('blur',search_recommender);
        		
        	});
        	
        	//旧密码
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
        	
        	//新密码
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
        	
        	//确认密码
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
        	
        	//姓名
	    	function checkRealName(){
	    		var real_name = $("#real_name").val();
	    		if(real_name == "") {
	    			$("#real_name_msg").text("请输入姓名").addClass("error_msg");
	    			return false;
	    		}
	    		var reg = /^[a-zA-Z0-9\u4e00-\u9fa5]{2,20}$/;
	    		if (!reg.test(real_name)) {
	    			$("#real_name_msg").text("2~20长度以内的汉字、字母、数字的组合").addClass("error_msg");
	    			return false;
	    		}
	    		$("#real_name_msg").empty();
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
        	
        	//QQ号码
        	function checkQQ(){
        		var qq=$('#qq').val();
        		if(qq==''){
        			$('#qq_msg').empty();
        			return true;
        		}
        		
        		var reg = /^\d{5,13}$/;
            	if(!reg.test(qq)){
            		$("#qq_msg").text("QQ格式不正确,请输入5到13位数字").addClass("error_msg");
            		return false;
            	}
            	$('#qq_msg').empty();
	    		return true;
        	}
        	
        	//Email
	    	function checkEmail(){
	    		var email = $("#email").val();
	    		if(email == "") {
	    			$('#email_msg').empty();
	    			return true;
	    		}
	    		var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	    		if (!reg.test(email)) {
	    			$("#email_msg").text("50长度以内，合法的 Email 格式").addClass("error_msg");
	    			return false;
	    		}
	   			$('#email_msg').empty();
	    		return true;
	    	}
        	
	    	//通信地址
	    	function checkMailAddress(){
	    		var mailaddress = $("#mailaddress").val();
	    		if(mailaddress == "") {
	    			$('#mailaddress_msg').empty();
	    			return true;
	    		}
	    		var reg = /^.{0,50}$/;
	    		if (!reg.test(email)) {
	    			$("#mailaddress_msg").text("50长度以内").addClass("error_msg");
	    			return false;
	    		}
	   			$('#mailaddress_msg').empty();
	    		return true;
	    	}
        	
	    	//邮编
	    	function checkZipcode(){
	    		var zipcode = $("#zipcode").val();
	    		if(zipcode == "") {
	    			$('#zipcode_msg').empty();
	    			return true;
	    		}
	    		var reg = /^\d{6}$/;
	    		if (!reg.test(zipcode)) {
	    			$("#zipcode_msg").text("6位数字").addClass("error_msg");
	    			return false;
	    		}
	   			$('#zipcode_msg').empty();
	    		return true;
	    	}

	    	//查询推荐人ID
        	var recommenderFlag=true;
        	function search_recommender() {
				//重置recommender_id
        		$("#recommender_id").val("");
        		$("#recommender_name").val("");
        		
            	//如果身份证为空，则返回
            	var idcardno = $("#recommender_idcardno").val();
            	if(idcardno == ""){
            		$("#recommender_msg").empty();
            		recommenderFlag=true;
            		return false;
            	}
            	
            	//如果身份证格式不对，则给出提示
            	var reg = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
            	if(!reg.test(idcardno)){
            		$("#recommender_msg").text("身份证号格式不正确！").addClass("error_msg");
            		recommenderFlag=false;
            		return false;
            	}
            	
            	$.post(
            		"searchAccount.do",
            		{"idcardNo":idcardno},
            		function(data) {
            			if(data=="") {
            				$("#recommender_msg").text("推荐人不存在！").removeClass("green").addClass("error_msg");
            				recommenderFlag=false;
            			} else {
            				$("#recommender_msg").text("推荐人有效！").removeClass("error_msg").addClass("green");
            				$("#recommender_id").val(data.account_id);
            				$("#recommender_name").val(data.real_name);
            				recommenderFlag=true;
            			}
            		}
            	);
        	}
        	
        	//提交时检查数据是否符合规则
	    	function saveAction(){
	    		var passwordArr=$("input:checkbox[id='changePassword']:checked");
        		console.log(passwordArr.length);
        		if(passwordArr.length==1){
        			if(!(checkOldPassword() && checkNewPassword() && checkConfirmPassword())){
		       			swal({
		       				title:'Oh, My God !',
		       				html:true,
		       				text:'<span class="swal_error">新旧密码不符合规则，请检查 !</span>',
		       				type:'error',
		       				timer:2000
		       			});
		       			return false;
        			}
        		}
        		
	    		var flag=checkRealName() && checkTelephone() && checkQQ() && checkEmail() 
	    				 && checkMailAddress() && checkZipcode() && recommenderFlag;
	    		console.log("flag==="+flag);
	    		if(!flag){
	       			swal({
	       				title:'Oh, My God !',
	       				html:true,
	       				text:'<span class="swal_error">表单中存在不符合规则的数据，请检查 !</span>',
	       				type:'error',
	       				timer:2000
	       			});
	       			return false;
	    		}
	    		
	    		sweetAlert({
			        title: "您确定要修改账号信息吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
						"updateAccount.do",
						$('#updateAccount').serialize(),
				      	function(data) {
				      		if(data.success) {
				      			swal(data.message,"","success");
				      			setTimeout(function(){
				       				location.href = "findAccount.do";
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
        	
	    	//显示修改密码的信息项
            function showPwd(chkObj) {
                if (chkObj.checked){
                    document.getElementById("divPwds").style.display = "block";
                    //选中时,将下面的三个输入框设置为可编辑,可以发送数据
                    $("#oldPassword").removeAttr("disabled");
        			$("#newPassword").removeAttr("disabled");
        			$("#confirmPassword").removeAttr("disabled");
                } else{
                    document.getElementById("divPwds").style.display = "none";
                  	//没有选中时,将下面的三个输入设置框为不可编辑,也就不可以发送数据
                    $("#oldPassword").attr("disabled","disabled");
        			$("#newPassword").attr("disabled","disabled");
        			$("#confirmPassword").attr("disabled","disabled");
                }
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
            <form action="updateAccount.do" method="post" class="main_form" id="updateAccount">
	            <!--必填项-->
	            <div class="text_info clearfix"><span>账号ID：</span></div>
	            <div class="input_info">
	                <input type="text" readonly="readonly" class="readonly width180" name="account_id" value="${account.account_id}"/>
	            </div>
	            
	            <div class="text_info clearfix"><span>登录账号：</span></div>
	            <div class="input_info">
	                <input type="text" readonly="readonly" class="readonly width180" value="${account.login_name }"/>        
	                <div class="validate_msg_long change_pwd">
	                    <input id="changePassword" class=".left .clearfix" type="checkbox" onclick="showPwd(this);"/>
	                    <label for="changePassword">修改密码</label>
	                </div>
	            </div>
	            <!--修改密码部分-->
	            <div id="divPwds">
	                <div class="text_info clearfix"><span>旧密码：</span></div>
	                <div class="input_info">
	                    <input type="password" class="width180" name="oldPassword" id="oldPassword"/>
	                    <span class="required">*</span>
	                    <div class="validate_msg_long" id="oldPassword_msg">6~30长度以内的字母、数字和下划线的组合</div>
	                </div>
	                <div class="text_info clearfix"><span>新密码：</span></div>
	                <div class="input_info">
	                    <input type="password" class="width180" name="login_passwd" id="newPassword"/>
	                    <span class="required">*</span>
	                    <div class="validate_msg_long" id="newPassword_msg">6~30长度以内的字母、数字和下划线的组合</div>
	                </div>
	                <div class="text_info clearfix"><span>重复新密码：</span></div>
	                <div class="input_info">
	                    <input type="password" class="width180" id="confirmPassword"/>
	                    <span class="required">*</span>
	                   <div class="validate_msg_long" id="confirmPassword_msg">两次新密码必须相同</div>
	                </div>  
	            </div>      
	            
	            <div class="text_info clearfix"><span>姓名：</span></div>
	            <div class="input_info">
	                <input type="text" class="width180" name="real_name" id="real_name" value="${account.real_name}" />
	                <span class="required">*</span>
	                <div class="validate_msg_long" id="real_name_msg"></div>
	            </div>
	            
	            <div class="text_info clearfix"><span>身份证：</span></div>
	            <div class="input_info">
	                <input type="text" readonly="readonly" class="readonly width180" value="${account.idcard_no }"/>
	            </div>
	            
	            <div class="text_info clearfix"><span>生日：</span></div>
	            <div class="input_info">
	                <input type="text" readonly="readonly" class="readonly width180" value="<fmt:formatDate value="${account.birthdate}" pattern="yyyy年MM月dd日"/>"/>
	            </div>
	            
	            <div class="text_info clearfix"><span>性别：</span></div>
	            <div class="input_info fee_type">
	                <input type="radio" name="gender" value="0" <c:if test="${account.gender==0 }">checked</c:if> id="secrecy"/>
	                <label for="secrecy" class="width30">保密</label>
	                <input type="radio" name="gender" value="1" <c:if test="${account.gender==1 }">checked</c:if> id="male"/>
	                <label for="male" class="width30">男</label>
	                <input type="radio" name="gender" value="2" <c:if test="${account.gender==2 }">checked</c:if> id="female"/>
	                <label for="female" class="width30">女</label>
	            </div> 
	            
	            <div class="text_info clearfix"><span>职业：</span></div>
	            <div class="input_info">
	                <select name="occupation" class="width150">
	                    <option value="0" <c:if test="${account.occupation==0 }">selected</c:if>>请选择:</option>
	                    <option value="1" <c:if test="${account.occupation==1 }">selected</c:if>>干部</option>
	                    <option value="2" <c:if test="${account.occupation==2 }">selected</c:if>>学生</option>
	                    <option value="3" <c:if test="${account.occupation==3 }">selected</c:if>>技术人员</option>
	                    <option value="4" <c:if test="${account.occupation==4 }">selected</c:if>>其他</option>
	                </select>                        
	            </div>
	            
	            <div class="text_info clearfix"><span>电话：</span></div>
	            <div class="input_info">
	                <input type="text" class="width180" name="telephone" id="telephone" value="${account.telephone }"/>
	                <span class="required">*</span>
	                <div class="validate_msg_long" id="telephone_msg"></div>
	            </div>
	            
	            <div class="text_info clearfix"><span>QQ号码：</span></div>
	            <div class="input_info">
	                <input type="text" class="width180" name="qq" id="qq" value="${account.qq }"/>
	                <div class="validate_msg_long" id="qq_msg"></div>
	            </div>
	            
	            <div class="text_info clearfix"><span>Email：</span></div>
	            <div class="input_info">
	                <input type="text" class="width300" name="email" id="email" value="${account.email}"/>
	    			<div class="validate_msg_short" id="email_msg"></div>
	            </div> 
	            
	            <div class="text_info clearfix"><span>通信地址：</span></div>
	            <div class="input_info">
	                <input type="text" name="mailaddress" class="width300" id="mailaddress" value="${account.mailaddress }"/>
	                <div class="validate_msg_short" id="mailaddress_msg"></div>
	            </div> 
	            
	            <div class="text_info clearfix"><span>邮编：</span></div>
	            <div class="input_info">
	                <input type="text" class="width180" name="zipcode" id="zipcode" value="${account.zipcode }"/>
	                <div class="validate_msg_long" id="zipcode_msg"></div>
	            </div> 
	                            
	            <div class="text_info clearfix"><span>推荐人：</span></div>
	            <div class="input_info">
	                <input type="text" class="width180" id="recommender_idcardno" value="${account.recommender_idcardno}"/>
	                <input type="hidden" name="recommender_id" id="recommender_id" value="${account.recommender_id}"/>
	                <div class="validate_msg_long" id="recommender_msg"></div>
	            </div>
                   
                <div class="text_info clearfix"><span>推荐人姓名：</span></div>
			    <div class="input_info">
			        <input type="text" readonly="readonly" class="width180 readonly" id="recommender_name" value="${account.recommender_name}"/>
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