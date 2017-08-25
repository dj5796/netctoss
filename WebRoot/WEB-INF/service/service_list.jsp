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
            //显示角色详细信息
            function showDetail(flag, a) {
                var detailDiv = a.parentNode.getElementsByTagName("div")[0];
                if (flag){
                    detailDiv.style.display = "block";
                } else{
                	detailDiv.style.display = "none";
                }
            }
            
			//开通
            function start_service(id) {
				sweetAlert({
					title: "确定要开通此业务吗？",
					type: "warning", 
					showCancelButton: true,
					closeOnConfirm: false
				 }, function() {
				   	$.post(
						"startService.do",
				      	{"service_id":id},
				      	function(data) {
				      		if(data.success) {
				      			swal(data.message,"","success");
				      			setTimeout(function(){
				       				location.href = "findService.do";
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
			
            //暂停
            function pause_service(id) {
				sweetAlert({
					title: "确定要暂停此业务吗？",
					type: "warning", 
					showCancelButton: true,
					closeOnConfirm: false
				 }, function() {
				   	$.post(
			   			"pauseService.do",
	            		{"service_id":id},
				      	function(data) {
				      		if(data.success) {
				      			swal(data.message,"","success");
				      			setTimeout(function(){
				       				location.href = "findService.do";
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
            
            //删除
            function delete_service(id) {
				sweetAlert({
					title: "确定要删除此业务吗？",
					html:true,
       				text:'<span class="swal_warning">删除之后将不能再开通、修改、删除</span>',
					type: "warning", 
					showCancelButton: true,
					closeOnConfirm: false
				 }, function() {
				   	$.post(
			   			"deleteService.do",
	            		{"service_id":id},
				      	function(data) {
				      		if(data.success) {
				      			swal(data.message,"","success");
				      			setTimeout(function(){
				       				location.href = "findService.do";
				       			}, 1000);
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
            <form action="findService.do" method="post">
            	<input type="hidden" name="currentPage" value="1"/>
                <!--查询-->
                <div class="search_add">                        
                    <div>身份证：<input type="text" name="idcard_no" value="${servicePage.idcard_no }" class="text_search" placeholder="输入身份证号码" /></div>
                    <div>OS 账号：<input type="text" name="os_username" value="${servicePage.os_username }" class="width100 text_search" placeholder="输入OS账号"/></div>                            
                    <div>服务器 IP：<input type="text" name="unix_host" value="${servicePage.unix_host }" class="width100 text_search" placeholder="输入服务器 IP"/></div>
                    <div>状态：
                        <select class="select_search" name="status">
                            <option value="-1">全部</option>
                            <option value="0" <c:if test="${servicePage.status==0 }">selected</c:if>>开通</option>
                            <option value="1" <c:if test="${servicePage.status==1 }">selected</c:if>>暂停</option>
                            <option value="2" <c:if test="${servicePage.status==2 }">selected</c:if>>删除</option>
                        </select>
                    </div>
                    <div><input type="submit" value="搜索" class="btn_search" /></div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAddService.do';" />
                </div>  
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                    <tr>
                        <th class="width70">序号</th>
                        <th class="width70">业务ID</th>
                        <th class="width70">账务账号ID</th>
                        <th class="width150">身份证</th>
                        <th>姓名</th>
                        <th>OS 账号</th>
                        <th class="width50">状态</th>
                        <th class="width100">服务器 IP</th>
                        <th>资费</th>                                                        
                        <th class="width200">操作</th>
                    </tr>
                    <c:forEach items="${services}" var="service">
	                    <tr>
	                        <td>${service.NUM}</td>
	                        <td><a href="serviceDetail.do?serviceId=${service.SERVICE_ID}" title="查看明细">${service.SERVICE_ID }</a></td>
	                        <td>${service.ACCOUNT_ID }</td>
	                        <td>${service.IDCARD_NO }</td>
	                        <td>${service.REAL_NAME }</td>
	                        <td>${service.OS_USERNAME }</td>
	                        <td>
	                        	<c:choose>
	                        		<c:when test="${service.STATUS==0 }">开通</c:when>
	                        		<c:when test="${service.STATUS==1 }">暂停</c:when>
	                        		<c:otherwise>删除</c:otherwise>
	                        	</c:choose>
	                        </td>
	                        <td>${service.UNIX_HOST }</td>
	                        <td>
	                            <a class="summary"  onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">${service.COST_NAME }</a>
	                            <!--浮动的详细信息-->
	                            <div class="detail_info">${service.DESCR}</div>
	                        </td>                            
	                        <td class="td_modi">
	                        	<c:choose>
	                        		<c:when test="${service.STATUS==0 }">
	                        			<input type="button" value="暂停" class="btn_pause" onclick="pause_service(${service.SERVICE_ID });" />
			                            <input type="button" value="修改" class="btn_modify" onclick="location.href='toUpdateService.do?id=${service.SERVICE_ID}';" />
			                            <input type="button" value="删除" class="btn_delete" onclick="delete_service(${service.SERVICE_ID });" />
	                        		</c:when>
	                        		<c:when test="${service.STATUS==1 }">
	                        			<input type="button" value="开通" class="btn_start" onclick="start_service(${service.SERVICE_ID });" />
			                            <input type="button" value="修改" class="btn_modify" onclick="location.href='toUpdateService.do?id=${service.SERVICE_ID}';" />
			                            <input type="button" value="删除" class="btn_delete" onclick="delete_service(${service.SERVICE_ID });" />
	                        		</c:when>
	                        		<c:otherwise>
	                        			
	                        		</c:otherwise>
	                        	</c:choose>
	                        </td>
	                    </tr>
                    </c:forEach>                                                              
                </table>                
                <p>
                	业务说明：<br />
                	1、创建即开通，记载创建时间；<br />
                	2、暂停和删除状态的账务账号下属的业务账号不能被开通。<br />
                	3、暂停后，记载暂停时间；<br />
                	4、重新开通后，删除暂停时间；<br />
                	5、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；<br />
                	6、业务账号不设计修改密码功能，由用户自服务功能实现；<br />
                </p>
                </div>                    
                <!--分页-->
                <div id="pages">
                    <a href="findService.do?currentPage=1">首页</a>
                	<c:choose>
                		<c:when test="${servicePage.currentPage==1 }">
                			<a href="#">上一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findService.do?currentPage=${servicePage.currentPage-1 }">上一页</a>
                		</c:otherwise>
                	</c:choose>
        	        
        	        <c:forEach begin="1" end="${servicePage.totalPage }" var="p">
        	        	<c:choose>
        	        		<c:when test="${p==servicePage.currentPage }">
        	        			<a href="findService.do?currentPage=${p }" class="current_page">${p }</a>
        	        		</c:when>
        	        		<c:otherwise>
        	        			<a href="findService.do?currentPage=${p }">${p }</a>
        	        		</c:otherwise>
        	        	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                		<c:when test="${servicePage.currentPage==servicePage.totalPage }">
                			<a href="#">下一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findService.do?currentPage=${servicePage.currentPage+1 }">下一页</a>
                		</c:otherwise>
                	</c:choose>
                    <a href="findService.do?currentPage=${servicePage.totalPage }">末页</a>
                </div>                    
            </form>
        </div>
        <!--主要区域结束:版权区域-->
    	<jsp:include page="../main/copyright.jsp"/>
    </body>
</html>