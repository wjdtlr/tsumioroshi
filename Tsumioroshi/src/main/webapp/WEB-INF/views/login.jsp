<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project</title>
<link rel="stylesheet" type="text/css" href="./resources/css/loginstyle.css">
<style rel="stylesheet">

</style>
</head>
<body>

	<section class="container">
		<article class="half">
			<h1>LTSB</h1>
			<div class="tabs">
				<span class="tab slave active"><a href="#">slave</a></span>
				<span class="tab master"><a href="#">master</a></span>
			</div>
			<div class="content">
				<div class="slave cont">
					<form action="login" method="post">
						<input type="text" name="id" id="userid" class="inpt" required="required" placeholder="아이디">
						<input type="password" name="password" id="password" class="inpt" required="required" placeholder="비밀번호">
						<div class="submit-wrap">
							<input type="submit" value="LOGIN" class="submit">
						</div>
					</form>
				</div>
				<div class="master cont">
					<form action="login" method="post">
						<input type="text" name="id" id="userid2" class="inpt" required="required" placeholder="아이디">
						<input type="password" name="password" id="password2" class="inpt" required="required" placeholder="비밀번호">
						<input type="password" name="masterpw" id="matserpw" class="inpt" required="required" placeholder="2차 비밀번호">
						 <div class="submit-wrap"> 
							<input type="submit" value="LOGIN" class="submit">
						 </div>
					</form>
				</div>
			</div>
		</article>
		<div class="half bg"></div>
	</section>



	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script type="text/javascript">
		$('.tabs .tab').click(function() {
			if ($(this).hasClass('slave')) {
				$('.tabs .tab').removeClass('active');
				$(this).addClass('active');
				$('.cont').hide();
				$('.slave').show();
			}
			if ($(this).hasClass('master')) {
				$('.tabs .tab').removeClass('active');
				$(this).addClass('active');
				$('.cont').hide();
				$('.master').show();
			}
		});
		$('.container .bg').mousemove(
				function(e) {
					var amountMovedX = (e.pageX * -1 / 25);
					var amountMovedY = (e.pageY * -1 / 300);
					$(this).css('background-position', amountMovedX + 'px ' + amountMovedY + 'px');
				});
	</script>
</body>
</html>
