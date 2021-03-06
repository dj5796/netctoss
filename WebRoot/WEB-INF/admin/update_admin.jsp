<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <!--SweetAlert提示框插件-->
        <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/sweetalert.min.js"></script> 
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/styles/sweetalert.css" /> 
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
        <script language="javascript" type="text/javascript" src="../js/jquery-1.11.1.js"></script>
        <script language="javascript" type="text/javascript">
        	$(function(){
        		$("#name")
        			.on('focus',function(){$("#name_msg").text('')})
        			.on('blur',checkName);
        		
        		$("#telephone")
        			.on('focus',function(){$("#telephone_msg").text('')})
        			.on('blur',checkTelephone);
        		
        		$("#email")
        			.on('focus',function(){$("#email_msg").text('')})
        			.on('blur',checkEmail);
        	});
        	
        	var nameFlag=true;
        	function checkName(){
        		var name = $("#name").val();
        		if(name == "") {
        			$("#name_msg").text("请输入姓名").addClass("error_msg");
        			nameFlag=false;
        			return false;
        		}
        		var reg = /^[a-zA-Z0-9\u4e00-\u9fa5]{2,20}$/;
        		if (!reg.test(name)) {
        			$("#name_msg").text("2~20长度以内的汉字、字母、数字的组合").addClass("error_msg");
        			nameFlag=false;
        			return false;
        		}
        		
        		var originalName="${admin.name}";
        		if(originalName==name){
        			nameFlag=true;
        			return true;
        		}
        		
        		$.post(
        			"checkAdminName.do",
        			{name:name},
        			function(data){
        				if(data) {
							$("#name_msg").text("有效的名称").removeClass("error_msg");
							nameFlag=true;
						} else {
							$("#name_msg").text("该名称已存在").addClass("error_msg");
							nameFlag=false;
						}
        			}
        				
        		);
        	}	
        	
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
        	
        	function saveAction(){
        		var flag=nameFlag && checkTelephone() && checkEmail() && checkRole();
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
			        title: "您确定要修改吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
		    			"updateAdmin.do",
		    			$('#updateAdmin').serialize(),
				      	function(data) {
				      		if(data) {
				      			swal("修改信息成功!","","success");
				      			setTimeout(function(){
				      				location.href=data;
				       			}, 2000);
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
        <!--主要区域开始-->
        <div id="main">            
            <form action="updateAdmin.do" method="post" class="main_form" id="updateAdmin">
        		<input type="hidden" name="admin_id" value="${admin.admin_id }"/>
	            <div class="text_info clearfix"><span>姓名：</span></div>
	                <div class="input_info">
	                  <input type="text" class="width180" name="name" id="name" value="${admin.name }"/>
	                  <span class="required">*</span>
	                  <div class="validate_msg_medium error_msg" id="name_msg"></div>
	            </div>
                
                <div class="text_info clearfix"><span>账号：</span></div>
                <div class="input_info">
                	<input type="text" readonly="readonly" class="width180 readonly" name="admin_code" value="${admin.admin_code }"/>
                </div>
                
                <div class="text_info clearfix"><span>电话：</span></div>
                <div class="input_info">
                     <input type="text" class="width180" name="telephone" id="telephone" value="${admin.telephone }"/>
                     <span class="required">*</span>
                     <div class="validate_msg_medium error_msg" id="telephone_msg"></div>
                </div>
               	
               	<div class="text_info clearfix"><span>Email：</span></div>
                <div class="input_info">
                     <input type="text" class="width280" name="email" id="email" value="${admin.email}"/>
                     <span class="required">*</span>
                     <div class="validate_msg_short error_msg" id="email_msg"></div>
                </div>
                
                <div class="text_info clearfix"><span>角色：</span></div>
                <div class="input_info_high">
                     <div class="input_info_scroll">
                         <ul>
                             <c:forEach items="${roles}" var="r">
                         		<li>
                         			<input type="checkbox" value="${r.role_id }" name="roleIds" onclick="checkRole();" 
                         				<c:forEach items="${admin.roles }" var="ar">
                         					<c:if test="${ar.role_id==r.role_id }">checked</c:if>
                         				</c:forEach>/>${r.name}
                         		</li>
                         	</c:forEach>
                         </ul>
                     </div>
                     <span class="required">*</span>
                     <div class="validate_msg_tiny error_msg" id="role_msg"></div>
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