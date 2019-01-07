<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="resources/script/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	init();
	$('#insertMessage').on('click', updateMessage);
	$('#usersearch').on('keyup', idCheck);
});

$.urlParam = function(name){
    var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(window.location.href);
    return results[1] || 0;
}

function init(){
	var userid = "<%=session.getAttribute("loginId") %>";
	var mno =  $.urlParam('mno');
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
	
	$.ajax({
		url: 'detailMessage',
		type: 'post',
		data: {
			'message_no': mno
		},
		success: function(resp){
			$('#title').val(resp.title);
			$('#content').val(resp.content);
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

function updateMessage(){
	var userid = "<%=session.getAttribute("loginId") %>";
	var password = "<%=session.getAttribute("loginPwd") %>";
	var title = $('#title').val();
	var userto = $('#userto option:selected').val();
	var content = $('#content').val();
	var mno =  $.urlParam('mno');
	if(title.length == 0 ){
		alert('제목을 입력해야 합니다.');
	}else if(content.length == 0){
		alert('내용을 입력해야 합니다.');
	}else{
		$.ajax({
			url: 'updateMessage',
			type: 'post',
			data: {
				'message_no': mno,
				'id': userid,
				'password': password,
				'title': title,
				'user_to': userto,
				'content': content
			},
			success: function(resp){
				
				if(resp == 1){
					opener.init();
					window.close();
				}
			}
		});
	}
}
</script>
</head>
<body>
<div>
	<p>제목 : <input id="title" type="text"></p>
	<p>to : <select id="userto"><option value="all">전체</option></select><input id="usersearch" type="text"></p>
	<p>내용</p>
	<p><textarea id="content" rows="10" cols="100" maxlength="1000" ></textarea></p>
	<input id="insertMessage" type="button" value="작성">
</div>
</body>
</html>