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
            <form action="#" method="post" class="main_form">
                <!--必填项-->
                <div class="text_info clearfix"><span>业务账号ID：</span></div>
                <div class="input_info"><input type="text" value="${service.service_id}" readonly="readonly" class="readonly width180" /></div>
                <div class="text_info clearfix"><span>账务账号ID：</span></div>
                <div class="input_info"><input type="text" value="${service.account_id}" readonly="readonly" class="readonly width180" /></div>
                <div class="text_info clearfix"><span>客户姓名：</span></div>
                <div class="input_info"><input type="text" readonly="readonly" class="readonly width180" value="${service.real_name}" /></div>
                <div class="text_info clearfix"><span>身份证号码：</span></div>
                <div class="input_info"><input type="text" readonly="readonly" class="readonly width180" value="${service.idcard_no}" /></div>
                <div class="text_info clearfix"><span>服务器 IP：</span></div>
                <div class="input_info"><input type="text" value="${service.unix_host}" readonly="readonly" class="readonly width180" /></div>
                <div class="text_info clearfix"><span>OS 账号：</span></div>
                <div class="input_info"><input type="text" value="${service.os_username}" readonly="readonly" class="readonly width180" /></div>
                <div class="text_info clearfix"><span>开通状态：</span></div>
                <div class="input_info">
                    <select disabled="disabled" class="width100">
                        <option <c:if test="${service.status==0}">selected="selected"</c:if>>开通</option>
                        <option <c:if test="${service.status==1}">selected="selected"</c:if>>暂停</option>
                        <option <c:if test="${service.status==2}">selected="selected"</c:if>>删除</option>
                    </select>                        
                </div>
                <div class="text_info clearfix"><span>开通/暂停/删除：</span></div>
                <div class="input_info">
                	<c:choose>
                		<c:when test="${service.status==0}">
		                	<input type="text" value="<fmt:formatDate value="${service.create_date}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="readonly" class="readonly width180" />
                		</c:when>
                		<c:when test="${service.status==1}">
		                	<input type="text" value="<fmt:formatDate value="${service.pause_date}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="readonly" class="readonly width180" />
                		</c:when>
                		<c:otherwise>
		                	<input type="text" value="<fmt:formatDate value="${service.close_date}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="readonly" class="readonly width180" />
                		</c:otherwise>
                	</c:choose>
                </div>
                <div class="text_info clearfix"><span>资费 ID：</span></div>
                <div class="input_info"><input type="text" value="${service.cost_id}" class="readonly width180" readonly="readonly" /></div>
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info"><input type="text" value="${service.name}" readonly="readonly" class="width250 readonly" /></div>
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea class="width300 height70 readonly" readonly="readonly">${service.descr}</textarea>
                </div>  
                <!--操作按钮-->
                <div class="button_info clearfix">
                    <input type="button" value="返回" class="btn_save" onclick="history.back();"/>
                </div>
            </form>
        </div>
        <!--主要区域结束-->
        <jsp:include page="../main/copyright.jsp"/>
    </body>
</html>
