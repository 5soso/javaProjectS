<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <title>adminLeft.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>

	.sidebar {
	  height: 100%;
	  width: 180px;
	  position: fixed;
	  z-index: 1;
	  top: 0;
	  left: 0;
	  background-color: #111;
	  overflow-x: hidden;
	  padding-top: 16px;
	}
	
	.sidebar a {
	  padding: 6px 8px 6px 16px;
	  text-decoration: none;
	  font-size: 20px;
	  color: #818181;
	  display: block;
	}
	
	.sidebar a:hover {
	  color: #f1f1f1;
	}
	
	@media screen and (max-height: 450px) {
	  .sidebar {padding-top: 15px;}
	  .sidebar a {font-size: 18px;}
	}
</style>
</head>
<body>
	<div class="sidebar">
	  <a href="adminMain" target="_top">관리자</a><br/>
	  <a href="${ctp}/member/memberMain" target="_blank"><i class="fa fa-fw fa-home"></i> Home</a>
	  <a href="#services">Guest</a>
	  <a href="#services">Board</a>
	  <a href="#services">Pds</a>
	  <a href="#clients"><i class="fa fa-fw fa-user"></i> Clients</a>
	  <a href="#contact"><i class="fa fa-fw fa-envelope"></i> Contact</a>
	</div>
</body>	
</html>