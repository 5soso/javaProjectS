<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 반응형 때문에 꼭 필요 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<style>
		body {font-family: "Lato", sans-serif;}
		
		.main {
		  margin-left: 180px; /* Same as the width of the sidenav */
		  padding: 0px 10px;
		}
	</style>
</head>
<jsp:include page="/WEB-INF/views/admin/adminLeft.jsp" />
<body>

<div class="main">
  <h2>관리자 메인화면입니다.</h2>
<jsp:include page="/WEB-INF/views/admin/adminContent.jsp" />  
</div>
     
</body>
</html> 
