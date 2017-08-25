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
	    		$("#real_name")
	    			.on('focus',function(){
	    				$("#real_name_msg").removeClass("error_msg")
	    				.text('2~20长度以内的汉字、字母和数字的组合');
	    			})
	    			.on('blur',checkRealName)
	    			.focus();
	    		
	    		$("#idcard_no")
	    			.on('focus',function(){
	    				$("#idcard_no_msg").text('正确的身份证号码格式')
	    				.removeClass("green").removeClass("error_msg");
	    			})
	    			.on('blur',checkIdcard_no);
	    		
	    		$("#login_name")
	    			.on('focus',function(){
	    				$("#login_name_msg").text('3~20长度以内的字母、数字和下划线的组合')
	    				.removeClass("green").removeClass("error_msg");
	    			})
	    			.on('blur',checkLoginName);
	    		
	    		$("#login_passwd")
	    			.on('focus',function(){
	    				$("#login_passwd_msg").text('6~30长度以内的字母、数字和下划线的组合')
	    				.removeClass("error_msg");
	    			})
	    			.on('blur',checkLoginPasswd);
	    		 
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
	    		
	    		/*-----------------选填项-----------------*/
	    		
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
	        
	        //身份证
	    	var idcardNoFlag=null;
	    	function checkIdcard_no() {
	    		//重置生日
	    		$("#birthdate").val("");
	    		
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
            	
            	$.post(
	       			"searchAccount.do",
	       			{idcardNo:idcard_no},
	       			function(data){
	       				if(!data) {
							$("#idcard_no_msg").text("身份证尚未开通账务账号,可以注册!").removeClass("error_msg").addClass("green");
							//根据身份证提取出生日，赋值给生日字段
			            	var birthdate=idcard_no.substring(6,10)+"-"+idcard_no.substring(10,12)+"-"+idcard_no.substring(12,14);
			            	$("#birthdate").val(birthdate);
							idcardNoFlag=true;
						} else {
							$("#idcard_no_msg").text("该身份证已经开通过账务账号!").removeClass("green").addClass("error_msg");
							idcardNoFlag=false;
						}
	       			}
	       		);
            	
            	$("#idcard_no_msg").empty();
            	return true;
            }
	    	
	    	//登录账号
	    	var loginNameFlag=null;
	    	function checkLoginName(){
	    		var login_name = $("#login_name").val();
	    		if(login_name == "") {
	    			$("#login_name_msg").text("请输入登录账号").addClass("error_msg");
	    			loginNameFlag=false;
	    			return false;
	    		}
	    		var reg = /^[a-zA-Z0-9_]{3,20}$/;
	    		if (!reg.test(login_name)) {
	    			$("#login_name_msg").text("3~20长度以内的字母、数字和下划线的组合").addClass("error_msg");
	    			loginNameFlag=false;
	    			return false;
	    		}
	    		
	    		$.post(
	       			"findAccountByLoginName.do",
	       			{loginName:login_name},
	       			function(data){
	       				if(data.success) {
							$("#login_name_msg").text(data.message).removeClass("error_msg").addClass("green");
							loginNameFlag=true;
						} else {
							$("#login_name_msg").text(data.message).addClass("error_msg");
							loginNameFlag=false;
						}
	       			}
	       		);
	    	}	
	    	
	    	//密码
	    	function checkLoginPasswd(){
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
	    	
	    	//确认密码
	    	function checkConfirmPassword(){
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
	    
        	//------------------------------下面为选填项-------------------------------
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
	    		var mainFlag=checkRealName() && idcardNoFlag && loginNameFlag && 
	    					 checkLoginPasswd() && checkConfirmPassword() && checkTelephone();
	    		//console.log("mainFlag==="+mainFlag);
	    		if(!mainFlag){
	       			swal({
	       				title:'Oh, My God !',
	       				html:true,
	       				text:'<span class="swal_error">必填项中存在不符合规则的数据，请检查 !</span>',
	       				type:'error',
	       				timer:2000
	       			});
	       			return false;
	    		}
	    		//console.log("recommenderFlag==="+recommenderFlag);
        		var optionalFlag=checkQQ() && checkEmail() && checkMailAddress() && checkZipcode() && recommenderFlag;
	    		if(!optionalFlag){
	       			swal({
	       				title:'Oh, My God !',
	       				html:true,
	       				text:'<span class="swal_error">选填项中存在不符合规则的数据，请检查 !</span>',
	       				type:'error',
	       				timer:2000
	       			});
	       			return false;
	    		}
	    		
	    		sweetAlert({
			        title: "您确定要增加账号吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        confirmButtonColor: "#EC6C62",
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
		    			"addAccount.do",
		    			$('#addAccount').serialize(),
				      	function(data) {
				      		if(data) {
				      			swal("增加成功!","","success");
				      			setTimeout(function(){
				      				location.href="findAccount.do";
				       			}, 2000);
				      		} else {
				   				swal({
				       				title:'Oh, My God !',
				       				html:true,
				       				text:'<span class="swal_error">增加失败,请稍后重试!</span>',
				       				type:'error',
				       				timer:2000
				          		});
				      		}
				      	}
				     );
			    });
	    	}
        	
			//显示选填的信息项
			function showOptionalInfo(imgObj) {
			    var div = document.getElementById("optionalInfo");
			    if (div.className == "hide") {
			        div.className = "show";
			        imgObj.src = "../images/hide.png";
			    } else {
			        div.className = "hide";
			        imgObj.src = "../images/show.png";
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
            <form action="addAccount.do" method="post" class="main_form" id="addAccount">
                <!--必填项-->
                <div class="text_info clearfix"><span>姓名：</span></div>
	            <div class="input_info">
	                <input type="text" class="width180" name="real_name" id="real_name"/>
	             	<span class="required">*</span>
	             	<div class="validate_msg_long" id="real_name_msg">2~20长度以内的汉字、字母和数字的组合</div>
	            </div>
	            
	            <div class="text_info clearfix"><span>身份证：</span></div>
                <div class="input_info">
                    <input type="text" class="width180" name="idcard_no" id="idcard_no"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long" id="idcard_no_msg">正确的身份证号码格式</div>
                </div>
                
                <div class="text_info clearfix"><span>登录账号：</span></div>
                <div class="input_info">
                    <input type="text" class="width180" name="login_name" id="login_name"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long" id="login_name_msg">3~20长度以内的字母、数字和下划线的组合</div>
                </div>
                
                <div class="text_info clearfix"><span>密码：</span></div>
                <div class="input_info">
                    <input type="password" class="width180" name="login_passwd" id="login_passwd"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long" id="login_passwd_msg">6~30长度以内的字母、数字和下划线的组合</div>
                </div>
                <div class="text_info clearfix"><span>确认密码：</span></div>
                <div class="input_info">
                    <input type="password" class="width180" id="confirm_password"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long" id="confirm_password_msg">两次密码必须相同</div>
                </div>     
                <div class="text_info clearfix"><span>电话：</span></div>
                <div class="input_info">
                    <input type="text" class="width180" name="telephone" id="telephone"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long" id="telephone_msg">正确的电话号码格式：手机或固话</div>
                </div>     
                           
				<!--选填项-->
				<div class="text_info clearfix"><span>选填项：</span></div>
				<div class="input_info">
				    <img src="../images/show.png" alt="展开" onclick="showOptionalInfo(this);" />
				</div>
				<div id="optionalInfo" class="hide" style="height:438px;">
				    <div class="text_info clearfix"><span>职业：</span></div>
				    <div class="input_info">
				        <select name="occupation" class="width150">
				        	<option value="0">请选择:</option>
				            <option value="1">干部</option>
				            <option value="2">学生</option>
				            <option value="3">技术人员</option>
				            <option value="4">其他</option>
				        </select>                        
				    </div>
				    
				    <div class="text_info clearfix"><span>性别：</span></div>
				    <div class="input_info fee_type">
				        <input type="radio" name="gender" value="0" checked="checked" id="secrecy" />
				        <label for="secrecy" class="width30">保密</label>
				        <input type="radio" name="gender" value="1" id="male" />
				        <label for="male" class="width30">男</label>
				        <input type="radio" name="gender" value="2" id="female" />
				        <label for="female" class="width30">女</label>
				    </div>
				    
				    <div class="text_info clearfix"><span>生日：</span></div>
				    <div class="input_info">
				        <input type="text" readonly="readonly" class="width180 readonly" name="birthdate" id="birthdate"/>
				    </div>
				    
				    <div class="text_info clearfix"><span>QQ号码：</span></div>
				    <div class="input_info">
				        <input type="text" class="width180" name="qq" id="qq"/>
				        <div class="validate_msg_long" id="qq_msg">5到13位数字</div>
				    </div> 
				    
				    <div class="text_info clearfix"><span>Email：</span></div>
				    <div class="input_info">
				        <input type="text" class="width300" name="email" id="email"/>
				        <div class="validate_msg_short" id="email_msg">50长度以内，合法的 Email 格式</div>
				    </div>
				     
				    <div class="text_info clearfix"><span>通信地址：</span></div>
				    <div class="input_info">
				        <input type="text" class="width300" name="mailaddress" id="mailaddress"/>
				        <div class="validate_msg_short" id="mailaddress_msg">50长度以内</div>
				    </div> 
				    
				    <div class="text_info clearfix"><span>邮编：</span></div>
				    <div class="input_info">
				        <input type="text" class="width180" name="zipcode" id="zipcode"/>
				        <div class="validate_msg_long" id="zipcode_msg">6位数字</div>
				    </div> 
				    
				    <div class="text_info clearfix"><span>推荐人身份证：</span></div>
				    <div class="input_info">
				        <input type="text" class="width180" id="recommender_idcardno"/>
				        <input type="hidden" class="width180" name="recommender_id" id="recommender_id"/>
				        <div class="validate_msg_long" id="recommender_msg">正确的身份证号码格式</div>
				    </div>
				    
				    <div class="text_info clearfix"><span>推荐人姓名：</span></div>
				    <div class="input_info">
				        <input type="text" readonly="readonly" class="width180 readonly" id="recommender_name"/>
				    </div>
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