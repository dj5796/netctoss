<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	//更改网页的标题,由于每一个网页都引用这个页面,也就相当于修改整个系统所有页面的标题
	document.title='中国电信计费系统';
</script>
<ul id="menu">
	<c:choose>
		<c:when test="${currentModule==0 }">
			<li><a href="${pageContext.request.contextPath }/login/toIndex.do" class="index_on"></a></li>
		</c:when>
		<c:otherwise>
			<li><a href="${pageContext.request.contextPath }/login/toIndex.do" class="index_off"></a></li>
		</c:otherwise>
	</c:choose>
	
	<c:forEach items="${allModules }" var="module">
		<c:if test="${module.module_id==1 }">
			<c:choose>
				<c:when test="${currentModule==1 }">
					<li><a href="${pageContext.request.contextPath }/role/findRole.do?currentPage=1" class="role_on"></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath }/role/findRole.do?currentPage=1" class="role_off"></a></li>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${module.module_id==2 }">
			<c:choose>
				<c:when test="${currentModule==2 }">
					<li><a href="${pageContext.request.contextPath }/admin/findAdmin.do?currentPage=1" class="admin_on"></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath }/admin/findAdmin.do?currentPage=1" class="admin_off"></a></li>
				</c:otherwise>
			</c:choose>	
		</c:if>
		
		<c:if test="${module.module_id==3 }">
			<c:choose>
				<c:when test="${currentModule==3 }">
					<li><a href="${pageContext.request.contextPath }/cost/findCost.do?currentPage=1&baseDurationSort=&baseCostSort=" class="fee_on"></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath }/cost/findCost.do?currentPage=1&baseDurationSort=&baseCostSort=" class="fee_off"></a></li>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${module.module_id==4 }">
			<c:choose>
				<c:when test="${currentModule==4 }">
					<li><a href="${pageContext.request.contextPath }/account/findAccount.do?currentPage=1" class="account_on"></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath }/account/findAccount.do?currentPage=1" class="account_off"></a></li>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${module.module_id==5 }">
			<c:choose>
				<c:when test="${currentModule==5 }">
					<li><a href="${pageContext.request.contextPath }/service/findService.do?currentPage=1" class="service_on"></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath }/service/findService.do?currentPage=1" class="service_off"></a></li>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${module.module_id==6 }">
			<c:choose>
				<c:when test="${currentModule==6 }">
					<li><a href="${pageContext.request.contextPath }/bill/findBill.do?currentPage=1" class="bill_on"></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath }/bill/findBill.do?currentPage=1" class="bill_off"></a></li>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${module.module_id==7 }">
			<c:choose>
				<c:when test="${currentModule==7 }">
					<li><a href="${pageContext.request.contextPath }/report/findReport.do?currentPage=1" class="report_on"></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath }/report/findReport.do?currentPage=1" class="report_off"></a></li>
				</c:otherwise>
			</c:choose>
		</c:if>
		
	</c:forEach>
	
	<c:choose>
		<c:when test="${currentModule==8}">
			<li><a href="${pageContext.request.contextPath }/user/viewPersonalInfo.do" class="information_on"></a></li>
		</c:when>
		<c:otherwise>
			<li><a href="${pageContext.request.contextPath }/user/viewPersonalInfo.do" class="information_off"></a></li>
		</c:otherwise>
	</c:choose>
	
	<c:choose>
		<c:when test="${currentModule==9}">
			<li><a href="${pageContext.request.contextPath }/user/changePassword.do" class="password_on"></a></li>
		</c:when>
		<c:otherwise>
			<li><a href="${pageContext.request.contextPath }/user/changePassword.do" class="password_off"></a></li>
		</c:otherwise>
	</c:choose>
</ul>