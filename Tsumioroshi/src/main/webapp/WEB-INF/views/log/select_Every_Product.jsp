<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>물건 조회</title>
</head>

<script src="resources/script/jquery-3.3.1.min.js"></script>
<script>
$(function(){	
	start();
})

var eventSource = null;

	function start() {
		eventSource = new EventSource('http://localhost:8087/tsumioroshi/test');
		eventSource.onopen = function() {
			$('#result').text('Connected...\n');
		};
		eventSource.onmessage = function(message) {
			$('#result').text(message.data + '\n\n');
			//console.log(message);
		}

		eventSource.onerror = function() {
			$('#result').text('Error Occured...\n');
		};
		//startButton.disabled = true;
	}
	function stop() {
		eventSource.close();
	}
	function clear() {
		$('result').text('');
	}
</script>

<body>

<h2>[ 물건 조회 ]</h2>

<div id="result"></div>

</body>

</html>