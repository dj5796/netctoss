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
                    <div>姓名：<span class="readonly width70">${bill.real_name}</span></div>
                    <div>身份证：<span class="readonly width150">${bill.idcard_no}</span></div>
                    <div>账务账号：<span class="readonly width70">${bill.login_name}</span></div>                            
                    <div>计费时间：<span class="readonly width70">
                    	<fmt:parseDate value="${bill.bill_month}" pattern="yyyy-MM" var="date" ></fmt:parseDate>
                    	<fmt:formatDate value="${date}" pattern="yyyy年MM月"/>
                    </span></div>
                    <div>总费用：<span class="readonly width70">
                    	<fmt:formatNumber value="${bill.cost}" type="currency" pattern="¥0.00元"/></span>
                    </div>
                    <input type="button" value="返回" class="btn_add" onclick="history.back();"/>
                </div>  
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                        	<th>序号</th>
                            <th class="width70">账单明细ID</th>
                            <th class="width150">OS 账号</th>
                            <th class="width150">服务器 IP</th>
                            <th class="width70">账务账号ID</th>
                            <th class="width150">时长</th>
                            <th class="width150">资费名称</th>
                            <th>费用</th>
                            <th class="width50"></th>
                        </tr>
                        <c:forEach items="${billItems}" var="billItem">
	                        <tr>
	                            <td>${billItem.NUM}</td>
	                            <td>${billItem.id}</td>
	                            <td>${billItem.os_username}</td>
	                            <td>${billItem.unix_host}</td>
	                            <td>${billItem.account_id}</td>
	                            <td>${billItem.sofar_duration_str}</td>
	                            <td>${billItem.cost_name}</td>                          
	                            <td><fmt:formatNumber value="${billItem.cost}" type="currency"/></td>
	                            <td><a href="findBillDetail.do?itemId=${billItem.id}" title="业务详单">详单</a></td>
	                        </tr>
                        </c:forEach>
                    </table>
                </div>
                <!--分页-->
                <div id="pages">
                    <a href="findBillItem.do?billId=${billId}&currentPage=1">首页</a>
                	<c:choose>
                		<c:when test="${billItemPage.currentPage==1 }">
                			<a href="#">上一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findBillItem.do?billId=${billId}&currentPage=${billItemPage.currentPage-1}">上一页</a>
                		</c:otherwise>
                	</c:choose>
        	        
        	        <c:forEach begin="1" end="${billItemPage.totalPage }" var="p">
        	        	<c:choose>
        	        		<c:when test="${p==billItemPage.currentPage }">
        	        			<a href="findBillItem.do?billId=${billId}&currentPage=${p }" class="current_page">${p}</a>
        	        		</c:when>
        	        		<c:otherwise>
        	        			<a href="findBillItem.do?billId=${billId}&currentPage=${p }">${p }</a>
        	        		</c:otherwise>
        	        	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                		<c:when test="${billItemPage.currentPage==billItemPage.totalPage }">
                			<a href="#">下一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findBillItem.do?billId=${billId}&currentPage=${billItemPage.currentPage+1 }">下一页</a>
                		</c:otherwise>
                	</c:choose>
                    <a href="findBillItem.do?billId=${billId}&currentPage=${billItemPage.totalPage }">末页</a>
                </div>                         
            </form>
        </div>
        <!--主要区域结束-->
        <jsp:include page="../main/copyright.jsp"/> 
    </body>
</html>
