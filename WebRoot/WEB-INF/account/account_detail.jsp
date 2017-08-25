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
            <form action="" method="post" class="main_form">
                <!--必填项-->
                <div class="text_info clearfix"><span>账号ID：</span></div>
                <div class="input_info"><input type="text" value="${account.account_id}" readonly="readonly" class="readonly width180" /></div>
                <div class="text_info clearfix"><span>登录账号：</span></div>
                <div class="input_info"><input type="text" value="${account.login_name }" readonly="readonly" class="readonly width180"/></div> 
                <div class="text_info clearfix"><span>开通状态：</span></div>
                <div class="input_info">
                    <select disabled="disabled" class="width150">
                        <option <c:if test="${account.status==0 }">selected="selected"</c:if> >开通</option>
                        <option <c:if test="${account.status==1 }">selected="selected"</c:if> >暂停</option>
                        <option <c:if test="${account.status==2 }">selected="selected"</c:if> >删除</option>
                    </select>                        
                </div>
                <div class="text_info clearfix"><span>开通/暂停/删除：</span></div>
                <div class="input_info">
                	<c:choose>
                		<c:when test="${account.status==0}">
                			<input type="text" readonly="readonly" class="readonly width180" value="<fmt:formatDate value="${account.create_date}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
                		</c:when>
                		<c:when test="${account.status==1}">
                			<input type="text" readonly="readonly" class="readonly width180" value="<fmt:formatDate value="${account.pause_date}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
                		</c:when>
                		<c:otherwise>
                			<input type="text" readonly="readonly" class="readonly width180" value="<fmt:formatDate value="${account.close_date}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
                		</c:otherwise>
                	</c:choose>
                </div>
                <div class="text_info clearfix"><span>上次登录时间：</span></div>
                <div class="input_info">
                	<input type="text" readonly="readonly" class="readonly width180" value="<fmt:formatDate value="${account.last_login_time}" pattern="yyyy年MM月dd日 HH:mm:ss"/>" />
                </div>
                <div class="text_info clearfix"><span>上次登录IP：</span></div>
                <div class="input_info"><input type="text" readonly="readonly" class="readonly width180" value="${account.last_login_ip}" /></div>
                <div class="text_info clearfix"><span>姓名：</span></div>
                <div class="input_info"><input type="text" value="${account.real_name}" readonly="readonly" class="readonly width180" /></div>
                <div class="text_info clearfix"><span>身份证：</span></div>
                <div class="input_info"><input type="text" value="${account.idcard_no }" readonly="readonly" class="readonly width180"/></div>
                <div class="text_info clearfix"><span>生日：</span></div>
                <div class="input_info"><input type="text" readonly="readonly" class="readonly width180" value="<fmt:formatDate value="${account.birthdate}" pattern="yyyy年MM月dd日"/>"/></div>
                <div class="text_info clearfix"><span>性别：</span></div>
                <div class="input_info fee_type">
	                <input type="radio" name="gender" <c:if test="${account.gender==0 }">checked</c:if> id="secrecy" disabled="disabled"/>
	                <label for="secrecy" class="width30">保密</label>
	                <input type="radio" name="gender" <c:if test="${account.gender==1 }">checked</c:if> id="male" disabled="disabled"/>
	                <label for="male" class="width30">男</label>
	                <input type="radio" name="gender" <c:if test="${account.gender==2 }">checked</c:if> id="female" disabled="disabled"/>
	                <label for="female" class="width30">女</label>
                </div>
                <div class="text_info clearfix"><span>职业：</span></div>
                <div class="input_info">
                    <select disabled="disabled" class="width150">
                    	<option <c:if test="${account.occupation==0 }">selected</c:if>>请选择</option>
	                    <option <c:if test="${account.occupation==1 }">selected</c:if>>干部</option>
	                    <option <c:if test="${account.occupation==2 }">selected</c:if>>学生</option>
	                    <option <c:if test="${account.occupation==3 }">selected</c:if>>技术人员</option>
	                    <option <c:if test="${account.occupation==4 }">selected</c:if>>其他</option>
                    </select>                        
                </div>
                <div class="text_info clearfix"><span>电话：</span></div>
                <div class="input_info"><input type="text" class="width180 readonly" readonly="readonly" value="${account.telephone }"/></div>
                <div class="text_info clearfix"><span>QQ号：</span></div>
                <div class="input_info"><input type="text" class="readonly width180" readonly="readonly" value="${account.qq }" /></div>                
                <div class="text_info clearfix"><span>Email：</span></div>
                <div class="input_info"><input type="text" class="width300 readonly" readonly="readonly" value="${account.email}"/></div> 
                <div class="text_info clearfix"><span>通信地址：</span></div>
                <div class="input_info"><input type="text" class="width300 readonly" readonly="readonly" value="${account.mailaddress }" /></div> 
                <div class="text_info clearfix"><span>邮政邮编：</span></div>
                <div class="input_info"><input type="text" class="readonly width180" readonly="readonly" value="${account.zipcode }" /></div> 
                <div class="text_info clearfix"><span>推荐人账务ID：</span></div>
                <div class="input_info"><input type="text" readonly="readonly" class="readonly width180" value="${account.recommender_id}" /></div>
                <div class="text_info clearfix"><span>推荐人身份证：</span></div>
                <div class="input_info"><input type="text" readonly="readonly" class="readonly width180" value="${account.recommender_idcardno}" /></div>
                <div class="text_info clearfix"><span>推荐人姓名：</span></div>
			    <div class="input_info"><input type="text" readonly="readonly" class="width180 readonly" id="recommender_name" value="${account.recommender_name}"/></div>
                
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
