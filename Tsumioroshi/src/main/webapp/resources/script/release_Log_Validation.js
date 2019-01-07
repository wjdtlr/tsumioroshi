function addJavascript(jsname) {

   var th = document.getElementsByTagName('head')[0];

   var s = document.createElement('script');

   s.setAttribute('type','text/javascript');

   s.setAttribute('src',jsname);

   th.appendChild(s);

}

addJavascript('resources/script/jquery-3.3.1.min.js');

$(function(){
	$('#next').on('click', release_Check);
})

function release_Check() {	
	var product_Name = document.getElementById("product_Name");
	var order_Date = $('#order_Date').val();
	var destination = document.getElementById("destination");
	var delivery_Amount = document.getElementById("delivery_Amount");
	var charge1     = document.getElementById("charge1");
	var number ='';
	var form = $('#r_Form_1');

	number += $('#product_Number_1 option:selected').val();
	number += $('#product_Number_2 option:selected').val();
	
	$('#product_Number').attr('value', number);
	
	if(product_Name.value.trim() == '') {
		alert("제품명을 입력해주세요");
		product_Name.select();
		product_Name.focus();
		return;
	}
	
	if(order_Date.trim() == '') {
		alert("주문하신 날짜를 선택해주세요");
		order_Date.select();
		order_Date.focus();
		return;
	}
	
	if(destination.value.trim() == '') {
		alert("목적지 주소를 입력해주세요");
		destination.select();
		destination.focus();
		return;
	}
	
	if(delivery_Amount.value.trim() == '') {
		alert("수량을 입력해주세요");
		delivery_Amount.select();
		delivery_Amount.focus();
		return;
	}
	
	if(charge1.value.trim() == '') {
		alert("로그인 해주세요");
		product_Name.select();
		product_Name.focus();
		return;
	}
	
	if(product_Name.value.length < 1 || product_Name.value.length > 20) {
		alert("제품명은 0~20 글자 사이로 입력해주세요");
		product_Name.select();
		product_Name.focus();
		return;
	}
	
	if(destination.value.length < 1 || destination.value.length > 100) {
		alert("주소는 0~100 글자 사이로 입력해주세요");
		destination.select();
		destination.focus();
		return;
	}
	
	var post_url = form.attr("action");
	var request_method = form.attr("method"); //get form GET/POST method
    var form_data=objectifyForm(form.serializeArray());
    console.log(post_url);
    console.log(request_method);
    console.log(form_data);
    $.ajax({
		url : post_url,
		type: request_method,
		data : JSON.stringify(form_data),
		contentType: 'application/json; charset:utf-8',
		success:function(response){ //

			if(response=="1"){
				releaseRaedyProduct($('#product_Number').val());
			}
		}
	});
}

function releaseRaedyProduct(number){
	$.ajax({
		url:'releaseRaedyProduct',
		type: 'post',
		data: {
			'number': number
		},
		success: function(resp){
			if(resp != 0){
				location.href="/tsumioroshi/select_Every_Release_Log";
			}
			console.log("${list}");
		}
	});
}

function objectifyForm(formArray) {//serialize data function

	var returnArray = {};
	for (var i = 0; i < formArray.length; i++){
		returnArray[formArray[i]['name']] = formArray[i]['value'];
	}
	return returnArray;
}