<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출고 기록 작성 Form</title>
<link rel="stylesheet" type="text/css" href="./resources/css/releaselog.css">
</head>
<script src="resources/script/jquery-3.3.1.min.js"></script>

<script>

	$(function() {
		$('#checkpro').on('click', function() {
			window.location.href="javascript:void(window.open('checkpro','조회', 'width=650px, height=520px'))";
		});
	});
	
	function init(name){
		$.ajax({
			url: 'selectProductByName',
			type: 'post',
			data: {
				'product_Name': name
			},
			success: function(resp){
				$('#product_Name').val(resp[0].product_Name);
				$('#product_Number').val(resp[0].product_Number);
				getCategory(resp[0].product_Number);
				$('#total').text('재고 : '+resp.length);
			}
		});
	}
	
	function getCategory(number){
		
		$.ajax({
			url: 'getCategory',
			type: 'post',
			data: {
				'number': number
			},
			success: function(resp){
				$('#first_Category').val(resp[0]);
				$('#second_Category').val(resp[1]);
			}
		});
	}
</script>

<body>

<h2>  出 庫 記 録 作 成 </h2>
<form id="r_Form_1" action="release_Log_Form_1" method="POST">
<div class="main">
<script type="text/javascript">
	function javascript(){
	window.location.href="javascript:void(window.open('release_Log_Form_1','出', 'width=650px, height=520px'))";
	}
</script>
	<table border="1">
		<tr>
			<th class="title">製 品 名</th>
			<td>
				<input id="product_Name" type="text" name="product_Name" readonly="readonly" />
				<input type="button" id="checkpro" value="조회" onclick='javascript()'/>
			</td>
		</tr>
		<tr>
			<th class="pn">製 品 番 号</th>
			<td>
				<input id="product_Number" type="text" name="product_Number" readonly="readonly"/>
			</td>
		</tr>
		<tr id="f_Category">
			<th class="fc">第 一 カ テ ゴ リ ー</th>
			<td>
				<input id="first_Category" type="text" readonly="readonly" />
			</td>		
		</tr>
		<tr>
			<th class="sc">第 二 カ テ ゴ リ ー</th> 
			<td id="s_Category">
				<input id="second_Category" type="text" readonly="readonly" />
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
				<input id="destination" type="text" name="destination" />
			</td>
		</tr>
		<tr>
			<th class="da">注 文 量</th>
			<td>
				<input id="delivery_Amount" type="number" name="delivery_Amount" /><p id="total"></p>
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
				<input class="bottom" id="next" type="button" value="다음 단계"  />
				<input class="bottom" type="reset" value="지우기" />
			</div>
	</div>

</body>
<script src="resources/script/release_Log_Validation.js"></script>
</html>