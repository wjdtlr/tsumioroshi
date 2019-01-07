<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/confirmMessage.css">
<script src="resources/script/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	var sw = screen.width;

    var sh = screen.height;

    var cw = document.body.clientWidth;

    var ch = document.body.clientHeight;

    var top  = sh / 2 - ch / 2 - 100;

    var left = sw / 2 - cw / 2;

    window.moveTo(left, top);
	$('#confirmMessage').on('click', confirmMessage);
});

$.urlParam = function(name){
    var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(window.location.href);
    return results[1] || 0;
}

function confirmMessage(){
	var mno = $.urlParam('mno');
	var id = $('#confirm').val();
	var password = $('#confirmpwd').val();
	
	$.ajax({
		url: 'confirmMessage',
		type: 'post',
		data: {
			'message_no': mno,
			'confirm': id
		},
		success: function(resp){
			opener.init();
			window.close();
		}
	})
	
}

function idCheck(){
	var userid = $('#confirm').val().trim();
	
	$.ajax({
		url: 'idCheck',
		type: 'post',
		data: {
			id: userid
		},
		success: function(resp){
			if(resp == 'false'){
				confirmMessage();
			}else{
				alert("아이디가 존재 하지 않습니다.");
			}
		}
	});
}
	
</script>
</head>
<body>

	<div class="main">
		<br/><p class="kakuninsya"> 確 認 者 </p><input id="confirm" type="text">
		<p class="ango"> パ ス ワ ー ド <br/></p><input id="confirmpwd" type="password"><br/><br/>
		<input id="confirmMessage" type="button" value="　確　認　">
	</div>
</body>
</html>