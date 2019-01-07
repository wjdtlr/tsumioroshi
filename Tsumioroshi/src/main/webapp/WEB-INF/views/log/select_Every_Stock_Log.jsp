<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고 기록 전체</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/sesl.css">
<script src="resources/script/jquery-3.3.1.min.js"></script>

<script>
$(function(){
	init();
});

function init(){
$.ajax({
	url: 'select_Every_Stock_Log',
	type: 'post',
	//contentType:"application/json; charset:utf-8",
	success: function(resp){
		var result='';
		console.log(resp);
		 if(resp==''){
			result="<tr class='fales'><td colspan='3'>기록이 없습니다.</td>	</tr>";
		}else{
			for(var i=0;i<resp.length;i++){
				result+="<tr>";
				result+="<td class='number' id><a href='select_Stock_Log_By_Num?order_Number="+resp[i].order_Number+"'>"+resp[i].order_Number+"</a></td>";
				result+="<td class='date' id><a href='select_Stock_Log_By_Num?order_Number="+resp[i].order_Number+"'>"+resp[i].order_Date+"</a></td>";;
				result+="<td class='sekinin' id><a href='select_Stock_Log_By_Num?order_Number="+resp[i].order_Number+"'>"+resp[i].charge1+"</a></td>";;
				result+="</tr>";
			}
		}
		$(result).appendTo(".s_Log") 
	}
});
}
</script>
</head>
<body>

<h2> 入 庫 記 録 集 </h2>
<div class="main">
	<table class="s_Log" border="1">
	<tr>
		<th class="number2">주문번호</th>
		<th class="date2">주문일자</th>
		<th class="sekinin2">1차 책임자</th>
	</tr>
	<%-- 이하 선반 있는 경우 --%>

	
	
	
	
	</table>
</div>
</body>
</html>