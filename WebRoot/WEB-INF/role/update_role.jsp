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
	    		$('#name')
	    			.on('blur',check_name)
	    			.on('focus',function(){
	    				$('#name_msg').empty();
	    			});
	    	});
	        
	      	//全局变量:save方法中check_name需要通过ajax到后台校验,需要时间
	    	var nameFlag=true;
	    	function check_name() {
	    		var name = $("#name").val();
	    		var reg = /^[\u4E00-\u9FA5A-Za-z0-9]{2,20}$/;
	    		if(!reg.test(name)) {
	    			$("#name_msg").text("不能为空，且为2~20长度的字母、数字和汉字的组合").addClass("error_msg");
	    			nameFlag = false;
	    			return false;
	    		}
	    		
	    		var originalName="${role.name}";
	    		if(originalName==name){
	    			nameFlag=true;
	    			return true;
	    		}
			
				$.post(
					"checkRoleName.do",
					{"name":name},
					function(data) {
						if(data) {
							$("#name_msg").text("有效的名称.").removeClass("error_msg");
							nameFlag = true;
						} else {
							$("#name_msg").text("该名称已存在.").addClass("error_msg");
							nameFlag = false;
						}
					}
				);
	    	}
	    	
	    	function check_module() {
	    		var moduleIds = $(":checkbox[name='moduleIds']:checked");
	    		if(moduleIds.length == 0) {
	    			$("#module_msg").text("请至少选择一个模块.").addClass("error_msg");
	    			return false;
	    		} else {
	    			$("#module_msg").text("").removeClass("error_msg");
	    			return true;
	    		}
	    	}
	    	
	    	function save() {
	    		check_name();
	  			if(!(nameFlag && check_module())) {
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
            		title:"确定要更改此角色吗？", 
			        type: "warning", 
			        showCancelButton: true,
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
			    		"updateRole.do",
			    		$('#updateRole').serialize(),
				      	function(data) {
				      		if(data) {
				      			swal("成功更改角色!","","success");
				      			setTimeout(function(){
				      				location.href = data;
				       			}, 2000);
				      		} else {
				   				swal({
				       				title:'Oh, My God !',
				       				html:true,
				       				text:'<span class="swal_error">更改角色失败,请稍后重试!</span>',
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
        <!--主要区域开始-->
        <div id="main">           
            <form action="updateRole.do" method="post" class="main_form" id="updateRole">
            	<input type="hidden" name="role_id" value="${role.role_id }"/>
            	
            	<div class="text_info clearfix"><span>角色名称：</span></div>
                <div class="input_info">
                    <input type="text" class="width200" name="name" id="name" value="${role.name }"/>
                    <span class="required">*</span>
                    <div class="validate_msg_medium" id="name_msg"></div>
                </div>        
            	
            	<div class="text_info clearfix"><span>设置权限：</span></div>
                <div class="input_info_high">
                    <div class="input_info_scroll">
                        <ul>
                        	<c:forEach items="${modules}" var="m">
                            	<li>
                            		<input type="checkbox" value="${m.module_id }" name="moduleIds" onclick="check_module();"
                            			<c:forEach items="${role.modules }" var="rm">
				                    		<c:if test="${rm.module_id==m.module_id }">checked</c:if>
				                    	</c:forEach>
                            		/>${m.name }
                            	</li>
                            </c:forEach>
                        </ul>
                    </div>
                    <span class="required">*</span>
                    <div class="validate_msg_tiny" id="module_msg"></div>
                </div>
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="save();"/>
                    <input type="button" value="取消" class="btn_save" onclick="history.back();"/>
                </div>
            </form> 
        </div>
        <!--主要区域结束:版权区域-->
    	<jsp:include page="../main/copyright.jsp"/>
    </body>
</html>