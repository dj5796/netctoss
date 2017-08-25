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
        <!--SweetAlert提示框插件-->
		<script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/sweetalert.min.js"></script> 
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/styles/sweetalert.css" /> 
        <script language="javascript" type="text/javascript">
        	//自动加载:修改基费和时长箭头向上/还是向下样式
        	$(function(){
        		var baseDurationSort = $("#baseDurationSort").val();
        		var baseCostSort = $("#baseCostSort").val();
        		if(baseDurationSort != "") {
	        		$("#baseDuration").attr("class","sort_"+baseDurationSort);
        		}
        		if(baseCostSort != "") {
	        		$("#baseCost").attr("class","sort_"+baseCostSort);
        		}
        	});
        
            //排序按钮的点击事件
            function sort(btnObj) {
                if (btnObj.className == "sort_desc") {
	            	//如果点击前是降序排序,就要进行升序排序,只按照基费或者时长的一种进行排序
	            	if(btnObj.id=="baseDuration"){
	                	//$("#"+btnObj.id+"Sort").val("asc");
	                	$("#baseDurationSort").val("asc");
	                	$("#baseCostSort").val("");
	            	} else{
	                	$("#baseDurationSort").val("");
	                	$("#baseCostSort").val("asc");
	            	}
                } else {
	            	if(btnObj.id=="baseDuration"){
	                	$("#baseDurationSort").val("desc");
	                	$("#baseCostSort").val("");
	            	} else{
	                	$("#baseDurationSort").val("");
	                	$("#baseCostSort").val("desc");
	            	}
                }
                $("#costForm").submit();
            }

            //启用
            function startFee(id) {
            	sweetAlert({
			        title: "你确定要开通吗?",  
			        html:true,
			        text:'<span class="swal_warning">资费开通后将不能修改和删除 ! ! !</span>',
			        type: "warning", 
			        showCancelButton: true,
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
			    		"startCost.do?id="+id,
				      	function(data) {
				      		if(data) {
				      			swal("资费开通成功!","","success");
				      			setTimeout(function(){
				      				location.reload();
				       			}, 2000);
				      		}
				      	}
				     );
			    });
            }
            
            //删除
            function deleteFee(id) {
            	sweetAlert({
			        title: "确定要删除此资费吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
			    		"deleteCost.do?id="+id,
				      	function(data) {
				      		if(data) {
				      			swal("删除资费成功!","","success");
				      			setTimeout(function(){
				      				location.href=data;
				       			}, 2000);
				      		} else {
				   				swal({
				       				title:'Oh, My God !',
				       				html:true,
				       				text:'<span class="swal_error">删除资费失败,请稍后重试!</span>',
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
            <form action="findCost.do" method="post" id="costForm">
                <!--排序-->
                <div class="search_add">
                    <div>
                    	<input type="hidden" name="currentPage" value="1"/>
                    	<input type="hidden" name="baseDurationSort" id="baseDurationSort" value="${costPage.baseDurationSort}"/>
                    	<input type="hidden" name="baseCostSort" id="baseCostSort" value="${costPage.baseCostSort}"/>
                    
                        <!--<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />-->
                        <input type="button" value="时长" id="baseDuration" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="基费" id="baseCost" class="sort_asc" onclick="sort(this);" />
                    </div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAddCost.do';" />
                </div> 
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th class="width70">序号</th>
                            <th class="width70">资费ID</th>
                            <th>资费名称</th>
                            <th class="width70">基本时长</th>
                            <th class="width70">基本费用</th>
                            <th class="width70">单位费用</th>
                            <th class="width100">创建时间</th>
                            <th class="width100">开通时间</th>
                            <th class="width50">状态</th>
                            <th class="width200">操作</th>
                        </tr>                     
                        <c:forEach items="${costs}" var="cost" varStatus="sequence">
	                        <tr>
	                            <td>${cost.num}</td>
	                            <td>${cost.cost_id}</td>
	                            <td><a href="costDetail.do?id=${cost.cost_id}">${cost.name}</a></td>
	                            <td>${cost.base_duration}</td>
	                            <td>${cost.base_cost}</td>
	                            <td>${cost.unit_cost}</td>
	                            <td><fmt:formatDate value="${cost.creatime}" pattern="yyyy-MM-dd"/></td>
	                            <td><fmt:formatDate value="${cost.startime}" pattern="yyyy-MM-dd"/></td>
	                            <td>
	                            	<c:if test="${cost.status==0}">开通</c:if>
	                            	<c:if test="${cost.status==1}">暂停</c:if>
	                            </td>
	                            <td class="td_modi">
	                            	<c:if test="${cost.status==1}">
		                                <input type="button" value="开通" class="btn_start" onclick="startFee(${cost.cost_id});" />
		                                <input type="button" value="修改" class="btn_modify" onclick="location.href='toUpdateCost.do?id=${cost.cost_id}';" />
		                                <input type="button" value="删除" class="btn_delete" onclick="deleteFee(${cost.cost_id});" />
	                            	</c:if>                                
	                            </td>
	                        </tr>
                        </c:forEach>
                    </table>
                    <p>业务说明：<br />
                    1、创建资费时，状态为暂停，记载创建时间；<br />
                    2、暂停状态下，可修改，可删除；<br />
                    3、开通后，记载开通时间，且开通后不能修改、不能再停用、也不能删除；<br />
                    4、业务账号修改资费时，在下月底统一触发，修改其关联的资费ID（此触发动作由程序处理）
                    </p>
                </div>
                <!--分页-->
                <div id="pages">
                	<c:choose>
                		<c:when test="${costPage.currentPage==1 }">
                			<a href="#">上一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findCost.do?currentPage=${costPage.currentPage-1 }">上一页</a>
                		</c:otherwise>
                	</c:choose>
        	        
        	        <c:forEach begin="1" end="${costPage.totalPage }" var="p">
        	        	<c:choose>
        	        		<c:when test="${p==costPage.currentPage }">
        	        			<a href="findCost.do?currentPage=${p }" class="current_page">${p }</a>
        	        		</c:when>
        	        		<c:otherwise>
        	        			<a href="findCost.do?currentPage=${p }">${p }</a>
        	        		</c:otherwise>
        	        	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                		<c:when test="${costPage.currentPage==costPage.totalPage }">
                			<a href="#">下一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findCost.do?currentPage=${costPage.currentPage+1 }">下一页</a>
                		</c:otherwise>
                	</c:choose>
                </div>
            </form>
        </div>
        <!--主要区域结束:版权区域-->
        <jsp:include page="../main/copyright.jsp"/> 
    </body>
</html>