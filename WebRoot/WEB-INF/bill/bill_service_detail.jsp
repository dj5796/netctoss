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
            <form action="" method="post">
                <!--查询-->
                <div class="search_add">       
                    <div>账务账号：<span class="readonly width70">${login_name}</span></div>                            
                    <div>OS 账号：<span class="readonly width100">${billItem.os_username}</span></div>
                    <div>服务器 IP：<span class="readonly width100">${billItem.unix_host}</span></div>
                    <div>计费时间：<span class="readonly width70">
                    	<fmt:parseDate value="${billItem.month_id}" pattern="yyyy-MM" var="date" ></fmt:parseDate>
                    	<fmt:formatDate value="${date}" pattern="yyyy年MM月"/>
                    </span></div>
                    <div>费用：<span class="readonly width70"><fmt:formatNumber value="${billItem.cost}" pattern="¥0.00元" type="currency"/></span></div>
                    <input type="button" value="返回" class="btn_add" onclick="history.back();"/>
                </div>  
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th>序号</th>
                            <th class="width120">客户登录 IP</th>
                            <th class="width150">登入时刻</th>
                            <th class="width150">登出时刻</th>
                            <th class="width100">时长</th>
                            <th>资费名称</th>
                            <th class="width90">费用</th>
                            <th class="width100">累积费用</th>
                        </tr>
                        <c:forEach items="${serviceDetails}" var="serviceDetail">
	                        <tr>
	                            <td>${serviceDetail.num}</td>
	                            <td>${serviceDetail.unix_host}</td>
	                            <td><fmt:formatDate value="${serviceDetail.login_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                            <td><fmt:formatDate value="${serviceDetail.logout_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                            <td>${serviceDetail.duration_str}</td>
	                            <td>${billItem.cost_name}</td>
	                            <td><fmt:formatNumber value="${serviceDetail.cost}" type="currency"/></td>
	                            <td><fmt:formatNumber value="${serviceDetail.sum_cost}" type="currency"/></td>
	                        </tr>
                        </c:forEach>
                    </table>
                </div>
                <!--分页-->
                <div id="pages">
                    <a href="findBillDetail.do?itemId=${itemId}&currentPage=1">首页</a>
                	<c:choose>
                		<c:when test="${billDetailPage.currentPage==1}">
                			<a href="#">上一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findBillDetail.do?itemId=${itemId}&currentPage=${billDetailPage.currentPage-1}">上一页</a>
                		</c:otherwise>
                	</c:choose>
        	        
        	        <c:forEach begin="1" end="${billDetailPage.totalPage}" var="p">
        	        	<c:choose>
        	        		<c:when test="${p==billDetailPage.currentPage}">
        	        			<a href="findBillDetail.do?itemId=${itemId}&currentPage=${p}" class="current_page">${p }</a>
        	        		</c:when>
        	        		<c:otherwise>
        	        			<a href="findBillDetail.do?itemId=${itemId}&currentPage=${p}">${p}</a>
        	        		</c:otherwise>
        	        	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                		<c:when test="${billDetailPage.currentPage==billDetailPage.totalPage}">
                			<a href="#">下一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findBillDetail.do?itemId=${itemId}&currentPage=${billDetailPage.currentPage+1}">下一页</a>
                		</c:otherwise>
                	</c:choose>
                    <a href="findBillDetail.do?itemId=${itemId}&currentPage=${billDetailPage.totalPage}">末页</a>
                </div>                   
            </form>
        </div>
        <!--主要区域结束-->
        <jsp:include page="../main/copyright.jsp"/> 
    </body>
</html>
