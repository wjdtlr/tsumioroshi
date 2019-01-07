<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선반 전체 (창고 내부)</title>
</head>
<body>

<h2>[ 창고 내부 ]</h2>
	<table class="warehouse" border="1">

	<c:if test="${empty list }" >
	<tr>
		<td colspan="1">선반이 없습니다.</td>
	</tr>
	</c:if>
	
	<%-- 이하 선반 있는 경우 --%>
	<c:if test="${not empty list }" >
	<c:forEach var="shelf" items="${list}" varStatus="status">
	
	<tr>
		<td>
			<a href="select_Shelf?shelf_Name=${shelf.shelf_Name}">
			${shelf.shelf_Name}
			</a>
		</td>
	</tr>
	
	</c:forEach>
	</c:if>
	
	</table>
</body>
</html>