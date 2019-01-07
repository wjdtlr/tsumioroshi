<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width = device-width, initial-scale = 1.0, user-scalable = no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>ThumiOroshiView</title>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="./resources/css/Viewstyle.css">



<script>
$(function(){
	init();
	$('.send_bt').on('click', function(){
		search();
	});
});

function init(){
	
	$.ajax({
		url:'selectAllShelves',
		type: 'post',
		success: function(resp){
			
			for(var i in resp){
				var boxname = resp[i].shelf_Name;
				var size =  resp[i].shelf_Size.split(':');
				var location = resp[i].shelf_Location.split(':');
				
				var result = '<div id="'+boxname+'" class="dropaccept" style=" height:'+size[1]+' width:"'+size[0]+'" data-name="'+boxname+'">'+ boxname + '</div>';
				
				$('#drawing').append(result);
				$('#'+boxname).css('height', size[1]);
				$('#'+boxname).css('width', size[0]);
				$('#'+boxname).css('left', location[0]);
				$('#'+boxname).css('top', location[1]);
			}
			
			$('.dropaccept').on('click', function(){
				var sname = $(this).attr('data-name');
				viewShelf(sname);
			});
			
		}
	});
	
	$.ajax({
		url:'selectSecond',
		type: 'post',
		success: function(resp){
			result = '';
			for(var i in resp){
				result += '<option value="'+resp[i].sc_name+'">'+resp[i].sc_name+'</option>';
			}
			$('#items').append(result);
		}
	})
}

function viewShelf(sname){
	 
	$.ajax({
		url: 'viewShelf',
		type: 'post',
		data: {
			'shelf': sname
		},
		success: function(resp){
			var result ='';
			result += '<table id="shelfview">';
			result += '<tr> <th>제품명</th> <th>제품번호</th> <th>유통기한</th> <th>입고일</th> </tr>';
			if(resp.length != 0){
				for(var i in resp){
					result += '<tr class="clickable" data-tag="'+resp[i].tag_Number+'">';
					result += '<td>'+resp[i].product_Name+'</td><td>'+resp[i].product_Number+'</td>';
					if(resp[i].expiration_Date == null){
						result += '<td>유통기한 없음</td><td>'+resp[i].stock_Date+'</td>';
					}else{
						result += '<td>'+resp[i].expiration_Date+'</td><td>'+resp[i].stock_Date+'</td>';
					}
					result += '</tr>';
				}
			}else{
				result += '<tr><td colspan="4">물품이 없습니다</td></tr>'
			}
			$('#maright').html(result);
		}
	});
}

function search(){
	var condition = $('#conditions option:selected').val();
	var date = $('#date').val();
	var keyword = $('#keyword').val();
	if(condition == 'pname'){
			$.ajax({
				url:'searchProductName',
				type:'post',
				data: {
					'pname': keyword,
					'date' : date
				},
				success: function(resp){
					var result ='';
					result += '<table id="shelfview">';
					result += '<tr> <th>제품명</th> <th>제품번호</th> <th>유통기한</th> <th>입고일</th> <th>위치</th> </tr>';
					if(resp.length != 0){
						for(var i in resp){
							result += '<tr class="clickable" data-tag="'+resp[i].tag_Number+'">';
							result += '<td>'+resp[i].product_Name+'</td><td>'+resp[i].product_Number+'</td>';
							if(resp[i].expiration_Date == null){
								result += '<td>유통기한 없음</td><td>'+resp[i].stock_Date+'</td><td>'+resp[i].product_Location+'</td>';
							}else{
								result += '<td>'+resp[i].expiration_Date+'</td><td>'+resp[i].stock_Date+'</td><td>'+resp[i].product_Location+'</td>';
							}
							result += '</tr>';
						}
					}else{
						result += '<tr><td colspan="4">물품이 없습니다</td></tr>'
					}
					$('#maright').html(result);
				}
				
			});
	}
		
	/* if(condition == 'tag'){
		$.ajax({
			url: 'searchProductTag',
			type: 'post',
			data: {
				'tag' : 
			}
		});
	} */
		
	if(condition == 'pnumber'){
		$.ajax({
			url: 'searchProductNumber',
			type: 'post',
			data: {
				'pnumber': keyword
			},
			success: function(resp){
				var result ='';
				result += '<table id="shelfview">';
				result += '<tr> <th>제품명</th> <th>제품번호</th> <th>유통기한</th> <th>입고일</th> <th>위치</th> </tr>';
				if(resp.length != 0){
					for(var i in resp){
						result += '<tr class="clickable" data-tag="'+resp[i].tag_Number+'">';
						result += '<td>'+resp[i].product_Name+'</td><td>'+resp[i].product_Number+'</td>';
						if(resp[i].expiration_Date == null){
							result += '<td>유통기한 없음</td><td>'+resp[i].stock_Date+'</td><td>'+resp[i].product_Location+'</td>';
						}else{
							result += '<td>'+resp[i].expiration_Date+'</td><td>'+resp[i].stock_Date+'</td><td>'+resp[i].product_Location+'</td>';
						}
						result += '</tr>';
					}
				}else{
					result += '<tr><td colspan="4">물품이 없습니다</td></tr>'
				}
				$('#maright').html(result);
			}
		});
	} 
}

</script>

</head>
<body>
	
	<!-- title -->
	<div id="title">
	<div>
		<h1 id="rt"><a href="main">Warehouse View</a></h1>
		<!-- Warehouse Placement -->
	</div>
	
	<div>
	</div>
	
	</div>
	
	
	<div id="sub">
	<div id="sub_inner">
	<div id="sub_inner_left">
	<!-- <div class="object">
	<div>
		<p>품 목</p>
	</div>
	<select id="items" class="select1">
		<option value="null"></option>
	</select>
	</div> -->
	
	<div class="object">
	<div>
		<p>조 건</p>
	</div>
	<select id="conditions" class="select1">
		<option value="pname">제품명</option>
		<option value="pnumber">제품번호</option>
		<!-- <option value="tag">tag번호</option> -->
	</select>
	</div>
	
	
	
	<div class="object">
	<div>
		<p>입 고 일</p>
	</div>
		
	<input type="date" class="select1" id="date">
		
	</div>
	
	
	<div class="object">
	<div>
		<p>입 력</p>
	</div>
	
	<input id="keyword" type="text" class="select1">
	
	</div>
	
	
	<div>
	<input type="button" class="send_bt" value="S e a r c h">
	</div>

	</div>
	
	<div id="sub_inner_right">
	
	</div>
	
	</div>
	</div>
	
	<!-- main -->
	<div id="parentElem" class="main">
    
    
		
	<div id="container" class="maleft">
	 <div id="drawing"></div>
	 
	 

	
	
    	
   </div>
	 
	
	
	<div id="maright">
		


	</div><!-- maright -->
	

	</div><!-- main -->
	
	
	<!-- 하단 -->
	<div class="bottom">
	<footer id="footer">
	<div>
	
	</div>

	<div id="copy">
	Copyrightⓒ 2018 by SCIT35B07. All pictures cannot be copied without permission. 
	</div>
	</footer>
	</div>

	

	
</body>

</html>