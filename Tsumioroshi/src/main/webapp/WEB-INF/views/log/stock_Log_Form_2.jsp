<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 入 庫   記 録 作 成 </title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/stocklog2.css">
</head>

<script src="resources/script/jquery-3.3.1.min.js"></script>

<script>


$(function(){
	
	plus();
	init();
	com_Btn();
	
})

function init(){
	sel_shelf();
	$(document).on('click', '.tag_Button',insert_Tag_Number);
	
}

var generateRandom = function (min, max) {
	  var ranNum = Math.floor(Math.random()*(max-min+1)) + min;
	  return ranNum;
	}

function insert_Tag_Number(){
	
	
	 var tag = $($(this).parent().parent().children('td').children('.tag_Number'));
	/* generateRandom(10000000000000, 99999999999999);
	tag.val(generateRandom(10000000000000, 99999999999999)); */
	  $.ajax({
		url: "insert_Tag_Number",
		method: "post",
		dataType:'json',
		contentType: 'application/json; charset:utf-8',
		success: function(resp){
			generateRandom(10000000000000, 99999999999999);
			tag.val(generateRandom(10000000000000, 99999999999999));
			
			 if(resp.tag_Number!=null){
				console.log("su "+jQuery.type(resp.tag_Number));
				console.log("su "+resp.tag_Number);
				tag.val(resp.tag_Number);
			}
			if(resp.message!=null){
				alert(resp.message);
			}
		}
	});
	/* var tag = $($(this).parent().parent().children('td').children('.tag_Number'));
    $.ajax({
      url: "insert_Tag_Number",
      method: "post",
      dataType:'json',
      contentType: 'application/json; charset:utf-8',
      success: function(resp){
         
         if(resp.tag_Number!=null){
            console.log("su "+jQuery.type(resp.tag_Number));
            console.log("su "+resp.tag_Number);
            if(tag.val()==resp.tag_Number){
               $(this).attr('disabled', 'disabled');   
            }
            $("")
         }
         if(resp.message!=null){
            alert(resp.message);
         }
      }
   });  */
} 

function plus(){
	plus_Selectbox();
}

function plus_Selectbox(){
	var result = '';
	
	for(var i=1; i<parseInt($("#stock_Amount").val());i++){
		result += '<tr id="t_Number'+i+'">';
		result += '<th class="pn_a">tag_Number</th>';
		result += '<td>';
		result += '<input class="tag_Number" type="text" name="tag_Number" id="tag_Number'+i+'"/>';
		result += '</td>';
		result += '<td>';
		result += '<input class="tag_Button" type="button" name="정식이가 만들 거" value="등록"/>';  
		result += '</td>';			
		result += '</tr>'; 
		
		result += '<tr id="e_Date'+i+'">';
		result += '<th class="pn">expiration_Date</th>';
		result += '<td>';
		result += '<input class="expiration_Date" type="date" name="expiration_Date"/>';
		result += '</td>';		
		result += '</tr>'; 
	
		result += '<tr id="p_Location'+i+'" >';
		result += '<th class="pn">product_Location</th>';
		result += '<td class="td_sel">';
		result += '</td>';
		result += '</tr>';
	}
	
	$('#btns').before(result);
	
}

function sel_shelf(){
	$.ajax({
		url : 'selectAllShelves',
		type : 'post',
		success : function(resp){
			plus_Shelf(resp)
		}
	});
}

function plus_Shelf(resp){
	//console.log(resp);
	var result='';
	if(resp==''){
		result+='선반이 없습니다.';
	}else{
		result+='<select id="product_Location'+i+'" name="product_Location">';
		for(var i=0; i<resp.length;i++){
			
			result+='<option value="'+resp[i].shelf_Name+'">'+resp[i].shelf_Name+'</option>';
			
		}
		result += '</select>';
	}
	
	$('.td_sel').html(result);
}

function com_Btn(){
	$("#complete").on('click', stock_Sub);
}

function stock_Sub(){
	var form = $('#s_Form_2');
	var post_url = form.attr("action");
    var request_method = form.attr("method"); //get form GET/POST method
    var formArray=form.serializeArray();
    
    var data = [];
    for(var i = 3; i<formArray.length; i+=3){
    	var name = formArray[0]['value'];
    	var number = formArray[1]['value'];
    	var tag = formArray[i]['value'];
    	var exp = formArray[i+1]['value'];
    	var loc = formArray[i+2]['value'];
    	
    	var product = {
    			'order_number': "${s_Log.order_Number}",
    			'product_name' : name,
    			'product_number' : number,
    			'tag_number' : tag,
    			'expiration_date' : exp,
    			'product_location' : loc
    			
    	};
    	
    	data.push(product);
    }
  
	$.ajax({
		url : post_url,
		type: request_method,
		data : {
			'data': JSON.stringify(data)
		},
		success:function(response){ //
			if(response==1){
				
				location.href= "/tsumioroshi/select_Every_Stock_Log";
			}
		}
	});
}

</script>

<body>

<h2> 入 庫   記 録 作 成 </h2>
<form id="s_Form_2" action="stock_Log_Form_2" method="POST">
<div class="main">
	<table border="1" class="tablee">
		<tr>
			<th class="pn">product_Name</th>
			<td>
				<input id="product_Name" type="text" name="product_Name" readonly="readonly" value="${s_Log.product_Name}"/>
			</td>
		</tr>
		<tr>
			<th class="pn" >product_Number</th>
			<td>
			<input id="product_Number" type="text" name="product_Number" readonly="readonly" value="${s_Log.product_Number}"/>
			</td>
		</tr>		
		<tr>
			<th class="pn">stock_Amount</th>
			<td>
			<input id="stock_Amount" type="text" name="stock_Amount" readonly="readonly" value="${s_Log.stock_Amount}"/>
			</td>
		</tr>
<!-- ---------------------------------------------------------------------------- -->
		<tr id="t_Number0">
			<th class="pn_a">tag_Number</th>
			<td>
				<input class="tag_Number" type="text" name="tag_Number" /><!-- readonly="readonly" -->
			</td>
			<td>
				<input class="tag_Button" type="button" name="정식이가 만들 거" value="등록"/>  
			</td>		
		</tr>
		<tr id="e_Date0">
         <th class="pn">expiration_Date</th>
         <td>
            <input class="expiration_Date" type="date" name="expiration_Date" />
         </td>       
     	 </tr>
		<tr id="p_Location0" >
			<th class="pn">product_Location</th>
			<td colspan="1" class="td_sel">				
				
			</td>
		</tr>
<!-- ---------------------------------------------------------------------------- -->
		<tr id="btns">
			<th colspan="2" class="bt">
				<input class="che" id="complete" type="button" value="확인"/> <!--  disabled="disabled" -->
				<input class="del" type="reset" value="지우기" />
			</th>
		</tr>
	</table>
	</div>
</form>
<a href="javascript:history.back()" class="back_bt" ><i class="fas fa-times" title="뒤로가기"></i></a>
</body>
<script src="resources/script/release_Log_Validation.js"></script>
</html>