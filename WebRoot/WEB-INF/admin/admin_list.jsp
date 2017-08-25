<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <!--SweetAlert提示框插件-->
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/sweetalert.min.js"></script> 
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/styles/sweetalert.css" /> 
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
		<script type="text/javascript" src="../js/jquery-1.11.1.js"></script>
        <script type="text/javascript">
            //显示角色详细信息
            function showDetail(flag, a) {
                var detailDiv = a.parentNode.getElementsByTagName("div")[0];
                if (flag) {
                    detailDiv.style.display = "block";
                } else {
                    detailDiv.style.display = "none";
                }
            }
            
            //重置密码
            function resetPwd() {
            	var checkObjs = $(":checkbox[name='check_admin']:checked");
            	if(checkObjs.length == 0) {
            		swal({
		        		title: "至少选择一个管理员!",  
				        type: "warning",
				        timer:2000
		        	});
            		return;
            	}
            	
            	sweetAlert({
			        title: "您确定要重置密码吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        animation: "slide-from-top",
			        closeOnConfirm: false
			    }, function() {
	            	var ids = new Array();
	            	for(var i=0;i<checkObjs.length;i++){
	            		var trObj = checkObjs.eq(i).parent().parent();
	            		var tdObj = trObj.children().eq(2);
	            		ids.push(tdObj.text());
	            	}
	            	
	            	$.post(
	            		"resetPassword.do",
	            		{"ids":ids.toString()},
	            		function(data) {
	            			swal({  
					        	title:data.message,  
					        	type:"success",  
					        	timer:2000
				        	});  
	            		}
	            	);
			    });
            }
            
            //删除
            function deleteAdmin(id) {
	        	swal({  
		        	title:"确定要删除此管理员吗？",  
		        	type:"warning",  
		        	animation: "slide-from-top",
		        	showCancelButton:"true",
		        	closeOnConfirm: false
	        	}, function() { 
	        		$.post(
	        			"deleteAdmin.do?admin_id="+id,
	            		function(data) {
	        				if(data) {
				      			swal("删除此管理员成功!","","success");
				      			setTimeout(function(){
				      				location.href=data;
				       			}, 2000);
				      		}
	            		}
	            	);
	        	});  
            }

            //全选
            function selectAdmins(inputObj) {
                var inputArray = document.getElementById("datalist").getElementsByTagName("input");
                for (var i = 1; i < inputArray.length; i++) {
                    if (inputArray[i].type == "checkbox") {
                        inputArray[i].checked = inputObj.checked;
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
        <div id="main">
            <form action="findAdmin.do" method="post">
            	<input type="hidden" name="currentPage" value="1" />
            	
                <!--查询-->
                <div class="search_add">
                    <div>
                        	模块：
                        <select name="moduleId" id="selModules" class="select_search">
                            <option value="">全部</option>
                            <c:forEach items="${modules }" var="module">
                            	<option value="${module.module_id }" 
                            		<c:if test="${module.module_id==adminPage.moduleId }">selected</c:if>>${module.name }
                            	</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>角色：<input type="text" name="roleName" value="${adminPage.roleName }" class="text_search width200" placeholder="请输入角色名称" /></div>
                    <div><input type="submit" value="搜索" class="btn_search" /></div>
                    <input type="button" value="密码重置" class="btn_add" onclick="resetPwd();" />
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAddAdmin.do';" />
                </div>
                <!--数据区域：用表格展示数据-->
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th class="th_select_all">
                                <input type="checkbox" onclick="selectAdmins(this);" />
                                <span>全选</span>
                            </th>
                            <th class="width70">序号</th>
                            <th class="width70">管理员ID</th>
                            <th>姓名</th>
                            <th>登录名</th>
                            <th>电话</th>
                            <th>电子邮件</th>
                            <th>授权日期</th>
                            <th class="width100">拥有角色</th>
                            <th>操作</th>
                        </tr>                      
                        <c:forEach items="${admins }" var="admin" varStatus="st">
	                        <tr>
	                        	<!-- 只有超级管理员才可以修改自己的信息,一般管理员无法修改超级管理员信息 -->
	                            <td>
	                            	<c:if test="${st.first && sessionScope.admin.admin_code.equals('SuperAdmin')}">
	                            		<input type="checkbox" name="check_admin"/>
	                            	</c:if>
	                            	<c:if test="${!st.first}"><input type="checkbox" name="check_admin"/></c:if>
	                            </td>
	                            <td>${admin.num }</td>
	                            <td>${admin.admin_id }</td>
	                            <td>${admin.name }</td>
	                            <td>${admin.admin_code }</td>
	                            <td>${admin.telephone }</td>
	                            <td>${admin.email }</td>
	                            <td><fmt:formatDate value="${admin.enrolldate }" pattern="yyyy-MM-dd"/></td>
	                            <td>
	                                <a class="summary" onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">
	                                	<c:forEach items="${admin.roles }" var="role" varStatus="status">
	                                    	<c:choose>
	                                    		<c:when test="${status.first}">${role.name}</c:when>
	                                    		<c:when test="${status.index==1}">...</c:when>
	                                    	</c:choose>
	                                    </c:forEach>
	                                </a>
	                                <!--浮动的详细信息-->
	                                <div class="detail_info">
	                                    <c:forEach items="${admin.roles }" var="role" varStatus="status">
	                                    	<c:choose>
	                                    		<c:when test="${status.last }">${role.name }</c:when>
	                                    		<c:otherwise>${role.name }、</c:otherwise>
	                                    	</c:choose>
	                                    </c:forEach>
	                                </div>
	                            </td>
	                            <td class="td_modi">
	                            	<c:if test="${st.first && sessionScope.admin.admin_code.equals('SuperAdmin')}">
		                                <input type="button" value="修改" class="btn_modify" onclick="location.href='toUpdateAdmin.do?id=${admin.admin_id }';" />
		                                <input type="button" value="删除" class="btn_delete" onclick="deleteAdmin(${admin.admin_id });" />
	                            	</c:if>
	                            	<c:if test="${!st.first}">
		                                <input type="button" value="修改" class="btn_modify" onclick="location.href='toUpdateAdmin.do?id=${admin.admin_id }';" />
		                                <input type="button" value="删除" class="btn_delete" onclick="deleteAdmin(${admin.admin_id });" />
	                            	</c:if>
	                            </td>
	                        </tr>
                       </c:forEach>
                    </table>
                </div>
                <!--分页-->
                <div id="pages">
                	<c:choose>
                		<c:when test="${adminPage.currentPage==1 }">
                			<a href="#">上一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findAdmin.do?currentPage=${adminPage.currentPage-1 }">上一页</a>
                		</c:otherwise>
                	</c:choose>
        	        
        	        <c:forEach begin="1" end="${adminPage.totalPage }" var="p">
        	        	<c:choose>
        	        		<c:when test="${p==adminPage.currentPage }">
        	        			<a href="findAdmin.do?currentPage=${p }" class="current_page">${p }</a>
        	        		</c:when>
        	        		<c:otherwise>
        	        			<a href="findAdmin.do?currentPage=${p }">${p }</a>
        	        		</c:otherwise>
        	        	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                		<c:when test="${adminPage.currentPage==adminPage.totalPage }">
                			<a href="#">下一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findAdmin.do?currentPage=${adminPage.currentPage+1 }">下一页</a>
                		</c:otherwise>
                	</c:choose>
                </div>                    
            </form>
        </div>
        <!--主要区域结束:版权区域-->
        <jsp:include page="../main/copyright.jsp"/> 
    </body>
</html>