<%@page pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" /> 
        <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.js"></script>
        <script type="text/javascript" language="javascript">
        	$(function(){
        		$('#header').css("background","none");
        		$('#logoImg').hide();
        	});
        </script>
    </head>
    <body class="index">
    	<!--Logo区域开始-->
        <div id="header">
            <jsp:include page="../main/logo.jsp"/>   
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <div id="index_navi">
        	<jsp:include page="menu.jsp" />
        </div>
    </body>
</html>