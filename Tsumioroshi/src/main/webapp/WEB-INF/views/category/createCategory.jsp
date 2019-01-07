<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create Category</title>
<link rel="stylesheet" type="text/css" href="./resources/css/categori.css">
<style type="text/css">


</style>
<script src="resources/script/jquery-3.3.1.min.js"></script>
<script>
	$(function(){
		init();
		$('#createfirst').on('click', selectByNameFirst);
		$('#createsecond').on('click', selectByNameSecond);
		$('#search').on('click', selectByFcCodeSecond);
		
	});
	
	
function init(){
	$.ajax({
		url: 'selectAllFirst',
		type: 'post',
		success: function(resp){
			listFirst(resp);
		}
	});
}
	
function selectByNameFirst(){
	var first = $('#first').val().trim();
	if(first.length <= 0 || first.length > 20){
		alert('대분류명은 1~20 사이로 가능합니다');
	}else{
		$.ajax({
			url: 'selectByNameFirst',
			type: 'post',
			data: {
				fc_name: first
			},
			success: function(resp){
				if(!resp){
					createFirst();
				}else{
					alert("이미 존재하는 대분류 입니다.");
				}
			}
		});
	}
}

function selectByNameSecond(){
	var second = $('#second').val().trim();
	var firstoption = $("#firstoption option:selected").val();
	
	if(second.length <= 0 || second.length > 20){
		alert('소분류명은 1~20 사이로 가능합니다');
	}else{
		$.ajax({
			url: 'selectByNameSecond',
			type: 'post',
			data: {
				fc_code: firstoption,
				sc_name: second
			},
			success: function(resp){
				
				if(!resp){
					createSecond();
				}else{
					alert("이미 존재하는 소분류 입니다.")
				}
			}
		});
	}
}

function selectByFcCodeSecond(){
	var firstoption = $('#firstoption option:selected').val();
	
	$.ajax({
		url: 'selectByFcCodeSecond',
		type: 'post',
		data: {
			fc_code: firstoption
		},
		success: function(resp){
			listSecond(resp);
		}
	});
}

function createFirst(){
	var first = $('#first').val().trim();
	
	$.ajax({
		url: 'createFirst',
		type: 'post',
		data: {
			fc_name: first
		},
		success: function(resp){
			init();
		}
	});
}

function createSecond(){
	var second = $('#second').val().trim();
	var firstoption = $("#firstoption option:selected").val();
	
	$.ajax({
		url: 'createSecond',
		type: 'post',
		data: {
			fc_code: firstoption,
			sc_name: second
		},
		success: function(resp){
			$.ajax({
				url: 'selectSecond',
				type: 'post',
				data: {
					fc_code: firstoption
				},
				success: function(resp){
					listSecond(resp);
				}
			});
		}
	})
}

function deleteFirst(){
	var code = $(this).attr('data-code');
	
	$.ajax({
		url: 'deleteFirst',
		type: 'post',
		data: {
			'fc_code': code
		},
		success: function(resp){
			init();
		}
	})
	
}

function deleteSecond(){
	var code = $(this).attr('data-code');
	var firstoption = $("#firstoption option:selected").val();
	
	$.ajax({
		url: 'deleteSecond',
		type: 'post',
		data: {
			'sc_code': code
		},
		success: function(resp){
			$.ajax({
				url: 'selectSecond',
				type: 'post',
				data: {
					fc_code: firstoption
				},
				success: function(resp){
					listSecond(resp);
				}
			});
		}
	})
	
}

function listFirst(resp){
	var result ='';
	var options ='';
	
	result += '<h2 class="db_title"> 大 分 類 </h2>';
	result += '<table border="1"';
	result += '<tr class="db_tr">';
	result += '<th class="db_th">大 分 類 の 名</th>';
	result += '<th class="db_th">大 分 類 コ ー ド </th>';
	result += '</tr>';
	
	if(resp.length == 0){
		result += '<tr class="db_rut">';
		result += '<td colspan="3"  class="db_result">'+'<span style="color:red;">データがありません。</span>'+'</td>';
		result += '</tr>';
	}else{
		for(var i in resp){
			result += '<tr class="db_tr">';
			result += '<td class="db_td">'+resp[i].fc_name+'</td>';
			result += '<td class="db_td">'+resp[i].fc_code+'</td>';
			result += '<td class="db_td2">'+'<input class="deleteFirst" data-code="'+resp[i].fc_code+'" type="button" value=" 削 除 " >'+'</td>';
			result += '</tr>';
			
			options += '<option value="'+resp[i].fc_code+'">'+resp[i].fc_name+'</option>';
		}
	} 
	
	result += '</table>';
	
	$('#firstlist').html(result);
	$('#firstoption').html(options);
	
	$('.deleteFirst').on('click', deleteFirst);
}

function listSecond(resp){
	var result = '';
	result += '<h2 class="db_title"> 小 分 類  </h2>';
	result += '<table border="1"';
	result += '<tr class="db_tr">';
	result += '<th class="db_th">小  分 類 の 名</th>';
	result += '<th class="db_th">小  分 類 コ ー ド</th>';
	result += '</tr>';
	if(resp.length == 0){
		result += '<tr class="db_rut">';
		result += '<td colspan="3" class="db_result">'+'<span style="color:red;">データがありません。</span>'+'</td>';
		result += '</tr>';
	}else{
		for(var i in resp){
			result += '<tr class="db_tr">';
			result += '<td class="db_td">'+resp[i].sc_name+'</td>';
			result += '<td class="db_td">'+resp[i].sc_code+'</td>';
			result += '<td class="db_td2">'+'<input class="deleteSecond" data-code="'+resp[i].sc_code+'" type="button" value=" 削 除 " >'+'</td>';
			result += '</tr>';
		}
	}
	$('#secondlist').html(result);
	
	$('.deleteSecond').on('click', deleteSecond);
}
</script>
</head>
<body>
<div class="slide">
<div class="panel">
<div class="left-div">
	<div>
		<h2>カ テ ゴ リ ー 1 分 類 </h2>
		<form>
			<p>生 成 す る 大 分 類 の 名  <br/> <input id="first" type="text"></p><br/>
			<input class="bt2" type="button" id="createfirst" value="生 成"></input>
		</form>
	</div>
</div>
	<div id="firstlist">
	</div>
<div class="right-div">
	<div>
		<h2>カ テ ゴ リ ー 2 分 類 </h2>
		<form>
		<p>大 分 類 選 択 <br/> <select id="firstoption"></select> <br/></p>
			<p>生 成 す る 小 分 類 名 <br/><input id="second" type=text></p><br/>
			<input class="bt" id="search" type="button" value="照 会"> 
			<input class="bt" id="createsecond" type="button" value="生 成">
		</form>
	</div>
</div>
	<div id="secondlist">
	</div>
</div>
</div>
</body>
</html>