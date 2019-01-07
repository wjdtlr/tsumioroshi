<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출고 기록 하나만 보여줌</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/selectReleaseLog.css">
</head>

<script src="resources/script/jquery-3.3.1.min.js"></script>
<script>
$(function(resp){
	if('${empty r_Log.charge2}' == 'true'){
		if('${sessionScope.authority}' == 'Master'){
			$('.r_Log').append('<tr><th colspan="2"  class="kate2"><input type="button" value="2단계 확인" id="next"/><input type="button" value="기록 삭제" id="delete"/></th></tr>');
		}
		
		if('${sessionScope.authority}' == 'WareHouse'){
			$('.r_Log').append('<tr><th colspan="2"  class="kate2"><input type="button" value="2단계 확인" id="next"/></th></tr>');
			
		}
		
		if('${sessionScope.authority}' == 'OfficeWork'){
			$('.r_Log').append('<tr><th colspan="2"  class="kate2"><input type="button" value="기록 삭제" id="delete"/></th></tr>');
			
		}
	}
	$('#next').on('click', function(){
		release_Log_Form_2()
	});
});

function release_Log_Form_2() {	
	location.href="/tsumioroshi/release_Log_Form_2?order_Number=${r_Log.order_Number}";
}

</script>

<body>
<h2> 出 庫 記 録 内 容 </h2>
<div class="main">
	<table class="r_Log" border="1">
		<tr>
			<th class="kate">상품명</th>
			<td>${r_Log.product_Name}</td>
		</tr>
		<tr>
			<th class="kate">제품 번호</th>
			<td>${r_Log.product_Number}</td>
		</tr>
		<tr>
			<th class="kate">주문 번호</th>
			<td>${r_Log.order_Number}</td>
		</tr>
		<tr>
			<th class="kate">주문 일자</th>
			<td>${r_Log.order_Date}</td>
		</tr>
		<tr>
			<th class="kate">기록 일자</th>
			<td>${r_Log.log_Date}</td>
		</tr>
		<tr>
			<th class="kate">목적지</th>
			<td>${r_Log.destination}</td>
		</tr>
		<tr>
			<th class="kate">배송 수량</th>
			<td>${r_Log.delivery_Amount}</td>
		</tr>
		<tr>
			<th class="kate">1차 책임자</th>
			<td>${r_Log.charge1}</td>
		</tr>
		<tr>
			<th class="kate">2차 책임자</th>
			
			<c:if test = "${empty r_Log.charge2}">
			<td>아직 확인하지 않은 기록 입니다.</td>
			</c:if>
			
			<c:if test = "${not empty r_Log.charge2}">
			<td>${r_Log.charge2}</td>
			</c:if>
			
		</tr>
	</table>
	<a href="javascript:history.back()" class="back_bt" ><i class="fas fa-times" title="뒤로가기"></i></a>
</div>
</body>
</html>