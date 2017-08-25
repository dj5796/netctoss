<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" /> 
        <script type="text/javascript" src="../js/jquery-1.11.1.js"></script> 
        <script type="text/javascript">
        	$(function(){
        		initialYearAndMonth();
        		showSelectedYearAndMonth();
        	});
        	
        	//显示被选中的年月
        	function showSelectedYearAndMonth(){
        		var year=${billPage.year};
        		var month=${billPage.month}
        		$("option[value="+year+"]").attr("selected",true);
        		$("option[value="+month+"]").attr("selected",true);
        	}
        
            //写入下拉框中的年份和月份
            function initialYearAndMonth() {
                //写入最近3年
                var yearObj = document.getElementById("selYears");
                var year = (new Date()).getFullYear();
                for (var i = 0; i <= 2; i++) {
                    var opObj = new Option(year - i, year - i);
                    yearObj.options[i] = opObj;
                }
                //写入 12 月
                var monthObj = document.getElementById("selMonths");
                var opObj = new Option("全部", "0");
                monthObj.options[0] = opObj;
                for (var i = 1; i <= 12; i++) {
                    var opObj = new Option(i, i);
                    monthObj.options[i] = opObj;
                }
            }
        </script>
    </head>
    <body >
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
            <form action="findBill.do" method="post">
                <!-- 搜索时去第一页 -->
            	<input type="hidden" name="currentPage" value="1" />
                <!--查询-->
                <div class="search_add">   
                	<div>姓名：<input type="text" class="width70 text_search" name="real_name" value="${billPage.real_name}" placeholder="输入姓名" /></div>
                    <div>身份证：<input type="text" class="text_search" name="idcard_no" value="${billPage.idcard_no}" placeholder="输入身份证号码" /></div>                            
                    <div>账务账号：<input type="text" class="width100 text_search" name="login_name" value="${billPage.login_name}" placeholder="输入账户账号" /></div>
                    <div>
                        <select class="select_search" name="year" id="selYears"></select>&nbsp;年
                        <select class="select_search" name="month" id="selMonths"></select>&nbsp;月
                    </div>
                    <div><input type="submit" value="搜索" class="btn_search" /></div>
                </div>  
                <!--数据区域：用表格展示数据-->
                <div id="data">            
                    <table id="datalist">
                    <tr>
                        <th class="width70">序号</th>
                        <th class="width70">账单ID</th>
                        <th>姓名</th>
                        <th class="width150">身份证</th>
                        <th class="width150">账务账号</th>
                        <th class="width80">月份</th>
                        <th>费用</th>
                        <th class="width100">支付方式</th>
                        <th class="width100">支付状态</th>                                                        
                        <th class="width50"></th>
                    </tr>
	                <c:forEach items="${bills}" var="bill">
	                    <tr>
	                        <td>${bill.num}</td>
	                        <td>${bill.id}</td>
	                        <td>${bill.real_name}</td>
	                        <td>${bill.idcard_no}</td>
	                        <td>${bill.login_name}</td>
	                        <td>
	                        	<fmt:parseDate value='${bill.bill_month}' pattern='yyyy-MM' var="date"></fmt:parseDate>
	                        	<fmt:formatDate value="${date}" pattern="yyyy-MM"/>
	                        </td>
	                        <td><fmt:formatNumber value="${bill.cost}" type="currency" pattern="¥0.00元" /></td>
	                        <td>
	                        	<c:choose>
	                        		<c:when test="${bill.payment_mode==0}">现金</c:when>
	                        		<c:when test="${bill.payment_mode==1}">网银</c:when>
	                        		<c:when test="${bill.payment_mode==2}">支付宝</c:when>
	                        		<c:when test="${bill.payment_mode==3}">微信</c:when>
	                        		<c:otherwise></c:otherwise>
	                        	</c:choose>
	                        </td>
	                        <td>
	                        	<c:if test="${bill.pay_state==0}" var="status">已支付</c:if>
	                        	<c:if test="${!status}">未支付</c:if>
	                        </td>                            
	                        <td><a href="findBillItem.do?billId=${bill.id}" title="账单明细">明细</a></td>
	                    </tr>
	                </c:forEach>     
                </table>
                
                <p>业务说明：<br />
                1、设计支付方式和支付状态，为用户自服务中的支付功能预留；<br />
                2、只查询近 3 年的账单，即当前年和前两年，如2017/2016/2015；<br />
                3、年和月的数据由 js 代码自动生成；<br />
                4、由数据库中的job每月的月底定时计算账单数据。</p>
                </div>                    
                <!--分页-->
                <div id="pages">
                    <a href="findBill.do?currentPage=1">首页</a>
                	<c:choose>
                		<c:when test="${billPage.currentPage==1 }">
                			<a href="#">上一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findBill.do?currentPage=${billPage.currentPage-1 }">上一页</a>
                		</c:otherwise>
                	</c:choose>
        	        
        	        <c:forEach begin="1" end="${billPage.totalPage }" var="p">
        	        	<c:choose>
        	        		<c:when test="${p==billPage.currentPage }">
        	        			<a href="findBill.do?currentPage=${p }" class="current_page">${p }</a>
        	        		</c:when>
        	        		<c:otherwise>
        	        			<a href="findBill.do?currentPage=${p }">${p }</a>
        	        		</c:otherwise>
        	        	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                		<c:when test="${billPage.currentPage==billPage.totalPage }">
                			<a href="#">下一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findBill.do?currentPage=${billPage.currentPage+1 }">下一页</a>
                		</c:otherwise>
                	</c:choose>
                    <a href="findBill.do?currentPage=${billPage.totalPage }">末页</a>
                </div>                         
            </form>
        </div>
        <!--主要区域结束-->
        <jsp:include page="../main/copyright.jsp"/> 
    </body>
</html>
