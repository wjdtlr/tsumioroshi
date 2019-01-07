<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/search.css">
	<script type="text/javascript" src="resources/script/jquery-3.3.1.min.js"></script>
	<script>
		var search_Nfc=null;
		$(function(){
			$("#category").change(function(){
				console.log($(this).val()[0]);
				var date_Select_Span='';
				var buttons ='';
				$('#date_Set').html('');
				$('#NFC_Search').html('');
				$('#result').html('');
				$('#submit_Btn').removeAttr('disabled');
				if($(this).val()[0]=='NFC'){
					$('#submit_Btn').attr('disabled', 'disabled');
					date_Select_Span += '<table id="nfc_Table" class="tables">';
					date_Select_Span += '<tr>';
					date_Select_Span += '<th>제품 이름</th>';
					date_Select_Span += '<th>제품 번호</th>';
					date_Select_Span += '<th>태그 번호</th>';
					date_Select_Span += '<th>선반 위치</th>';
					date_Select_Span += '</tr>';
					date_Select_Span += '</table>';
					date_Select_Span += '<br/>';
					buttons += '<input type="button" id="nfc_Submit_Btn" class="btns" value="조회">';
					buttons += '<input type="button" id="stop_Btn" class="btns" value="조회 중지">';
					$("#result").html(date_Select_Span);
					$('.buttons').html(buttons);
					return;
				}else if($(this).val()[0]!='Product') {
					date_Select_Span += '<select name="date_Select_Input" id="date_Select_Input">';
					date_Select_Span += '<option value="year_Input">연별조회</option>';
					date_Select_Span += '<option value="month_Input">달별조회</option>';
					date_Select_Span += '<option value="period_Input">특정기간 조회</option>';
					date_Select_Span += '</select>';
					buttons += '<input type="button" id="submit_Btn" value="조회">';
					$('.buttons').html(buttons);
				}
				$("#date_Select").html(date_Select_Span);
				
			})//category
			
			$(document).on('change','#date_Select_Input',function(){
				var date_Set_Span='';
				var date_Select_Input = $("#date_Select_Input").val();
				var Now = new Date();
				if(date_Select_Input=='year_Input') date_Set_Span+='<input type="number" name="year_Input" id="year_Input" value="'+Now.getFullYear()+'"/>';
				else if(date_Select_Input=='month_Input') 
					date_Set_Span+='<input type="month" name="month_Input" id="month_Input" value="'+Now.getFullYear()+'-'+((Now.getMonth()+1)<10? "0"+(Now.getMonth()+1) : (Now.getMonth()+1))+'"/>';
				else {
					date_Set_Span+='<input type="date" name="start_Date" id="start_Date"/>';
					date_Set_Span+=' ~ ';
					date_Set_Span+='<input type="date" name="end_Date" id="end_Date"/>';
				}
				$('#date_Set').html(date_Set_Span);
			})
			
			$(document).on('click', '#submit_Btn',function(){
				console.log("??");
				var form_Action = $("#search_Form").attr('action');
				var form_method = $("#search_Form").attr('method');
				var form_Array = $("#search_Form").serializeArray();
				var form_data={};
			    for (var i = 0; i < form_Array.length; i++){
			    	form_data[form_Array[i]['name']] = form_Array[i]['value'];
				}

			    $.ajax({
			    	url:"search",
			    	method:'post',
			    	data: JSON.stringify(form_data),
			    	dataType: 'json',
			    	contentType: 'application/json; charset=utf-8',
			    	success: function(resp){
			    		$('#result').text('');
		    			var result='<table class="tables"><tr>';
		    			if(resp.products!=null){
		    				result+='<th>제품이름</th>	';
		    				result+='<th>제품번호</th>	';
		    				result+='<th>재고수량</th>	';
		    				result+='</tr>'
			    			for(var i=0;i<resp.products.length;i++){
			    				result+='<tr>'
			    				result+='<td>'+resp.products[i].product_Name+'</td>';
			    				result+='<td>'+resp.products[i].product_Number+'</td>';
			    				result+='<td>'+resp.products[i].quantity+'</td>';
			    				result+='</tr>'
			    			}//for
		    			}//if
		    			if(resp.stock_Logs!=null){
		    				result+='<th>제품이름</th>';
		    				result+='<th>제품번호</th>';
		    				result+='<th>입고번호</th>';
		    				result+='<th>주문날짜</th>';
		    				result+='<th>기록날짜</th>';
		    				result+='<th>입고지</th>';
		    				result+='<th>입고량</th>';
		    				result+='<th>사무관리자 확인</th>';
		    				result+='<th>창고관리자 확인</th>';
		    				result+='<th>최종 확인 날짜</th>';
		    				result+='</tr>'
			    			for(var i=0;i<resp.stock_Logs.length;i++){
			    				result+='<tr>'
			    				result+='<td class="na">'+resp.stock_Logs[i].product_Name+'</td>';
			    				result+='<td class="num">'+resp.stock_Logs[i].product_Number+'</td>';
			    				result+='<td class="cnum">'+resp.stock_Logs[i].order_Number+'</td>';
			    				result+='<td class="judate">'+resp.stock_Logs[i].order_Date+'</td>';
			    				result+='<td class="gidate">'+resp.stock_Logs[i].log_Date+'</td>';
			    				result+='<td class="spot">'+resp.stock_Logs[i].departure+'</td>';
			    				result+='<td class="ryo">'+resp.stock_Logs[i].stock_Amount+'</td>';
			    				result+='<td class="kakunin">'+resp.stock_Logs[i].charge1+'</td>';
			    				result+='<td class="kakunin2">'+resp.stock_Logs[i].charge2+'</td>';
			    				result+='<td class="finaldate">'+resp.stock_Logs[i].confirm_Date+'</td>';
			    				result+='</tr>'
			    			}//for
		    			}//if
		    			if(resp.release_Logs!=null){
		    				result+='<th>제품이름</th>';
		    				result+='<th>제품번호</th>';
		    				result+='<th>출고번호</th>';
		    				result+='<th>주문날짜</th>';
		    				result+='<th>기록날짜</th>';
		    				result+='<th>출고지</th>';
		    				result+='<th>출고량</th>';
		    				result+='<th>사무관리자 확인</th>';
		    				result+='<th>창고관리자 확인</th>';
		    				result+='<th>최종 확인 날짜</th>';
		    				result+='</tr>'
			    			for(var i=0;i<resp.release_Logs.length;i++){
			    				result+='<tr>'
			    				result+='<td class="na">'+resp.release_Logs[i].product_Name+'</td>';
			    				result+='<td class="num">'+resp.release_Logs[i].product_Number+'</td>';
			    				result+='<td class="cnum">'+resp.release_Logs[i].order_Number+'</td>';
			    				result+='<td class="judate">'+resp.release_Logs[i].order_Date+'</td>';
			    				result+='<td class="gidate">'+resp.release_Logs[i].log_Date+'</td>';
			    				result+='<td class="spot">'+resp.release_Logs[i].destination+'</td>';
			    				result+='<td class="ryo">'+resp.release_Logs[i].delivery_Amount+'</td>';
			    				result+='<td class="kakunin">'+resp.release_Logs[i].charge1+'</td>';
			    				result+='<td class="kakunin2">'+resp.release_Logs[i].charge2+'</td>';
			    				result+='<td class="finaldate">'+resp.release_Logs[i].confirm_Date+'</td>';
			    				
			    				result+='</tr>'
			    			}//for
		    			}//if
		    			result+='</table>'
		    			console.log(result);
			    		$('#result').html(result);
			    	}
			    })
			})
			$(document).on('click', '#nfc_Submit_Btn', function(){
				$('#nfc_Submit_Btn').attr('disabled', 'disabled');
				start();
				
			})
			
			$(document).on('click', '#stop_Btn', function(){
				stop();
				$('#nfc_Submit_Btn').removeAttr('disabled');
			})
		})
		function start() {
			var nfc_Sw=false;
			$.ajax({
				url:'search_Start',
				method:'post',
				success:function(resp){
					console.log(resp);
					if(resp.msg!=null){
						alert(resp.msg);
						$('#nfc_Submit_Btn').removeAttr('disabled');
						return;
					}
					
					search_Nfc = setInterval(function(){
						$.ajax({
							url:'search_Check',
							method:'post',
							success:function(resp){
								console.log(resp);
								if(resp.product!=null){
									var result ='';
									for(var i=0;i<resp.product.length;i++){
										result += '<tr>';
										result += '<th>'+resp.product[i].product_Name+'</th>';
										result += '<th>'+resp.product[i].product_Number+'</th>';
										result += '<th>'+resp.product[i].tag_Number+'</th>';
										result += '<th>'+resp.product[i].product_Location+'</th>';
										result += '</tr>';
									}
									$(result).appendTo('#nfc_Table');
								}
							}
						});
					},2000);
				},
				complete: function(resp){
					console.log(resp);
				}
			});
			/* console.log('search1');
			if(nfc_Sw==true){
				
			} */
				
		}
		function stop() {
			clearInterval(search_Nfc);
			$.ajax({
				url:"search_Stop",
				method:"post",
				success:function(resp){
					search_Nfc=null;
				}
			})
			
				//eventSource = null;
		}
	</script>
</head>
<body>
<div class="main">
<h2 class="title"> 在 庫 照 会 </h2>
	<form action="seacrh" method="post" id="search_Form">
		<select name="category" id="category" multiple="multiple">
			<option value="Product">재고</option>
			<option value="Stock_Log">입고</option>
			<option value="Release_Log">출고</option>
			<option value="NFC">NFC조회</option>
		</select>
	
		<input type="text" id="product_Name" name="product_Name"/>	
		<span id="date_Select"></span>	<span id="date_Set"></span>
		<span id="NFC_Search"></span>
	</form>
	<div id="result"></div>
		<div class="buttons">
		<input type="button" id="submit_Btn" value="조회">
		</div>
</div>
</body>
</html>