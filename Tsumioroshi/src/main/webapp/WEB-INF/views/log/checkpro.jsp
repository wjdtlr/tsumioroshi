<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/checkpro.css">
<script src="resources/script/jquery-3.3.1.min.js"></script>

<script>
	$(function(){
		$('#search').on('click', function(){
			check();
		});
	});
	
	function check(){
		var productname = $('#product_name').val();
		
		$.ajax({
			url: 'productCheck',
			type: 'post',
			data: {
				'product_Name': productname
			},
			success: function(resp){
				var result = '';
				
				for(var i in resp){
					result += '<p class="items">'+resp[i].product_Name+'<input class="check" type="button" value="선택" data-name="'+resp[i].product_Name+'"/></p>'
				}
				
				$('#result').html(result);
				
				$('.check').on('click', function(){
					var productname = $(this).attr('data-name');
					window.opener.init(productname);
					self.close();
				});
				
			}
		});
	}
</script>

</head>
<body>
<div class="search_top">
	<input type="text" id="product_name" /><input type="button" id="search" value=" 照 会 " /> 
</div>
<div class="main">
<div id="result">
</div>

</div>
</body>
</html>