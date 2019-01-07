<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MemberSelect</title>
<link rel="stylesheet" type="text/css" href="./resources/css/memberselect.css">
<link href="https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300" rel="stylesheet">
<style type="text/css">

body{
	
	overflow: hidden;

}


</style>
<script src="resources/script/jquery-3.3.1.min.js"></script>
<script>

	$(function(){
		init();
		$(document).on('click', '.remove', function() {
			var userid = $(this).parent().parent().children('.userid').text();
			
			deleteMember(userid);
			
		});
		$('#create').on('click', function(){
			window.open("insertMember", "pop");
		});
	});
	
function init(){
	listOffice();
	listWareHouse();
}

function listOffice(){
	$.ajax({
		url: 'listOffice',
		type: 'post',
		success: function(resp){
			
				var result ='';
				
				result += '<h4 class="head">사무관리자</4>';
				result += '<table border="1"';
				result += '<tr>';
				result += '<th>ID</th>';
				result += '<th>PASSWORD</th>';
				result += '<th>AUTHORITY</th>';
				result += '</tr>';
				
				for(var i in resp){
					result += '<tr>';
					result += '<td class="userid" value="1">'+resp[i].id+'</td>';
					result += '<td>'+resp[i].password+'</td>';
					result += '<td>'+resp[i].authority+'</td>';
					result += '<td><input class="remove" type="button" value="Del"></td>';
					result += '</tr>';
				}
				result += '</table>';
				$('#officelist').html(result);
			
		}
	});
}

function listWareHouse(){
	$.ajax({
		url: 'listWareHouse',
		type: 'post',
		success: function(resp){
			
				var result ='';
				
				result += '<h4 class="head">창고관리자</4>';
				result += '<table border="1"';
				result += '<tr>';
				result += '<th>ID</th>';
				result += '<th>PASSWORD</th>';
				result += '<th>AUTHORITY</th>';
				result += '</tr>';
				
				for(var i in resp){
					result += '<tr>';
					result += '<td class="userid">'+resp[i].id+'</td>';
					result += '<td>'+resp[i].password+'</td>';
					result += '<td>'+resp[i].authority+'</td>';
					result += '<td><input class="remove" type="button" value="Del"></td>';
					result += '</tr>';
					
				}
				result += '</table>';
				$('#warehouselist').html(result);
		
		}
	});
}

function deleteMember(userid){
	
	$.ajax({
		url: 'deleteMember',
		type: 'post',
		data: {
			id: userid
		},
		success: function(resp){
			listOffice();
			listWareHouse();
		}
	})
}




</script>
</head>

<body>

<h2>M A N A G E R</h2>

<div class="main">
	<div class="top">
	<div class="left-div">
		<h3></h3>
		<div id="officelist"></div>
	</div>
	<div class="right-div">
		<h3></h3>
		<div id="warehouselist"></div>
	</div>
	</div>
	

</div>

<div>
	<input class="create" type="button" value="관리자생성" onclick="window.open('insertMember', 'create', 'width=650, height=400')">
</div>
</body>
</html>