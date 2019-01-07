<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선반 하나만 보여줌</title>
</head>
<body>
<h2>[ 선반 현황 ]</h2>
	<table class="shelf" border="1">
		<tr>
			<th>선반 이름</th>
			<td>${shelf.shelf_Name}</td>
		</tr>
		<tr>
			<th>선반 크기</th>
			<td>${shelf.shelf_Size}</td>
		</tr>
		<tr>
			<th>선반 위치</th>
			<td>${shelf.shelf_Location}</td>
		</tr>
		<tr>
			<th>선반 상황</th>
			<td>${shelf.shelf_Condition}</td>
		</tr>
		<tr>
			<th>선반 태그</th>
			<td>${shelf.shelf_Tag}</td>
		</tr>
	</table>
<p>
<h2>[ 상품 현황 ]</h2>
	<table class="product" border="1">
		<c:if test="${empty list }">
		<tr>
			<td colspan="1">선반에 상품이 없습니다.</td>
		</tr>
		</c:if>
		
		<%-- 이하 상품 있는 경우 --%>
		<c:if test="${not empty list }" >
		<c:forEach var="product" items="${list}" varStatus="status">
		
		<tr>
			<th>선반 이름</th>
			<td>${product.product_Name}</td>
		</tr>
		<tr>
			<th>제품 번호</th>
			<td>${product.product_Number}</td>
		</tr>
		<tr>
			<th>태그 번호</th>
			<td>${product.tag_Number}</td>
		</tr>
		<tr>
			<th>수량</th>
			<td>${product.quantity}</td>
		</tr>
		<c:if test = "${not empty product.expiration_Date}">
		<tr>
			<th>유통기한</th>
			<td>${product.expiration_Date}</td>
		</tr>
		</c:if>
		<tr>
			<th>입고 일자</th>
			<td>${product.stock_Date}</td>
		</tr>
		<tr>
			<th>제품 위치</th>
			<td>${product.product_Location}</td>
		</tr>
		
		</c:forEach>
		</c:if>
	</table>
</body>
</html>