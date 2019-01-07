<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WareHouse manager System</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/mainstyle.css">
<script type="text/javascript" src="./resources/jquery-3.3.1.min.js"></script>
<script src="//code.jquery.com/jquery.min.js"></script>

<script>

	
$(document).ready(function(){

	  $(window).load( function() {
	   /* 메뉴버튼을 눌렀을때, 오버레이부분을 클릭했을때*/
	    $(".ninja-btn, .panel-overlay").click( function() {
	      $(".ninja-btn, .panel-overlay, .panel").toggleClass("active"); //해당 영역에 toggleClass를 넣음 왔다리갔다리
	      /* panel overlay가 활성화 되어있는지를 체크 */
	      if ($(".panel-overlay").hasClass("active")) {
	        $(".panel-overlay").fadeIn();
	      } else {
	        $(".panel-overlay").fadeOut();
	      }
	    });

	  });

	})

	$(".hover").mouseleave(
		  function () {
		    $(this).removeClass("hover");
		  }
		);
		
		
$(document).ready(function(){
    var imgs;
    var img_count;
    var img_position = 1;

    imgs = $(".slide ul");
    img_count = imgs.children().length;

    //버튼을 클릭했을 때 함수 실행
    $('#back').click(function () {
      back();
    });
    $('#next').click(function () {
      next();
    });

    function back() {
      if(1<img_position){
        imgs.animate({
          left:'+=950px'
        });
        img_position--;
      }
    }
    function next() {
      if(img_count>img_position){
        imgs.animate({
          left:'-=950px'
        });
        img_position++;
      }
    }


    //이미지 끝까지 가면 버튼 사라지기

	
		 window.setInterval(tick, 1000);
    //첫 이미지로 돌아오기

    function tick(){ 
    	var month,date,hours,minutes, seconds, ap; 
    	var intDate,intMon,intHours,intMinutes,intSeconds; 
    	var today=new Date();   
    	intDate = today.getDate(); 
    	intMon = today.getMonth()+1; 
    	intHours = today.getHours(); 
    	intMinutes = today.getMinutes(); 
    	intSeconds = today.getSeconds();   
    	if(intMon < 10){ month = "0" + intMon; }  
    	else { month = intMon; } 
    	if(intDate < 10){ date = "0" + intDate; }  
    	else { date = intDate; } 
    	if (intHours == 0) { hours = "12:"; ap = "AM "; }

    	else if (intHours < 12) { hours = intHours + ":"; ap = "AM "; }  
    	else { intHours = (intHours - 12); hours = intHours + ":"; ap = "PM "; } 
    	if (intMinutes < 10){ minutes = "0" + intMinutes + ":"; } 
    	else{ minutes = intMinutes + ":"; } 
    	if (intSeconds < 10){ seconds = "0" + intSeconds; } 
    	else{ seconds = intSeconds; }   
    	document.getElementById("clock").innerHTML = ap+ hours + minutes + seconds   
    	}
    	window.onload=tick

  });

    	/* window.setTimeout("tick()",1000);  */
    	
    	
/*시계*/   
    window.onload = function(){
	checkTime();
	var now = document.getElementById("now");
	setInterval(checkTime, 1000);
}

    function checkTime(){
    	var today = new Date();
    	var date = today.getDate();
    	var hour = today.getHours();
    	var minute = today.getMinutes();
    	var second = today.getSeconds();
    	var day = today.getDay();
    	var days = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
     	
    	var crrt = date+"일, " + days[day]+", "+hour+"시, "+minute + "분, " + second+"초";
    	if(minute == 48 && second == 00){
    		alert('쉬어라');
    	}
    	now.innerHTML = crrt;
    }

    window.onload = function(){
    	updateTime();
    	setInterval(updateTime, 1000);	
    }

    var weeks = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

    function updateTime() {
    	var dateForm = document.getElementById("date"); 
    	var timeForm = document.getElementById("time"); 
        var cd = new Date();
        var hour = zeroPadding(cd.getHours(), 2);
        var minute = zeroPadding(cd.getMinutes(), 2);
        var second = zeroPadding(cd.getSeconds(), 2);
        timeForm.innerHTML = hour + ":" + minute + ":" + second;
        var year = zeroPadding(cd.getFullYear(), 4);
        var month = zeroPadding(cd.getMonth()+1, 2);
        var date = zeroPadding(cd.getDate(), 2);
        var week = weeks[cd.getDay()];
        dateForm.innerHTML = year + "-" + month + "-" + date + "-" + week;
    };

    function zeroPadding(num, digit) {
        var zero = '';
        for(var i = 0; i < digit; i++) {	
            zero += '0';
        }
        return (zero + num).slice(-digit);
    }

/*시계 끝*/
 
 
/*서브메뉴 슬라이드*/
$(document).ready(function(){ 
	$(".menu>a").click(function(){
	 var submenu = $(this).next("ul");
	  if( submenu.is(":visible") ){ 
	  submenu.slideUp();
	  }else{
	   submenu.slideDown();
	  }
	 });
	});
/*서브메뉴 슬라이드*/

/* function popup() {
        window.open("./member/memberMenu", 'window', 'width=600,height=400');
    } */
 
</script>

<style type="text/css">
@font-face {font-family:"Cflcd"; src:url("./resources/CF LCD 521 Regular.ttf") format("truetype");}
@font-face {font-family:"subwt"; src:url("./resources/SUBWT___.ttf") format("truetype");}

	 .slide{
        width: 950px;
        height: 300px;
        overflow: hidden;
        position: relative;
        margin: 0 auto;
      }
      .slide ul{
        width: 5000px;
        position: absolute;
        top:0;
        left:0;
        font-size: 0;
      }
      .slide ul li{
        display: inline-block;
      }
      #back{
        position: absolute;
        top: 250px;
        left: 0;
        cursor: pointer;
        z-index: 1;
      }
      #next{
        position: absolute;
        top: 250px;
        right: 0;
        cursor: pointer;
        z-index: 1;
      }
 
    .clock{
	position: absolute;
	margin-top : 60px;
	margin-left: 30px; 
	}

	.clock {
	font-family : subwt;
	font-size : 130px;
	width:1000px;
    -webkit-border-radius:10px;
    text-shadow: 0 0 20px rgba(255, 0, 71, 0.23),  0 0 20px rgba(211, 5, 138, 0.14);
    color:#ffffff;
    }
            
      
	
	.zeta-menu .item ul {
		display : none;
	}
	
	.zeta-menu ul {
  		display: none;
  		padding: 0;
  		left: 0;
  		top: 100%;
	}
	
	.secondmenu{
		height: 20px;
		font-size: 15px;
		text-align: center;
		background-color: #0A122A;
	}
</style>
</head>
<body>

	
	<!-- background -->
	<div id="background"></div>
	<!-- background -->
	<!-- 하단 -->
	
	
	<div id="full">
	
	
	
	
	<!-- 상단 -->
	<div id="top">
	
	
	<!-- menu -->
	<div id="menuall">
				<div id="menu">
					<div class="panel left">
						
						<a class="ninja-btn" title="menu"><span></span></a>
						<!-- 메뉴의 내용부분 -->
						<span class="mo-menu-title">MENU</span>

							<div class="profile">
								<div class="welcom">
									<c:if test="${sessionScope.loginId  != null}">
										<a><span style="color: red;">${sessionScope.loginId}</span>님 환영합니다.</a>
									</c:if>
								</div>
							</div>
							
							
							
							<c:if test="${sessionScope.authority == 'Master'}">
								
								<ul>
									
									<!-- 계정생성 -->
									<li class="menu-label">
									<a href="javascript:void(window.open('memberMenu', 'Member','width=650px, height=300px'))" 
									class="listitem" ><i class="fas fa-id-card"></i>&nbsp&nbsp&nbsp 계 정 생 성</a>
									<!-- "javascript:void(window.open('./member/memberMenu', 'create','width=800px, height=800px'))" -->
									</li>
									
									<!-- 창고배치 -->
									<li class="menu-label menu">
									<a href="#" class="listitem"><i class="fas fa-warehouse"></i>&nbsp&nbsp&nbsp 창 고 현 황</a>
									 <!-- 서브 메뉴 -->
									<ul class="hide">
       			 						<li class="secondmenu">
       						 				<a href="WareHouse" class="submenu">[창고 배치 및 수정]</a>
       			 						</li>
       			 						
       			 						<li class="secondmenu">
       						 				<a href="WareHouseView" class="submenu">[창 고 현 황 확 인]</a>
       			 						</li>
									</ul>
									</li>
									
									<!-- 상품등록 및 삭제 -->
									<!-- <li class="menu-label menu">
									<a href="#" class="listitem"><i class="fas fa-edit"></i>&nbsp&nbsp&nbsp 등 록 및 삭 제</a>
									
									 서브 메뉴
									<ul class="hide">
       			 						<li class="secondmenu">
       									 	<a href="#" class="submenu">[ 상 품 등 록 ]</a>
       			 						</li>
       			 						
       			 						<li class="secondmenu">
       						 				<a href="#" class="submenu">[ 상 품 삭 제 ]</a>
       			 						</li>
       								</ul>
									
									</li> -->
									
									<!-- 상품주문 및 발주 -->
									<li class="menu-label menu">
									<a href="#" class="listitem"><i class="fas fa-edit"></i>&nbsp&nbsp&nbsp 주 문 및 발 주</a>
									 <!-- 서브 메뉴 -->
									<ul class="hide">
       			 						<li class="secondmenu">
       									 	<a href="javascript:void(window.open('stock_Log_Form_1','入', 'width=650px, height=520px'))" class="submenu">[입고 요청]</a>
       			 						</li>
       			 						<li class="secondmenu">
       						 				<a href="javascript:void(window.open('release_Log_Form_1','入', 'width=650px, height=520px'))" class="submenu">[출고 요청]</a>
       			 						</li>
       			 						
       			 						<li class="secondmenu">
       						 				<a href="javascript:void(window.open('select_Every_Stock_Log','出', 'width=650px, height=520px'))" class="submenu">[입고 요청 기록]</a>
       			 						</li>
       			 						
       			 						<li class="secondmenu">
       						 				<a href="javascript:void(window.open('select_Every_Release_Log','出', 'width=650px, height=520px'))" class="submenu">[출고 요청 기록]</a>
       			 						</li>
       			 						
       			 						<!-- <li class="secondmenu">
       						 				<a href="#" class="submenu">[추후 작업합니다]</a>
       			 						</li> --> 
       								</ul>
									
									</li>
									
									<!-- 재고관리 -->
									<li class="menu-label menu">
									<a href="#" class="listitem"><i class="fas fa-th"></i>&nbsp&nbsp&nbsp 재 고 관 리</a>
									 <!-- 서브 메뉴 -->
									<ul class="hide">
       			 						<li class="secondmenu">
       						 				<a href="javascript:void(window.open('search','search', 'width=1250px, height=500px'))" class="submenu">[물품조회]</a>
       			 						</li>
       			 						<li class="secondmenu">
       						 				<a href="javascript:void(window.open('excel','excel', 'width=360px, height=200px'))" class="submenu">[엑셀]</a>
       			 						</li>
       								</ul>
									
									</li>
									
									<!-- 카테고리 관리 -->
									<li class="menu-label">
									<a href="javascript:void(window.open('categories', 'categories','width=1090px, height=370px'))"
										class="listitem"><i class="fas fa-edit"></i>&nbsp&nbsp&nbsp 카테고리 관리</a>
									</li>
									
									<!-- 문의 -->
									<li class="menu-label">
									<a href="javascript:void(window.open('listMessage', 'Message','width=720px, height=550px'))" class="listitem"><i class="far fa-question-circle"></i>&nbsp&nbsp&nbsp 문 의</a>
									</li>
								
								</ul>
								
							</c:if>
							
							
							
							<c:if test="${sessionScope.authority == 'OfficeWork'}">
								<ul>
									<!-- 상품주문 및 발주 -->
									<li class="menu-label menu">
									<a href="#" class="listitem"><i class="fas fa-edit"></i>&nbsp&nbsp&nbsp [주 문 및 발 주]</a>
									 <!-- 서브 메뉴 -->
									<ul class="hide">
       			 						<li class="secondmenu">
       									 	<a href="javascript:void(window.open('stock_Log_Form_1','入', 'width=650px, height=520px'))" class="submenu">[입고 요청]</a>
       			 						</li>
       			 						<li class="secondmenu">
       						 				<a href="javascript:void(window.open('release_Log_Form_1','入', 'width=650px, height=520px'))" class="submenu">[출고 요청]</a>
       			 						</li>
       			 						
       			 						<li class="secondmenu">
       						 				<a href="javascript:void(window.open('select_Every_Stock_Log','出', 'width=650px, height=520px'))" class="submenu">[입고 요청 기록]</a>
       			 						</li>
       			 						
       			 						<li class="secondmenu">
       						 				<a href="javascript:void(window.open('select_Every_Release_Log','出', 'width=650px, height=520px'))" class="submenu">[출고 요청 기록]</a>
       			 						</li>
       			 						
       			 						<!-- <li class="secondmenu">
       						 				<a href="#" class="submenu">[추후 작업합니다]</a>
       			 						</li> --> 
       								</ul>
									
									</li>
									
									<!-- 카테고리 관리 -->
									<li class="menu-label">
									<a href="javascript:void(window.open('categories', 'categories','width=1090px, height=370px'))"
										class="listitem"><i class="fas fa-edit"></i>&nbsp&nbsp&nbsp [카 테 고 리 관 리]</a>
									</li>
									
									<li class="menu-label menu">
       						 				<a href="WareHouseView" class="listitem"> <i class="fas fa-warehouse"></i>&nbsp&nbsp&nbsp [창 고 현 황 확 인]</a>
       			 					</li>
									
									<!-- 재고관리 -->
									<li class="menu-label menu">
									<a href="#" class="listitem"><i class="fas fa-th"></i>&nbsp&nbsp&nbsp [재 고 관 리]</a>
									 <!-- 서브 메뉴 -->
									<ul class="hide">
       			 						<li class="secondmenu">
       						 				<a href="javascript:void(window.open('search','search', 'width=1250px, height=500px'))" class="submenu">[ 물 품 조 회]</a>
       			 						</li>
       			 						<li class="secondmenu">
       						 				<a href="javascript:void(window.open('excel','excel', 'width=360px, height=200px'))" class="submenu">[엑 셀]</a>
       			 						</li>
       								</ul>
       								
									<li class="menu-label">
									<a href="javascript:void(window.open('listMessage', 'Message','width=720px, height=550px'))" class="listitem"><i class="far fa-question-circle"></i>&nbsp&nbsp&nbsp [문  의]</a>
									</li>
									
									</li>
								</ul>
								
								
							</c:if>


							<c:if test="${sessionScope.authority == 'WareHouse'}">
								<ul>
									<li class="menu-label"><a href="#" class="listitem">창 고 배 치</a></li>
									<li class="menu-label"><a href="#" class="listitem">상 품 등 록</a></li>
									<li class="menu-label"><a href="javascript:void(window.open('listMessage', 'Message','width=720px, height=550px'))" class="listitem">문 의</a></li>
								</ul>
							</c:if>
					</div>

					<!--메뉴 밖에 어두워지는 부분-->
					<div class="panel-overlay"></div>


				</div>
			</div>
	
	<div id="menuall2">
	<!-- list -->
	<div class="list">
		<div>
			<a href="#" class="list1" id="home"><i class="fas fa-home"><br/><span class="iconname">HOME</span></i></a>
		</div>
		
		<div>
			<a href="logout" class="list1" id="logout"><i class="fas fa-sign-in-alt"><br/><span class="iconname">LOGOUT</span></i></a>
		</div>
		
		<div>
			<a href="javascript:void(window.open('listMessage', 'Message','width=720px, height=550px'))" class="list1" id="service"><i class="fas fa-headset"><br/><span class="iconname">MASAGE</span></i></a>
		</div>
		
	</div>
	</div>
	<!-- 상단 -->
	</div>
	
	<div id="line">
	<hr id="lineS"/>
	<span style="color: white; font-size: 10px;">WareHouse</span>
	<hr id="lineL"/>
	</div>
	
	
	<!-- 중단 -->
	<div id="middle">


	<div id="mid">
<!-- Book slide 설정 시작 -->
   <div class="slider">
   	 
   	<figure>
      <!-- <img id="back" src="img/back.png" alt="" width="100"> -->
        <div class="slide">
       
        <img src="./images/realtimes.jpg" alt="" style="width: 900px; height: 300px;">
        </div>
       
       
    </figure>
    
     <div class="clock" id="clock">
     	 <!-- <p class="date" id="date"></p>
    	 <p class="time" id="time"></p>
    	 <p class="text"></p> -->
     </div>
     <!--  <img id="next" src="img/next.png" alt="" width="100"> -->
   </div>
<!-- Book slide 설정 완료 -->
		
		
		
	</div>
	
	<script type="text/javascript">
		function javascript(){
			
			window.location.href="#";
		}
		
		function javascript2(){
			window.location.href="javascript:void(window.open('release_Log_Form_1','出', 'width=650px, height=520px'))";
		}
		
		function javascript3(){
			window.location.href="javascript:void(window.open('listMessage','insert', 'width=720px, height=550px'))";
		}
	</script>
	
	
	<div id="mid2">
	<div id="quickmenu">
		<div id="quickicon">
		
		<div id="ItemList">
		<figure class="snip1384">
			<img alt="빠른이동" id="quicklist" src="./images/jaego.jpg">
		
		<figcaption onclick='javascript()'>
			<h3>재고</h3>
			<p>재고 조회</p>
		</figcaption>	
			
		</figure>
		</div>
		
		<div id="WareHouse">
		<figure class="snip1384">
			<img alt="빠른이동" id="quickwarehouse" src="./images/write.jpg">
			
		<figcaption onclick='javascript2()'>
			<h3>주문</h3>
			<p>출고 주문</p>
		</figcaption>	
		</figure>
		</div>
		
		<div id="Question">
		<figure class="snip1384">
			<img alt="빠른이동" id="quickquestion" src="./images/question2.jpg">
		
		<figcaption onclick='javascript3()'>
			<h3>문의</h3>
			<p>질의 및 응답</p>
		</figcaption>	
			
		</figure>
		</div>
		
		
		
		</div>
		
	</div>
	</div>
		
	</div>
	
	
	</div>
	
	<!-- 하단 -->
	<footer id="footer">
	<div>
	
	</div>

	<div id="copy">
	Copyrightⓒ 2018 by SCIT35B07. All pictures cannot be copied without permission. 
	</div>
	</footer>
	
</body>
</html>
