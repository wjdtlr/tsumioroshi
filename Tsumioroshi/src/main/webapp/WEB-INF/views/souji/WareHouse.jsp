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
<title>ThumiOroshi</title>
<script type="text/javascript" src="./resources/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="./resources/css/warehousestyle.css">
<script src="resources/js/warehousejs.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script>

<script type="text/javascript" src="./resources/js/interact.js"></script>
<script type="text/javascript" src="./resources/js/jquery.js"></script>
<script type="text/javascript" src="./resources/js/iutil.js"></script>
<script type="text/javascript" src="./resources/js/idrag.js"></script>

<script>
	
	

/* $("#txt_str").bind("keyup",function(){
	 re = /[~!@\#$%^&*\()\-=+_']/gi; 
	 var temp=$("#txt_str").val();
	 if(re.test(temp)){ //특수문자가 포함되면 삭제하여 값으로 다시셋팅
	 $("#txt_str").val(temp.replace(re,"")); } }); */

	 
	$(function() {
		init();
		
		$('.btsb').on('click', function() {
			createbox();
		});
		
		$('.btsb2').on('click', function(){
			updateBox();
		});
		
		$('.btsb3').on('click', function(){
			deleteBox();
		})
		
		$('#save_wa').on('click', function(){
			updateShelves();
		});
		
		$(".select2").bind("keyup",function(){
			 re = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi
			 var temp=$(".select2").val();
			 if(re.test(temp)){ //특수문자가 포함되면 삭제하여 값으로 다시셋팅
			 $(".select2").val(temp.replace(re,"")); } });
		
	});

	function createbox() {
		var boxname = $('#shelfname').val();
		var result = '';
		var width = $('#wid').val();
		var height = $('#hei').val();
		var size = width+'px:' + height+'px';
		if(boxname.length <=0 || boxname.length > 10){
			alert("선반이름은 최소 1 글자 이상 최대 10 글자 이하여야 합니다.");
		}else if(width < 10 || height < 10){
			alert('가로, 세로 10px 이상이어야 합니다.')
		}else{
		
			result += '<div id="'+boxname+'" class="dropaccept" style=" height:'+height+' width:"'+width+'" data-name="'+boxname+'">'+ boxname + '</div>';
			$.ajax({
				url: 'selectShelf',
				type: 'post',
				data: {
					'shelf_Name': boxname
				},
				success: function(resp){
					if(resp == 0){
						
						$.ajax({
							url:'insertSelves',
							type:'post',
							data:{
								'shelf_Name': boxname,
								'shelf_Size': size,
								'shelf_Location': '',
								'shelf_Condition': ''
							},
							success: function(resp){
								if(resp == 1){
									/* alert(boxname); */
									$('.up').append(result);
									$('#'+boxname).css('height', height);
									$('#'+boxname).css('width', width);
									$('#' + boxname).Draggable();
									getBox();
								}else{
									alert('선반 생성에 실패 했습니다.');
								}
							}
						});
					}else{
						alert("이미 존재하는 선반명입니다");
					}
				}
			});
		}
	}
	
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
					
					$('.up').append(result);
					$('#'+boxname).css('height', size[1]);
					$('#'+boxname).css('width', size[0]);
					$('#'+boxname).css('left', location[0]);
					$('#'+boxname).css('top', location[1]);
					
					$('#' + boxname).Draggable();	
				}
				getBox();
			}
		});
	}
	
	function getBox(){
		
		$('.dropaccept').on('mousedown', function(){
			var shelf = $(this); 
			var shelfname = $('#shelfname');
			var wid = $('#wid');
			var hei = $('#hei');
			
			shelfname.prop('readonly', true);
			shelfname.val(shelf.attr('id'));
			wid.val(shelf.css('width'));
			hei.val(shelf.css('height'));
		});
	}
	
	function updateBox(){
		
		var shelfname = $('#shelfname');
		var wid = $('#wid');
		var hei = $('#hei');
		var shelf = $('#'+shelfname.val());
		shelf.css('width', wid.val());
		shelf.css('height', hei.val());
		shelfname.prop('readonly', false);
		shelfname.val('');
		wid.val('');
		hei.val('');
		
	}
	
	function deleteBox(){
		var shelfname = $('#shelfname').val();
		
		$.ajax({
			url: 'deleteBox',
			type: 'post',
			data: {
				'shelfname': shelfname
			},
			success: function(resp){
				if(resp == 1){
					window.location.reload();
				}
			}
		})
		
	}
	
	function updateShelves(){
		var shelves = $('.dropaccept');
		var data = [];
		
		for(var i=0; i<shelves.length; i++){
			var name = shelves.eq(i).attr('data-name');
			var size = shelves.eq(i).css("width")+':'+shelves.eq(i).css("height");
			var location = shelves.eq(i).css("left")+':'+shelves.eq(i).css("top");
			
			var shelf = {
					"shelf_Name": name,
					"shelf_Size": size,
					"shelf_Location": location
			};
			data.push(shelf);
		}
		
		 $.ajax({
			url: 'updateShelves',
			type: 'post',
			data: {'data': JSON.stringify(data)},
			success: function(resp){
				alert('성공'	);
			}
		});
		
	}

	function allowDrop(ev) {
		ev.preventDefault();
	}

	function drag(ev) {
		ev.dataTransfer.setData("text", ev.target.id);
	}

	function drop(ev) {
		ev.preventDefault();
		var data = ev.dataTransfer.getData("text");
		ev.target.appendChild(document.getElementById(data));
		ev.preventDefault();
	}
	
	
	
	</script>

</head>
<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<!-- background -->
	<div id="all"></div>
	<!-- background -->
	
	<!-- title -->
	<div id="title">
	<div>
		<h1 id="rt"><a href="main">Warehouse Placement</a></h1>
		<!-- Warehouse Placement -->
	</div>
	
	<div>
		<img id="save_wa" src="./images/save_bt_wa.png" onmouseover="this.src='./images/save_bt_wa_hv.png';"
			onmouseout="this.src='./images/save_bt_wa.png';"/>
	</div>
	
	</div>
	
	
	<div id="sub">
	<div id="sub_inner">
	<div id="sub_inner_left">
	

	</div>
	
	<div id="sub_inner_right">
	
	</div>
	
	</div>
	</div>
	
	<!-- main -->
	<div id="parentElem" class="main">
    
    
		
	<div id="container" class="maleft" ondrop="drop(event)" ondragover="allowDrop(event)">
	 <div id="drawing"></div>
	 
	 

	
	
    	
   </div>
	 
	
	
	<div id="maright" ondrop="drop(event)" ondragover="allowDrop(event)">


			<div class="up">

				
				<!-- <div id="info"></div> -->


				<!-- <div id="drag" class="dropaccept"><span id="info">example</span></div> -->

			<!-- <script type="text/javascript">
				$(document).ready(function() {
					$('#drag').Draggable();
				});
			</script>
			

			<script  type="text/javascript">
				var client_id = 1;
			</script> -->
			</div>

			<!-- <script type="text/javascript">
				$(document).ready(function() {
					$('#drag1').Draggable({
						/* snapDistance : 10,
						frameClass : 'frameClass' */
					});
				});
			</script>
			<script language="JavaScript" type="text/javascript">
				var client_id = 1;
			</script> -->


			<div class="ip">
			 <div class="ip2">
				<div>
					<p>선 반 이 름</p>
				</div>

				<input type="text" id="shelfname" class="select2"  style="width: 50px;">
				
				<div>
					<p> 가 로 </p>
				</div>

				<input type="text" id="wid" class="select2" style="width: 40px;">
				
				<div>
					<p> 세 로 </p>
				</div>

				<input type="text" id="hei" class="select2" style="width: 40px;">
				
			</div>
			<div class="ip3">
				<input type="button" class="btsb" value="생성" >
				<input type="button" class="btsb2" value="수정">
				<input type="button" class="btsb3" value="삭제">
			</div>
			
			</div>

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