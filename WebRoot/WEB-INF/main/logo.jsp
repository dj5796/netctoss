<%@page pageEncoding="utf-8"%>

<!--SweetAlert提示框插件-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sweetalert.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/styles/sweetalert.css">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/styles/global.css">
<script type="text/javascript" src="../js/jquery-1.11.1.js"></script>
<script type="text/javascript">
	$(function(){
		$('#logout').click(function(){
			swal({  
	        	title:"确定要退出吗？",  
	        	type:"warning",  
	        	showCancelButton: true
	    	}, function() {  
	    		window.location.href = "${pageContext.request.contextPath }/login/logout.do";
	    	});  
		});
		
		showTime();
	});
	
	//补位函数。  
    function extra(x) {  
        //如果传入数字小于10，数字前补一位0。  
        if(x < 10) {  
            return "0" + x;  
        }  else   {  
            return x;  
        }  
    }  
    
	function showTime() {
		//获得显示时间的div    
		t_div = document.getElementById('showtime');
		var now = new Date()
		//替换div内容    
		t_div.innerHTML = now.getFullYear() + "-" +  extra((now.getMonth() + 1)) + "-"
				+  extra(now.getDate()) + " " + extra(now.getHours()) + ":" + extra(now.getMinutes())
				+ ":" +  extra(now.getSeconds());
		//等待一秒钟后调用time方法，由于settimeout在time方法内，所以可以无限调用  
		setTimeout(showTime, 1000);
	}
</script>
<img src="<%=request.getContextPath()%>/images/logo.png" alt="logo" class="left" id="logoImg">
<span id="showtime" class="show_time"></span>
<!-- 
	EL默认从page/request/session/application四个对象取值,而不会从cookie取值，
	想要从cookie取值，必须按照以下语法来写EL ：cookie.key.value
-->
<%-- <span>${cookie.adminCode.value}</span> --%>
<!-- 按照指定范围查找 -->
<span class="logout">${sessionScope.admin.name}</span>
<a href="#" id="logout" class="logout">[退出]</a>

