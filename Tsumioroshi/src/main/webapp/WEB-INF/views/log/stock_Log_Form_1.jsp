<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고 기록 작성 Form</title>
<link rel="stylesheet" type="text/css" href="./resources/css/stocklog.css">
<script src="resources/script/jquery-3.3.1.min.js"></script>
<script src="resources/script/stock_Log_Validation.js"></script>
</head>

<script>
	$(function(){
		init();
	});
	
	
function init(){
	$.ajax({
		url: 'selectAllFirst',
		type: 'post',
		success: function(resp){
			f_Category_Selectbox(resp);
		}
	});
}

// 카테고리 생성
function f_Category_Selectbox(resp){
	var result= '';
	
	result += '<td>';
	result += '<select id="product_Number_1" name="product_Number_1">';
	
	for(var i in resp){
	result += '<option value="'+resp[i].fc_code+'">'+resp[i].fc_name+'</option>';
	}
	
	result += '</select>';
	result += '<input type="button" id="show_S_Category" value="조회"></input>';
	result += '</td>';
	$('#f_Category').append(result);
	$('#show_S_Category').on('click', selectByFcCodeSecond);
}

function selectByFcCodeSecond(){
	var firstoption = $('#f_Category option:selected').val();
	$.ajax({
		url: 'selectByFcCodeSecond',
		type: 'post',
		data: {
			fc_code: firstoption
		},
		success: function(resp){
			s_Category_Selectbox(resp);
		}
	});
}

function s_Category_Selectbox(resp){
	var result= '';

	result += '<select id="product_Number_2" name="product_Number_2">';
	for(var i in resp){
	result += '<option value="'+ resp[i].sc_code +'">'+resp[i].sc_name+'</option>';
	}
	result += '</select>';
	$('#s_Category').html(result);
	var post_url = $('#s_Form1').attr("action");

}

</script>

<body>

<h2>入 庫 記 録 作 成</h2>
<form id="s_Form_1" action="stock_Log_Form_1" method="post" >
<div class="main">
	<table border="1">
		<tr>
			<th class="title">製 品 名</th>
			<td>
				<input id="product_Name" type="text" name="product_Name"/>
			</td>
		</tr>
		<tr id="f_Category">
			<th class="fc">第 一 カ テ ゴ リ ー</th>			
		</tr>
		<tr>
			<th class="sc">第 二 カ テ ゴ リ ー <input id="product_Number" type="hidden" name="product_Number" /></th> 
			<td id="s_Category">
			</td>
		</tr>		
		<tr>
			<th class="od">注 文 日 時</th>
			<td>
			<input id="order_Date" type="date" name="order_Date" />
			</td>
		</tr>
		<tr>
			<th class="dest">行 く 先</th>
			<td>
				<input id="departure" type="text" name="departure" />
			</td>
		</tr>
		<tr>
			<th class="da"> 注 文 量 </th>
			<td>
				<input id="stock_Amount" type="number" name="stock_Amount" />
			</td>
		</tr>
		<tr>
			<th class="charge">担 当 者</th>
			<td>
				<input id="charge1" type="text" name="charge1">
				<!-- 로그인 한 사람의 정보가 넘어가도록 변경해야함 + readonly="readonly" 추가 -->
			</td>
		</tr>
		
	</table>
	</div>
</form>

		<div class="bott">
			<div class="bt">
				<input class="bottom" type="button" value="다음 단계" id="next" />
				<input class="bottom" type="reset" value="지우기" />
			</div>
		</div>


</body>
</html>