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
        		var type=${type};
        		for(var i=0;i<=2;i++){
	        		if(type==i){
	                    $("#li"+i).children('a').eq(0).removeClass("tab_out").addClass("tab_on");
	        			$("#datalist"+i).show();
	                    $("#page"+i).show();
	        		} else {
	                    $("#li"+i).children('a').eq(0).removeClass("tab_on").addClass("tab_out");
	        			$("#datalist"+i).hide();
	        			$("#page"+i).hide();
	        		}
        		}
        	});	
        
            function changeTab(e,ulObj) {                
                var obj = e.srcElement || e.target;
                if (obj.nodeName == "A") {
                    var links = ulObj.getElementsByTagName("a");
                    for (var i = 0; i < links.length; i++) {
                        if (links[i].innerHTML == obj.innerHTML) {
                            links[i].className = "tab_on";
                            $("#datalist"+i).show();
                            $("#page"+i).show();
                        } else {
                            links[i].className = "tab_out";
                            $("#datalist"+i).hide();
                            $("#page"+i).hide();
                        }
                    }
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
        <div id="report_main">
        	<div class="tabs">
    	        <ul onclick="changeTab(event,this);">
        	        <li id="li0"><a href="#" id="cust" class="tab_on" title="每位客户每月的累计时长">客户使用时长</a></li>
                    <li id="li1"><a href="#" id="duration" class="tab_out" title="每台服务器上累计时长最高的前三名客户">时长排行榜</a></li>
                    <li id="li2"><a href="#" id="time" class="tab_out" title="每台服务器每种资费标准的使用次数">资费使用率</a></li>
                </ul>
            </div>            
            <div class="report_box">
                <!--数据区域：用表格展示数据-->
                <div id="report_data">
                	<div id="datalist0">
	                    <table id="datalist">
	                        <tr>                            
	                            <th class="width70">序号</th>
	                            <th class="width70">账号 ID</th>
	                            <th>账务帐号</th>
	                            <th>客户名称</th>
	                            <th class="width170">身份证号码</th>
	                            <th>电话</th>
	                            <th class="width90">月份</th>
	                            <th class="width150">累积时长</th>
	                        </tr>     
	                        <c:forEach items="${custs }" var="cust">
		                        <tr>
		                            <td>${cust.NUM }</td>
		                            <td>${cust.account_id }</td>
		                            <td>${cust.login_name }</td>
		                            <td>${cust.real_name }</td>
		                            <td>${cust.idcard_no }</td>
		                            <td>${cust.telephone }</td>
		                            <td>
		                            	<fmt:parseDate value='${cust.bill_month}' pattern='yyyy-MM' var="date"/>
		                        		<fmt:formatDate value="${date}"  pattern="yyyy-MM"/>
		                            </td>
		                            <td>${cust.sofar_duration_str }</td>
		                        </tr>
	                        </c:forEach>            
	                    </table>
	                    <p>业务说明：<br />
		                1、显示每位客户每月的累计时间,数据以时间和客户id升序排序。
		                </p>
                	</div>
                    
                    <div id="datalist1" class="hide">
	                    <table id="datalist">
	                        <tr>                            
	                            <th class="width70">序号</th>
	                            <th class="width180">Unix 服务器IP</th>
	                            <th>账务帐号</th>
	                            <th>客户名称</th>
	                            <th class="width180">身份证号码</th>
	                            <th class="width150">累积时长</th>
	                            <th class="width110">在其服务器排行</th>
	                        </tr>
	                        <c:forEach items="${durationRanks }" var="durationRank">
		                        <tr>
		                            <td>${durationRank.num }</td>
		                            <td>${durationRank.unix_host }</td>
		                            <td>${durationRank.login_name }</td>
		                            <td>${durationRank.real_name }</td>
		                            <td>${durationRank.idcard_no }</td>
		                            <td>${durationRank.sofar_duration_str }</td>
		                            <td>${durationRank.rank }</td>
		                        </tr>
	                        </c:forEach>                      
	                    </table>
	                    <p>业务说明：<br />
		                1、显示每台服务器上累计时长最高的前三名客户。
		                </p>
                    </div>
	                
	                <div id="datalist2" class="hide">
	                    <table id="datalist">
	                        <tr>                            
	                            <th class="width80">序号</th>
	                            <th class="width250">Unix 服务器IP</th>
	                            <th>包月</th>
	                            <th>套餐</th>
	                            <th>计时</th>
	                        </tr> 
	                        <c:forEach items="${hosts }" var="host">
		                        <tr>
		                            <td>${host.num }</td>
		                            <td>${host.unix_host }</td>
		                            <td>${host.monthly }</td>
		                            <td>${host.meal }</td>
		                            <td>${host.hourly }</td>
		                        </tr>
	                        </c:forEach>                     
	                    </table>
	                    <p>业务说明：<br />
		                1、显示每台服务器上每种资费标准的使用次数。
		                </p>
	                </div>
                </div>
                
                <!--分页-->
                <div id="page0">
	                <div id="pages">
	                    <a href="findReport.do?type=0&page0=1">首页</a>
	                	<c:choose>
	                		<c:when test="${custPage.currentPage==1 }">
	                			<a href="#">上一页</a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="findReport.do?type=0&page0=${custPage.currentPage-1 }">上一页</a>
	                		</c:otherwise>
	                	</c:choose>
	        	        
	        	        <c:forEach begin="1" end="${custPage.totalPage }" var="p">
	        	        	<c:choose>
	        	        		<c:when test="${p==custPage.currentPage }">
	        	        			<a href="findReport.do?type=0&page0=${p }" class="current_page">${p }</a>
	        	        		</c:when>
	        	        		<c:otherwise>
	        	        			<a href="findReport.do?type=0&page0=${p }">${p }</a>
	        	        		</c:otherwise>
	        	        	</c:choose>
	                    </c:forEach>
	                    
	                    <c:choose>
	                		<c:when test="${custPage.currentPage==custPage.totalPage }">
	                			<a href="#">下一页</a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="findReport.do?type=0&page0=${custPage.currentPage+1 }">下一页</a>
	                		</c:otherwise>
	                	</c:choose>
	                    <a href="findReport.do?type=0&page0=${custPage.totalPage }">末页</a>
	                </div>
                </div>      
                     
                <div id="page1">
	                <div id="pages">
	                    <a href="findReport.do?type=1&page1=1">首页</a>
	                	<c:choose>
	                		<c:when test="${durationPage.currentPage==1 }">
	                			<a href="#">上一页</a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="findReport.do?type=1&page1=${durationPage.currentPage-1 }">上一页</a>
	                		</c:otherwise>
	                	</c:choose>
	        	        
	        	        <c:forEach begin="1" end="${durationPage.totalPage }" var="p">
	        	        	<c:choose>
	        	        		<c:when test="${p==durationPage.currentPage }">
	        	        			<a href="findReport.do?type=1&page1=${p }" class="current_page">${p }</a>
	        	        		</c:when>
	        	        		<c:otherwise>
	        	        			<a href="findReport.do?type=1&page1=${p }">${p }</a>
	        	        		</c:otherwise>
	        	        	</c:choose>
	                    </c:forEach>
	                    
	                    <c:choose>
	                		<c:when test="${durationPage.currentPage==durationPage.totalPage }">
	                			<a href="#">下一页</a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="findReport.do?type=1&page1=${durationPage.currentPage+1 }">下一页</a>
	                		</c:otherwise>
	                	</c:choose>
	                    <a href="findReport.do?type=1&page1=${durationPage.totalPage }">末页</a>
	                </div>
                </div>         
                  
                <div id="page2" class="hide">
	                <div id="pages">
	                    <a href="findReport.do?type=2&page2=1">首页</a>
	                	<c:choose>
	                		<c:when test="${hostPage.currentPage==1 }">
	                			<a href="#">上一页</a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="findReport.do?type=2&page2=${hostPage.currentPage-1 }">上一页</a>
	                		</c:otherwise>
	                	</c:choose>
	        	        
	        	        <c:forEach begin="1" end="${hostPage.totalPage }" var="p">
	        	        	<c:choose>
	        	        		<c:when test="${p==hostPage.currentPage }">
	        	        			<a href="findReport.do?type=2&page2=${p }" class="current_page">${p }</a>
	        	        		</c:when>
	        	        		<c:otherwise>
	        	        			<a href="findReport.do?type=2&page2=${p }">${p }</a>
	        	        		</c:otherwise>
	        	        	</c:choose>
	                    </c:forEach>
	                    
	                    <c:choose>
	                		<c:when test="${hostPage.currentPage==hostPage.totalPage }">
	                			<a href="#">下一页</a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="findReport.do?type=2&page2=${hostPage.currentPage+1 }">下一页</a>
	                		</c:otherwise>
	                	</c:choose>
	                    <a href="findReport.do?type=2&page2=${hostPage.totalPage }">末页</a>
	                </div>
                </div>           
            </div>
        </div>
        <!--主要区域结束:版权区域-->
        <jsp:include page="../main/copyright.jsp"/> 
    </body>
</html>
