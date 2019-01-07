<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출고 기록 작성 Form2</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./resources/css/releaselog2.css">
</head>

<script src="resources/script/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	//console.log("${p_list[0]}")
	plus_Selectbox();
	init();
	plus();
	com_Btn();
	
	$.urlParam = function(name){
	    var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(window.location.href);
	    return results[1] || 0;
	}
})


function init(){
	sel_shelf();
	/* $(document).on('click', '.tag_Button', insert_Tag_Number()); */
	
}

function insert_Tag_Number(){
	
	
	var tag = $($(this).parent().parent().children('td').children('.tag_Number'));
	

	/* 
	if($(this).parent().parent().attr('id') == "t_Number0"){
		tag.val('53309956080995');
	}
	
	if($(this).parent().parent().attr('id') == "t_Number1"){
		tag.val('29798640492460');
	}
	
	if($(this).parent().parent().attr('id') == "t_Number2"){
		tag.val('36474247455363');
	} */
	
	/* $.ajax({
		url: "insert_Tag_Number",
		method: "post",
		dataType:'json',
		contentType: 'application/json; charset:utf-8',
		success: function(resp){
			
			if(resp.tag_Number!=null){
				console.log("su "+jQuery.type(resp.tag_Number));
				console.log("su "+resp.tag_Number);
				tag.val(resp.tag_Number);
				$("")
			}
			if(resp.message!=null){
				alert(resp.message);
			}
		}
	}); */
	
	 var tag = $($(this).parent().parent().children('td').children('.tag_Number'));
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
	   });
} 



function plus_Selectbox(){
	var result = '';
	
	for(var i=1; i<parseInt($("#delivery_Amount").val());i++){
		
		result += '<tr id="t_Number'+i+'">';
		result += '<th class="pn_a">tag_Number</th>';
		result += '<td>';
		result += '<input class="tag_Number" type="text" name="tag_Number" id="tag_Number'+i+'"/>';
		result += '</td>';
		result += '<td>';
		result += '<input class="tag_Button" type="button" name="정식이가 만들 거" value="확인" />';  
		result += '</td>';			
		result += '</tr>';      
		
		result += '<tr id="e_Date'+i+'">';
		result += '<th class="pn">expiration_Date</th>';
		result += '<td>';
		result += '<input class="expiration_Date" type="text" name="expiration_Date"/>';
		result += '</td>';		
		result += '</tr>'; 
		
		result += '<tr id="p_Location'+i+'" >';
		result += '<th>product_Location</th>';
		result += '<td class="td_sel">';
		result += '<input class="product_location" type="text" name="product_Location" value="" readonly="readonly"/>';
		result += '</td>';
		result += '</tr>';
	}
	
	$('#btns').before(result);
	
}

function sel_shelf(){
	$.ajax({
		url : 'select_Every_Shelves',
		type : 'post',
		success : function(resp){
			/* plus_Shelf(resp) */
			/* input_value(resp); */
		}
	});
}

function plus_Shelf(resp){
	//console.log(resp);
	var result='';
	if(resp==''){
		result+='선반이 없습니다.';
	}else{
		result+='<select class="shelf_Name" name="product_Location">';
		for(var i=0; i<resp.length;i++){
			
			result+='<option value="'+resp[i].shelf_Name+'">'+resp[i].shelf_Name+'</option>';
			
		}
		result += '</select>';
	}
	
	$('.td_sel').html(result);
}

function plus(){
	var pno =  $("#product_Number").val();
	
	$.ajax({
		url:"plus_value",
		method: "post",
		data:{
			'product_Number' : pno
		},
		success: function(resp){
			input_value(resp);
		}
		
	});
	
} 

function input_value(resp){
	for(var i=0;i<parseInt($("#delivery_Amount").val());i++){
		var temp="#t_Number"+i;
		$($(temp).children().children(".tag_Number")).val(resp[i].tag_Number);
		temp="#e_Date"+i;
		$($(temp).children().children(".expiration_Date")).val(resp[i].expiration_Date);
		temp="#p_Location"+i;
		//console.log($(temp).children().children(".shelf_Name"));
		$($(temp).children().children(".product_location")).val(resp[i].product_Location);
		//alert(temp+" loc : "+resp[i].product_Location);
	}
}

function com_Btn(){
	$("#complete").on('click', stock_Sub);
}

function stock_Sub(){
	var form = $('#r_Form_2');
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
    			'order_number':  $.urlParam('order_Number'),
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
			'data' : JSON.stringify(data)
		},
		success:function(response){ //
			console.log(response);
			if(response == 1 ){
				location.href="/tsumioroshi/select_Every_Release_Log";
			}
		}
	});
}
</script>

<body>

<h2>[ 출고 기록 작성 Form2 ]</h2>
<form id="r_Form_2" action="release_Log_Form_2" method="POST">
<div class="main" >
   <table border="1" class="tablee">
      <tr>
         <th class="pn">product_Name</th>
         <td>
            <input id="product_Name" type="text" name="product_Name" readonly="readonly" value="${r_Log.product_Name}"/>
         </td>
      </tr>
      <tr>
         <th class="pn">product_Number</th>
         <td>
         <input id="product_Number" type="text" name="product_Number" readonly="readonly" value="${r_Log.product_Number}" />
         </td>
      </tr>      
      <tr>
         <th class="pn">delivery_Amount</th>
         <td>
         <input id="delivery_Amount" type="text" name="delivery_Amount" readonly="readonly" value="${r_Log.delivery_Amount}" />
         </td>
      </tr>
      <tr id="t_Number0">
			<th class="pn_a">tag_Number</th>
			<td>
				<input class="tag_Number" type="text" name="tag_Number" /><!-- readonly="readonly" -->
			</td>
			<!-- <td>
				<input class="tag_Button" type="button" name="정식이가 만들 거" value="확인"/>  
			</td> -->		
		</tr>
      <tr id="e_Date0">
         <th  class="pn">expiration_Date</th>
         <td>
            <input class="expiration_Date" type="text" name="expiration_Date" />
         </td>       
      </tr>
		<tr id="p_Location0" >
			<th class="pn">product_Location</th>
			<td colspan="1" class="td_sel">				
				<input class="product_location" type="text" name="product_Location" value="" readonly="readonly"/>
			</td>
		</tr>
		<tr id="btns">
         <th colspan="2" class="bt">
            <input class="che" id="complete" type="button" value="확인"  />
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