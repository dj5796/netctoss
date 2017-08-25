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
            //开通
            function start_account(id) {
            	sweetAlert({
			        title: "确定要开通此账号吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
			    		"startAccount.do?account_id="+id,
				      	function(data) {
				      		if(data) {
				      			swal({
				       				title:'成功开通此账号！',
				       				html:true,
				       				text:'<span class="swal_success">如需开启其下属的所有业务账号，需要在业务账号管理中单独开启！</span>',
				       				type:'success'
				          		});
				      			setTimeout(function(){
				       				location.href = "findAccount.do";
				       			}, 3000);
				      		} else {
				   				swal({
				       				title:'Oh, My God !',
				       				html:true,
				       				text:'<span class="swal_error">开通失败,请稍后重试!</span>',
				       				type:'error',
				       				timer:2000
				          		});
				      		}
				      	}
				     );
			    });
            }
            
            //暂停
            function pause_account(id) {
            	sweetAlert({
			        title: "确定要暂停账号吗？",  
			        type: "warning",
			        html:true,
			        text:'<span class="swal_warning">暂停此账号，将暂停其下属的业务账号！</span>',
			        showCancelButton: true,
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
			    		"pauseAccount.do?account_id="+id,
				      	function(data) {
				      		if(data) {
				      			swal({
				       				title:'Good Job！',
				       				html:true,
				       				text:'<span class="swal_success">暂停成功，且已暂停其下属的业务账号！</span>',
				       				type:'success'
				          		});
				      			setTimeout(function(){
				       				location.href = "findAccount.do";
				       			}, 2000);
				      		} else {
				   				swal({
				       				title:'Oh, My God !',
				       				html:true,
				       				text:'<span class="swal_error">暂停失败,请稍后重试!</span>',
				       				type:'error',
				       				timer:2000
				          		});
				      		}
				      	}
				     );
			    });
            }
            
            //删除
            function delete_account(id) {
            	sweetAlert({
			        title: "确定要删除账号吗？",  
			        type: "warning", 
			        html:true,
			        text:'<span class="swal_warning">删除此账号，将删除其下属的业务账号！</span>',
			        showCancelButton: true,
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
			    		"deleteAccount.do?account_id="+id,
				      	function(data) {
				      		if(data) {
				      			swal({
				       				title:'Good Job！',
				       				html:true,
				       				text:'<span class="swal_success">删除成功，且已删除其下属的业务账号！</span>',
				       				type:'success'
				          		});
				      			setTimeout(function(){
				       				location.href = "findAccount.do";
				       			}, 2000);
				      		} else {
				   				swal({
				       				title:'Oh, My God !',
				       				html:true,
				       				text:'<span class="swal_error">删除失败,请稍后重试!</span>',
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
            <form action="findAccount.do" method="post">
            	<!-- 搜索时去第一页 -->
            	<input type="hidden" name="currentPage" value="1" />
                <!--查询-->
                <div class="search_add">
                    <div>姓名：<input type="text" class="width70 text_search" name="real_name" value="${accountPage.real_name }" placeholder="输入姓名" /></div>
                    <div>身份证：<input type="text" class="text_search" name="idcard_no" value="${accountPage.idcard_no }" placeholder="输入身份证号码" /></div>                            
                    <div>登录账号：<input type="text" class="text_search" name="login_name" value="${accountPage.login_name }" placeholder="输入登录账号" /></div>
                    <div>
                                                                       状态：
                        <select class="select_search" name="status">
                            <option value="-1">全部</option>
                            <option value="0" <c:if test="${accountPage.status==0 }">selected</c:if>>开通</option>
                            <option value="1" <c:if test="${accountPage.status==1 }">selected</c:if>>暂停</option>
                            <option value="2" <c:if test="${accountPage.status==2 }">selected</c:if>>删除</option>
                        </select>
                    </div>
                    <div><input type="submit" value="搜索" class="btn_search" /></div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAddAccount.do';" />
                </div>  
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                    <tr>
                        <th class="width70">序号</th>
                        <th class="width70">账号ID</th>
                        <th>姓名</th>
                        <th class="width150">身份证</th>
                        <th>登录账号</th>
                        <th class="width50">状态</th>
                        <th class="width100">创建日期</th>
                        <th class="width150">上次登录时间</th>                                                        
                        <th class="width200">操作</th>
                    </tr>
                    <c:forEach items="${accounts }" var="acc">
	                    <tr>
	                        <td>${acc.num}</td>
	                        <td>${acc.account_id }</td>
	                        <td><a href="accountDetail.do?accountId=${acc.account_id}">${acc.real_name }</a></td>
	                        <td>${acc.idcard_no }</td>
	                        <td>${acc.login_name }</td>
	                        <td>
	                        	<c:choose>
	                        		<c:when test="${acc.status==0 }">开通</c:when>
	                        		<c:when test="${acc.status==1 }">暂停</c:when>
	                        		<c:otherwise>删除</c:otherwise>
	                        	</c:choose>
	                        </td>
	                        <td><fmt:formatDate value="${acc.create_date }" pattern="yyyy-MM-dd"/></td>
	                        <td><fmt:formatDate value="${acc.last_login_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>                            
	                        <td class="td_modi">
	                        	<c:choose>
	                        		<c:when test="${acc.status==0 }">
	                        			<input type="button" value="暂停" class="btn_pause" onclick="pause_account(${acc.account_id });" />
			                            <input type="button" value="修改" class="btn_modify" onclick="location.href='toUpdateAccount.do?account_id=${acc.account_id }';" />
			                            <input type="button" value="删除" class="btn_delete" onclick="delete_account(${acc.account_id });" />
	                        		</c:when>
	                        		<c:when test="${acc.status==1 }">
	                        			<input type="button" value="开通" class="btn_start" onclick="start_account(${acc.account_id });" />
			                            <input type="button" value="修改" class="btn_modify" onclick="location.href='toUpdateAccount.do?account_id=${acc.account_id }';" />
			                            <input type="button" value="删除" class="btn_delete" onclick="delete_account(${acc.account_id });" />
	                        		</c:when>
	                        	</c:choose>
	                        </td>
	                    </tr>
                    </c:forEach>                   
                </table>
                <p>业务说明：<br />
                1、创建则开通，记载创建时间；<br />
                2、暂停后，记载暂停时间；<br />
                3、暂停账务账号，同时暂停下属的所有业务账号；<br />                
                4、重新开通后，删除暂停时间；<br />
                5、暂停后重新开通账务账号，并不同时开启下属的所有业务账号，需要在业务账号管理中单独开启；<br />
                6、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；<br />
                7、删除账务账号，同时删除下属的所有业务账号。</p>
                </div>                   
                <!--分页-->
                <div id="pages">
                    <a href="findAccount.do?currentPage=1">首页</a>
                	<c:choose>
                		<c:when test="${accountPage.currentPage==1 }">
                			<a href="#">上一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findAccount.do?currentPage=${accountPage.currentPage-1 }">上一页</a>
                		</c:otherwise>
                	</c:choose>
        	        
        	        <c:forEach begin="1" end="${accountPage.totalPage }" var="p">
        	        	<c:choose>
        	        		<c:when test="${p==accountPage.currentPage }">
        	        			<a href="findAccount.do?currentPage=${p }" class="current_page">${p }</a>
        	        		</c:when>
        	        		<c:otherwise>
        	        			<a href="findAccount.do?currentPage=${p }">${p }</a>
        	        		</c:otherwise>
        	        	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                		<c:when test="${accountPage.currentPage==accountPage.totalPage }">
                			<a href="#">下一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findAccount.do?currentPage=${accountPage.currentPage+1 }">下一页</a>
                		</c:otherwise>
                	</c:choose>
                    <a href="findAccount.do?currentPage=${accountPage.totalPage }">末页</a>
                </div>                    
            </form>
        </div>
        <!--主要区域结束:版权区域-->
        <jsp:include page="../main/copyright.jsp"/> 
    </body>
</html>