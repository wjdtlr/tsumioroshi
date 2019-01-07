<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title><link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/message.css">
<style type="text/css">
</style>
<script src="resources/script/jquery-3.3.1.min.js"></script>
<script>
	$(function(){
		var userto = "<%=session.getAttribute("loginId")%>";
		
		init(1, 'all' , '');
		
		pageCount('all', '');
		
		$('#write').on('click', writer);
		
		$('#all').on('click', function(){
			init(1, 'all', '');
		});
		$('#myrece').on('click', function(){
			init(1, userto, '');
		});
		$('#mysend').on('click', function(){
			init(1, '', userto);
		})
	})
	
	$.urlParam = function(name){
    var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(window.location.href);
    return results[1] || 0;
	}
	
	function init(page, userto, id){
		
		page *= 1;
		$.ajax({
			url : 'selectTen',
			type: 'post',
			data: {
				'currPage': page,
				'userto': userto,
				'id': id
			},
			success: function(resp){
				
				listup(resp);
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}
		});
		
	}
	
	function listup(resp){
		var result='';
		
		$('#listMessage').html('<tr><th id="nosect">No</th> <th id="titlesect">Title</th> <th id="writersect">Writer</th> <th id="datesect">Date</th> <th id="confirmsect">Confirmed</th></tr>');
		
		if(resp.length == 0){
			result += '<tr><td colspan="5" style="text-align : center">메시지가 없습니다</td></tr>'
		}else{
			for(var i in resp){
				result += '<tr>';
				result += '<td>'+resp[i].message_no+'</td>';
				result += '<td class="title" data-mno="'+resp[i].message_no+'">'+resp[i].title+'</td>';
				result += '<td>'+resp[i].id+'</td>';
				result += '<td>'+resp[i].regdate+'</td>';
				if(resp[i].confirm == null){
					result += '<td>미확인</td>';
				}else {
					result += '<td>'+resp[i].confirm+'</td>';
				}
				result +='</tr>'
			}
		}
			
			$('#listMessage').append(result);
			$('.title').on('click', function(){
				var url = 'detailMessage?mno='+$(this).attr('data-mno')
				$(location).attr('href', url);
				/* window.open('detailMessage?mno='+$(this).attr('data-mno')); */
			});
	}
	
	function pageCount(userto, id){
		$.ajax({
			url: 'pageCount',
			type: 'post',
			data: {
				'userto': userto,
				'id': id
			},
			success: function(resp){
				var result = '';
				if(resp == 0){
					result += '<div class="pages" value="1"><a>(1)</a></div>';
				}else{
					for(var i = 1; i<=resp; i++ ){
						result += '<div class="pages" value="'+i+'" ><a>('+i+')</a></div>';
					}
				}
				$('#page').html(result);
				
				$('.pages').on('click', function(){
					var page = $(this).attr('value');
					init(page, userto, id);
				});
			}
		});
	}
	
	function writer(){
		window.open("insertMessage", "", "width=650, height=400");
	}
</script>
</head>
<body>
<p id="currpage"></p>
<div class="top">
<div class="menu">
<div class="item">
<input id="all" type="button" value="전체메시지"> 
<input id="myrece" type="button" value="받은메시지">
<input id="mysend" type="button" value="보낸메시지">
<a href="#" class="exit" onclick="javascript:window.close()" style="width: 100px;"><i class="fas fa-times"></i></a>
</div>
</div>
</div>
<hr class="sen" />
<div class="main">
	<table id="listMessage">
		<tr class="menu2">
			<th id="nosect" style="width: 70px;">No</th> 
			<th id="titlesect" style="width: 250px;">Title</th> 
			<th id="writersect" style="width: 200px;">Writer</th> 
			<th id="datesect" style="width: 200px;">Date</th> 
			<th id="confirmsect" style="width: 100px;">Confirmed</th>
		</tr>
	</table>
	</div>
	
<hr class="sen" />
	
<div class="pa">
<div id="page"></div>
</div>

<hr class="sen" />

<div>
<p><input id="write" type="button" value="글쓰기" ></p>
</div>

</body>
</html>