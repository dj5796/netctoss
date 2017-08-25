<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
        <script language="javascript" type="text/javascript">
	        function saveAction(){
	        	var serviceCostId=${service.cost_id};
	        	var costCostId = $("option[name='costCostId']:selected").val();
	        	
	    		if(serviceCostId==costCostId){
	    			swal({
	    				title:'Oh, My God !',
	    				html:true,
	    				text:'<span class="swal_error">资费类型不能相同,请重新选择操作</span>',
	    				type:'error',
	    				timer:2000
	    			});
	    			return false;
	    		}
	    		
	    		sweetAlert({
			        title: "您确定更改资费类型吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        confirmButtonColor: "#EC6C62",
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
			    		"updateService.do",
		    			$('#updateService').serialize(),
				      	function(data) {
				      		if(data) {
				      			swal("更改资费类型成功!","","success");
				      			setTimeout(function(){
				      				location.href="findService.do";
				       			}, 2000);
				      		} else {
				   				swal({
				       				title:'Oh, My God !',
				       				html:true,
				       				text:'<span class="swal_error">更改资费类型失败,请稍后重试!</span>',
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
            <form action="updateService.do" id="updateService" method="post" class="main_form">
                <!--必填项-->
                <div class="text_info clearfix"><span>业务账号ID：</span></div>
                <div class="input_info">
                    <input type="text" name="service_id" value="${service.service_id }" readonly="readonly" class="readonly" />
                </div>
                <div class="text_info clearfix"><span>OS 账号：</span></div>
                <div class="input_info">
                    <input type="text" name="os_username" value="${service.os_username }" readonly="readonly" class="readonly" />
                </div>
                <div class="text_info clearfix"><span>服务器 IP：</span></div>
                <div class="input_info">
                    <input type="text" name="unix_host" value="${service.unix_host }" readonly="readonly" class="readonly" />
                </div>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info">
                    <select name="cost_id" style="width:174px;">
                        <c:forEach items="${costs }" var="cost">
                        	<option value="${cost.cost_id}" <c:if test="${cost.cost_id==service.cost_id}">selected</c:if>>${cost.name}</option>
                        </c:forEach>
                    </select>
                    <span class="required">*</span><span class="green">&nbsp;&nbsp;请修改或者取消操作</span>
                </div>
               <!--操作按钮-->
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="saveAction();"/>
                    <input type="button" value="取消" class="btn_save" onclick="history.back();"/>
                </div>
                
                <p>业务说明：<br />
                1、修改资费后，点击保存，并未真正修改数据库中的数据；<br />
                2、提交操作到消息队列；<br />
                3、每月月底由程序自动完成业务所关联的资费；</p>
            </form>  
        </div>
        <!--主要区域结束:版权区域-->
    	<jsp:include page="../main/copyright.jsp"/>
    </body>
</html>