<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/detailmsg.css">
<script src="resources/script/jquery-3.3.1.min.js"></script>
<style type="text/css">
</style>
<script>
$(function(){
	init();
});

$.urlParam = function(name){
    var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(window.location.href);
    return results[1] || 0;
}

function init(){
	var mno = $.urlParam('mno');
	var loginId = "<%=session.getAttribute("loginId")%>";

		$.ajax({
			url : 'detailMessage',
			type : 'post',
			data : {
				'message_no' : mno
			},
			success : function(resp) {
				
				$('#title').html(resp.title);
				$('#writer').html(resp.id);
				$('#to').html(resp.user_to);
				$('#regdate').html(resp.regdate);
				$('#content').html('<p>' + resp.content + '</p>');
				$('#confirm').html(resp.confirm);
				$('#confirmdate').html(resp.confirm_date);
				
				if(resp.confirm == null){
					if (loginId == resp.id) {
						$('#buttons').html('<input id="updateMessage" type="button" value="修　正"><input id="deleteMessage" type="button" value="削　除">');
						$('#updateMessage').on('click', function(){
							var mno =  $.urlParam('mno');
							window.open('updateMessage?mno='+mno,"","width=660px, height=503px");
						});
						$('#deleteMessage').on('click', function(){
							var mno =  $.urlParam('mno');
							var url = 'http://localhost:8888/tsumioroshi/deleteMessage?mno='+mno;
							$(location).attr('href', url);
						});
					}else{
						
						$('#buttons').html('<input id="confirmButton" type="button" value="確　認" >');
						$('#confirmButton').on('click', function(){
							var mno =  $.urlParam('mno');
							var url = 'http://localhost:8888/tsumioroshi/confirmMessage?mno='+mno;
							window.open('confirmMessage?mno='+mno, "", "width=325, height=200");
						});
						
					}
				}
			}
		});
	}

</script>
</head>
<body>
	<div id="main">
	
		<div class="top">
		<div class="top2">
			<a class="tit" > タイトル </a><a id="title"></a>
		</div>
			<!-- <p id="title"></p> -->
		<div>
			<a  class="wri"> 作 成 者 <span id="writer"></span></a>
		</div>
			<!-- <p id="writer"></p> -->
		<div>
			<a class="hito"> 受 け る 側 <span id="to"></span></a>
		</div>
			<!-- <p id="to"></p> -->
		</div>
	<div>
	<br/>
		<a  class="reg"> 作 成 し た 時 間 <span id="regdate"></span></a>
		<br/><br/>
		<!-- <p id="regdate"></p> -->
	<div class="kakunin">
		<p class="check"> 確 認 者 </p><p id="confirm"></p>
		<p class="checktime"> 確 認 時 間 </p><p id="confirmdate"></p>
	</div>
	</div>
	<br/>
			<a class="ny"> 内 容 </a>
		<div id="content"></div>
		
		<div id="buttons"></div>
		<a href="javascript:history.back()" class="back_bt" ><i class="fas fa-times" title=" 後 ろ に ! "></i></a>
	</div>
</body>
</html>