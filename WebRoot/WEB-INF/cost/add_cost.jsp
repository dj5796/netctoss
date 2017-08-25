<%@page pageEncoding="utf-8"%>
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
			$(function(){
				$("#name")
	    			.on('focus',function(){
	    				$("#name_msg").removeClass("error_msg")
	    				.text('50长度以内的字符');
	    			})
	    			.on('blur',checkName)
	    			.focus();
				
				$("#base_duration")
	    			.on('focus',function(){
	    				$("#base_duration_msg").removeClass("error_msg")
	    				.text('1-600之间的整数');
	    			})
	    			.on('blur',checkBaseDuration);
				
				$("#base_cost")
	    			.on('focus',function(){
	    				$("#base_cost_msg").removeClass("error_msg")
	    				.text('0-99999.99之间的数值');
	    			})
	    			.on('blur',checkBaseCost);
				
				$("#unit_cost")
	    			.on('focus',function(){
	    				$("#unit_cost_msg").removeClass("error_msg")
	    				.text('0-99999.99之间的数值');
	    			})
	    			.on('blur',checkUnitCost);
				
				$("#descr")
	    			.on('focus',function(){
	    				$("#descr_msg").removeClass("error_msg")
	    				.text('100长度以内的字符');
	    			})
	    			.on('blur',checkDescr);
			});
			
			//资费名称
	    	function checkName(){
	    		var name = $("#name").val();
	    		if(name == "") {
	    			$("#name_msg").text("请输入资费名称").addClass("error_msg");
	    			return false;
	    		}
	    		var reg = /^.{0,50}$/;
	    		if (!reg.test(name)) {
	    			$("#name_msg").text("50长度以内的字符").addClass("error_msg");
	    			return false;
	    		}
	    		$("#name_msg").empty();
	    		return true;
	    	}
			
			//基本时长
			function checkBaseDuration(){
				var base_duration=$("#base_duration").val();
				if(!base_duration){
					$("#base_duration_msg").text('请输入基本时长').addClass("error_msg");
					return false;
				}
				
				var reg = /^([1-9]\d{0,1}|[1-5]\d{2}|600)$/;
	    		if (!reg.test(base_duration)) {
	    			$("#base_duration_msg").text("1-600之间的整数").addClass("error_msg");
	    			return false;
	    		}
	    		$("#base_duration_msg").empty();
	    		return true;
			}
			
			//基本费用
			function checkBaseCost(){
				var base_cost=$("#base_cost").val();
				if(!base_cost){
					$("#base_cost_msg").text('请输入基本时长').addClass("error_msg");
					return false;
				}
				
				var reg = /^\d{1,5}(\.\d{1,2})?$/;
	    		if (!reg.test(base_cost)) {
	    			$("#base_cost_msg").text("0-99999.99之间的数值").addClass("error_msg");
	    			return false;
	    		}
	    		$("#base_cost_msg").empty();
	    		return true;
			}
			
			//单位费用
			function checkUnitCost(){
				var unit_cost=$("#unit_cost").val();
				if(!unit_cost){
					$("#unit_cost_msg").text('请输入单位费用').addClass("error_msg");
					return false;
				}
				
				var reg = /^\d{1,5}(\.\d{1,2})?$/;
	    		if (!reg.test(unit_cost)) {
	    			$("#unit_cost_msg").text("0-99999.99之间的数值").addClass("error_msg");
	    			return false;
	    		}
	    		$("#unit_cost_msg").empty();
	    		return true;
			}
			
			//资费说明
			function checkDescr(){
				var descr=$("#descr").val();
				if(!descr){
					$("#descr_msg").empty();
					return true;
				}
				
				var reg = /^.{0,100}$/;
	    		if (!reg.test(descr)) {
	    			$("#descr_msg").text("100长度以内的字符").addClass("error_msg");
	    			return true;
	    		}
	    		$("#descr_msg").empty();
	    		return true;
			}
			
	    	//提交时检查数据是否符合规则    
	    	function saveAction(){
	    		var flag=checkName() && checkDescr();
	    		var cost_type=$(':radio[name="cost_type"]:checked').val();
	    		if(cost_type==1){
	    			flag=flag && checkBaseCost();
	    		} else if(cost_type==2){
	    			flag=flag && checkBaseDuration() && checkBaseCost() && checkUnitCost();
	    		} else if(cost_type==3){
	    			flag=flag && checkUnitCost();
	    		}
	    		
	    		if(!flag){
	       			swal({
	       				title:'Oh, My God !',
	       				html:true,
	       				text:'<span class="swal_error">必填项中存在不符合规则的数据，请检查 !</span>',
	       				type:'error',
	       				timer:2000
	       			});
	       			return false;
	    		}
	    		
	    		sweetAlert({
			        title: "您确定要增加该资费吗？",  
			        type: "warning", 
			        showCancelButton: true,
			        closeOnConfirm: false, 
			        animation:"slide-from-top"
			    }, function() {
			    	$.post(
		    			"addCost.do",
		    			$('#addCost').serialize(),
				      	function(data) {
				      		if(data) {
				      			swal("增加资费成功!","","success");
				      			setTimeout(function(){
				      				location.href=data;
				       			}, 2000);
				      		}
				      	}
				     );
			    });
	    	}
        
            //切换资费类型
            function feeTypeChange(type) {
	            if (type == 1) {
		        	$("#base_duration").attr("disabled",true).val("");
		        	$("#base_duration_required").hide();
		    		$("#base_duration_msg").empty();
	                
	                $("#base_cost").attr("disabled",false);
		        	$("#base_cost_required").show();
	                
	                $("#unit_cost").attr("disabled",true).val("");
		        	$("#unit_cost_required").hide();
		    		$("#unit_cost_msg").empty();
	            } else if (type == 2) {
		        	$("#base_duration").attr("disabled",false);
		        	$("#base_duration_required").show();
	                
	                $("#base_cost").attr("disabled",false);
		        	$("#base_cost_required").show();
	                
	                $("#unit_cost").attr("disabled",false);
		        	$("#unit_cost_required").show();
	            } else if (type == 3) {
		        	$("#base_duration").attr("disabled",true).val("");
		        	$("#base_duration_required").hide();
		    		$("#base_duration_msg").empty();
	                
	                $("#base_cost").attr("disabled",true).val("");
		        	$("#base_cost_required").hide();
		    		$("#base_cost_msg").empty();
	                
	                $("#unit_cost").attr("disabled",false);
		        	$("#unit_cost_required").show();
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
            <form action="addCost.do" method="post" class="main_form" id="addCost">
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info">
                    <input type="text" class="width300" name="name" id="name"/>
                    <span class="required">*</span>
                    <div class="validate_msg_short" id="name_msg">50长度以内的字符</div>
                </div>
                
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info fee_type">
                    <input type="radio" name="cost_type" value="1" id="monthly" onclick="feeTypeChange(1);" />
                    <label for="monthly">包月</label>
                    <input type="radio" name="cost_type" value="2" checked="checked" id="package" onclick="feeTypeChange(2);" />
                    <label for="package">套餐</label>
                    <input type="radio" name="cost_type" value="3" id="timeBased" onclick="feeTypeChange(3);" />
                    <label for="timeBased">计时</label>
                </div>
                
                <div class="text_info clearfix"><span>基本时长：</span></div>
                <div class="input_info">
                    <input type="text" name="base_duration" id="base_duration" class="width100 text_align" />
                    <span class="info">小时</span>
	                <span class="required" id="base_duration_required">*</span>
                    <div class="validate_msg_long" id="base_duration_msg">1-600之间的整数</div>
                </div>
                <div class="text_info clearfix"><span>基本费用：</span></div>
                <div class="input_info">
                    <input type="text" name="base_cost" id="base_cost" class="width100 text_align" />
                    <span class="info">元</span>
                    <span class="required" id="base_cost_required">*</span>
                    <div class="validate_msg_long" id="base_cost_msg">0-99999.99之间的数值</div>
                </div>
                
                <div class="text_info clearfix"><span>单位费用：</span></div>
                <div class="input_info">
                    <input type="text" name="unit_cost" id="unit_cost" class="width100 text_align" />
                    <span class="info">元/小时</span>
                    <span class="required" id="unit_cost_required">*</span>
                    <div class="validate_msg_long" id="unit_cost_msg">0-99999.99之间的数值</div>
                </div>
                
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea name="descr" id="descr" class="width300 height70"></textarea>
                    <div class="validate_msg_short" id="descr_msg">100长度以内的字符</div>
                </div>                    
                
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="saveAction();"/>
                    <input type="button" value="返回" class="btn_save" onclick="history.back();"/>
                </div>
            </form>  
        </div>
        <!--主要区域结束:版权区域-->
        <jsp:include page="../main/copyright.jsp"/> 
    </body>
</html>