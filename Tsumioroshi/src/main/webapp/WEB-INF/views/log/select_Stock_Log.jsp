<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고 기록 하나만 보여줌</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/selectstock.css">
</head>

<script src="resources/script/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	
	if('${empty s_Log.charge2}' == 'true'){
		if('${sessionScope.authority}' == 'Master'){
			$('#logdata').append('<tr><th colspan="2" id="buttons"><input type="button" value="　確　認　" id="next"/><input type="button" value="　記　録　削　除　" id="delete"/></th></tr>');
			$('#next').on('click', function(){
				stock_Log_Form_2()
			});
		}
		
		if('${sessionScope.authority}' == 'WareHouse'){
			$('#logdata').append('<tr><th colspan="2" id="buttons"><input type="button" value="　確　認　" id="next"/></th></tr>');
			$('#next').on('click', function(){
				stock_Log_Form_2()
			});
		}
		
		if('${sessionScope.authority}' == 'OfficeWork'){
			$('#logdata').append('<tr><th colspan="2" id="buttons"><input type="button" value="　記　録　削　除　" id="delete"/></th></tr>');
			$('#next').on('click', function(){
				stock_Log_Form_2()
			});
		}
	}
});

function stock_Log_Form_2() {	
		var host = location.host;
		location.href= "/tsumioroshi/stock_Log_Form_2?order_Number=${s_Log.order_Number}";

}

function objectifyForm(formArray) {//serialize data function

var returnArray = {};
for (var i = 0; i < formArray.length; i++){
	returnArray[formArray[i]['name']] = formArray[i]['value'];
}
return returnArray;
}
</script>

<body>
<h2> 入 庫   記 録 内 容 </h2>
	<div class="main">
	
	<table border="1" id="logdata">
		<tr>
			<th class="tkdvnaaud"> 商 品 名 </th>
			<td>${s_Log.product_Name}</td>
		</tr>
		<tr>
			<th class="wpvnaqjsgh"> 製 品 番 号 </th>
			<td id = "pnum" data-value="${s_Log.product_Number}">${s_Log.product_Number}</td>
		</tr>
		<tr>
			<th class="wnansqjsgh"> 注 文 番 号 </th>
			<td>${s_Log.order_Number}</td>
		</tr>
		<tr>
			<th class="wnansdlfwk"> 注 文 の 日 付 </th>
			<td>${s_Log.order_Date}</td>
		</tr>
		<tr>
			<th class="rlfhrdlfwk"> 記 録 の 日 付 </th>
			<td>${s_Log.log_Date}</td>
		</tr>
		<tr>
			<th class="cnfcj"> 出 所 天 国</th>
			<td>${s_Log.departure}</td>
		</tr>
		<tr>
			<th class="dlqrhtnfid"> 着 て 数 量 </th>
			<td>${s_Log.stock_Amount}</td>
		</tr>
		<tr>
			<th class="admin_1"> 1 次 的 な 責 任 者 </th>
			<td>${s_Log.charge1}</td>
		</tr>
		<tr>
			<th class="admin_2"> 2 次 的 な 責 任 者 </th>
			
			<c:if test = "${empty s_Log.charge2}">
			<td>まだ確認されませんでした。</td>
			</c:if>
			
			<c:if test = "${not empty s_Log.charge2}">
			<td>${s_Log.charge2}</td>
			</c:if>
			
		</tr>
		
	</table>
	<a href="javascript:history.back()" class="back_bt" ><i class="fas fa-times" title="뒤로가기"></i></a>
	</div>
</body>
</html>