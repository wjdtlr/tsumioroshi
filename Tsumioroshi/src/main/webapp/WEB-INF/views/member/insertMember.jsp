<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Create</title>
<script src="resources/script/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="./resources/css/insertMember.css">
<link href="https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300" rel="stylesheet">
<script>
	$(function(){
		$('#userid').on('keyup', idCheck);
		$('#create').on('click', insertMember);
		
	});
	
	function idCheck(){
		var userid = $('#userid').val().trim();
		
		if(userid.length <= 3 || userid.length > 20){
			$('.resulttext').html('<br/><span class="marg" style="color:red;">아이디는 4자리 이상 20자리 이하만 사용 가능 합니다</span>');
		}else{
			$.ajax({
				url: 'idCheck',
				type: 'post',
				data: {
					id: userid
				},
				success: function(resp){
					if(resp == 'true'){
						$('.resulttext').html('<br/><span class="marg" style="color:green;">사용 가능 합니다</span>');
					}
					if(resp == 'false'){
						$('.resulttext').html('<br/><span class="marg" style="color:red;">사용 불가능 합니다</span>');
					}
				}
			});
		}
	}
	
	function insertMember(){
		var userid = $('#userid').val().trim();
		var userpwd = $('#userpwd').val().trim();
		var userauth = $('#userauth').val();
		
		if(userpwd.length < 3 || userpwd.length > 20 ){
			alert('password는 4~20 자리만 가능합니다');
			$('#userpwd').select();
		}else if(userid.length > 3 || userid.length <= 20){
			$.ajax({
				url: 'idCheck',
				type: 'post',
				data: {
					id: userid
				},
				success: function(resp){
					if(resp == 'true'){
						$.ajax({
							url: 'insertMember',
							type: 'post',
							data: {
								id: userid,
								password: userpwd,
								authority: userauth
							},
							success: function(resp){
								if(resp == 1){
									$('#userid').val('');
									$('#userpwd').val('');
								}
								window.opener.location.reload();
								window.close();
							}
						});
					}
					if(resp == 'false'){
						alert('사용 불가능한 아이디 입니다');
						$('#userid').select();
					}
				}
			});
		}
	}
	

	
	
</script>


</head>
<body>
<form class="main">
	<h4>관&nbsp; 리&nbsp; 자&nbsp; 생&nbsp; 성&nbsp;</h4>
	<div>
	<p>I&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D <br/>
	<input class="ipt2" type="text" id="userid" ><br/>
	<span class="resulttext"></span><br/>
	</p>
	</div>
	<p class="yuhyo">P A S S W O R D <br/> <input class="ipt" type="text" id="userpwd" > </p>
	<p class="bot">A U T H O R I T Y <br/> <select id="userauth">
		<option value="OfficeWork">사무관리자</option>
		<option value="WareHouse">창고관리자</option>
		</select></p>
		<input id="create" type="button" value="CREATE">
</form>
</body>

		<!-- <script type="text/javascript">
			window.opener.location.reload();
		</script> -->

</html>