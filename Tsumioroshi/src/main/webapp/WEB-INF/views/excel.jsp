<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/excel.css">
<script type="text/javascript" src="resources/script/jquery-3.3.1.min.js"></script>
<script>
	$(function(){
		$('#btn').click(function(){
			$.ajax({
				url:'excel',
				method:'post',
				success:function(resp){
					window.opener.alert("저장되었습니다.");
					window.close();
				}
			})
		})
	})
</script>
</head>
<body>
<div class="main">
	<input type="button" id="btn" value="버튼을눌러excel을다운로드하세요" title="D드라이브에저장됩니다."/>
</div>
</body>
</html>