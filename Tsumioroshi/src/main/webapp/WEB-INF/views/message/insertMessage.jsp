<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./resources/css/insertMessage.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<style type="text/css">
	#content{
	resize: none; /* 사용자 임의 변경 불가 */
  	
	}

</style>
<script src="resources/script/jquery-3.3.1.min.js"></script>
<script>
	$(function(){
		init();
		
		var sw = screen.width;

	    var sh = screen.height;

	    var cw = document.body.clientWidth;

	    var ch = document.body.clientHeight;

	    var top  = sh / 2 - ch / 2 - 100;

	    var left = sw / 2 - cw / 2;

	    window.moveTo(left, top);
		$('#insertMessage').on('click', insertMessage);
		$('#usersearch').on('keyup', idCheck);
	})
	
	function init(){
		var userid = "<%=session.getAttribute("loginId") %>";
		$.ajax({
			url: 'selectAllMembers',
			type: 'post',
			data: {
				'id': userid
			},
			success: function(resp){
				options = '';
				for(var i in resp){
					options += '<option value="'+resp[i].id+'">'+resp[i].id+'</option>';
				}
				$('#userto').append(options);
			}
		});
	}
	
	function insertMessage(){
		var userid = "<%=session.getAttribute("loginId") %>";
		var password = "<%=session.getAttribute("loginPwd") %>";
		var title = $('#title').val();
		var userto = $('#userto option:selected').val();
		var content = $('#content').val();
		
		$.ajax({
			url: 'insertMessage',
			type: 'post',
			data: {
				'id': userid,
				'password': password,
				'title': title,
				'user_to': userto,
				'content': content
			},
			success: function(resp){
				
				if(resp == 1){
					opener.location.reload();
					window.close();
				}
			}
		});
	}
	
	function idCheck(){
		var userid = $('#usersearch').val().trim();
		
		$.ajax({
			url: 'idCheck',
			type: 'post',
			data: {
				id: userid
			},
			success: function(resp){
				
					if(resp == 'false'){
						$('#userto option').attr('selected', false);
						$('#userto option[value=all]').attr('selected','selected');
						$('#userto option[value='+userid+']').attr('selected','selected');
					} else{
						$('#userto option[value=all]').attr('selected','selected');
					}
				
			}
		});
	}
</script>
</head>
<body>
<div class="main">
	<div class="top">
	<a href="#" class="exit" onclick="javascript:window.close()"><i class="fas fa-times"></i></a>
	
	<p class="head">タイトル</p> <input id="title" type="text">
	<p class="head">TO</p><select id="userto"><option value="all">ALL</option></select><input id="usersearch" type="text" placeholder="直接入力">
	</div>
	<p class="naiyou">[ 内 容 ]</p>
	<div class="middle">
	<p><textarea id="content" rows="10" cols="70" maxlength="1000" ></textarea></p>
	</div>
	<input id="insertMessage" type="button" value="作 成">
</div>

</body>
</html>