function addJavascript(jsname) {

   var th = document.getElementsByTagName('head')[0];

   var s = document.createElement('script');

   s.setAttribute('type','text/javascript');

   s.setAttribute('src',jsname);

   th.appendChild(s);

}

addJavascript('resources/script/jquery-3.3.1.min.js');

$(function(){
	$('#next').on('click', stock_Check);
})

function stock_Check() {
	var product_Name = document.getElementById("product_Name");
	var order_Date = document.getElementById("order_Date");
	var departure = document.getElementById("departure");
	var stock_Amount = document.getElementById("stock_Amount");
	var charge1     = document.getElementById("charge1");
	var number ='';
	
	
	
	number += $('#product_Number_1 option:selected').val();
	number += $('#product_Number_2 option:selected').val();
	
	$('#product_Number').attr('value', number);
	
	if(product_Name.value.trim() == '') {
		alert("제품명을 입력해주세요");
		product_Name.select();
		product_Name.focus();
		return;
	}
	
	if(order_Date.value.trim() == '') {
		alert("주문하신 날짜를 선택해주세요");
		order_Date.select();
		order_Date.focus();
		return;
	}
	
	if(departure.value.trim() == '') {
		alert("출처를 입력해주세요");
		departure.select();
		departure.focus();
		return;
	}
	
	if(stock_Amount.value.trim() == '') {
		alert("수량을 입력해주세요");
		stock_Amount.select();
		stock_Amount.focus();
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
	
	if(departure.value.length < 1 || departure.value.length > 100) {
		alert("주소는 0~100 글자 사이로 입력해주세요");
		departure.select();
		departure.focus();
		return;
	}
	//form.submit()
	var form = $('#s_Form_1');
	var post_url = form.attr("action");
    var request_method = form.attr("method"); //get form GET/POST method
    var form_data=objectifyForm(form.serializeArray());
    //var form_data = new FormData(form);
    

	$.ajax({
		url : post_url,
		type: request_method,
		data : JSON.stringify(form_data),
		contentType: 'application/json; charset:utf-8',
		success:function(response){ //
			if(response=="1"){
				
				window.close();
			}
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