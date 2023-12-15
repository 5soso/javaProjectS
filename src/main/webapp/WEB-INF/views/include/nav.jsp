<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!-- Navbar 단축메뉴-->
<div class="w3-top">
  <div class="w3-bar w3-black w3-card">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <%-- <a href="${ctp}/" class="w3-bar-item w3-button w3-padding-large">HOME</a> 배포할 때--%> 
    <a href="http://192.168.50.65:9090/javaProjectS" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Guest</a>
    <a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Board</a>
    <a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Pds</a>
    <div class="w3-dropdown-hover w3-hide-small">
      <button class="w3-padding-large w3-button" title="More">Study1 <i class="fa fa-caret-down"></i></button>     
      <div class="w3-dropdown-content w3-bar-block w3-card-4">
        <a href="${ctp}/user/userList" class="w3-bar-item w3-button">UserList1</a>
        <a href="${ctp}/user2/user2List" class="w3-bar-item w3-button">UserList2</a>
        <a href="${ctp}/study/ajax/ajaxForm" class="w3-bar-item w3-button">AjaxTest</a>
      </div>
    </div>
    <div class="w3-dropdown-hover w3-hide-small">
      <button class="w3-padding-large w3-button" title="More">study2 <i class="fa fa-caret-down"></i></button>     
      <div class="w3-dropdown-content w3-bar-block w3-card-4">
        <a href="${ctp}/user/userList" class="w3-bar-item w3-button">test1</a>
        <a href="${ctp}/user2/user2List" class="w3-bar-item w3-button">test2</a>
        <a href="#" class="w3-bar-item w3-button">test3</a>
      </div>
    </div>
  <!--   <a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a> -->
  </div>
</div>

<!-- Navbar 주메뉴-->
<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Guest</a>
  <a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Board</a>
  <a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Pds</a>
	<div class="w3-dropdown-hover" >
    <button class="w3-padding-large w3-button" title="More">study1 <i class="fa fa-caret-down"></i></button>     
    <div class="w3-dropdown-content w3-bar-block w3-card-4">
      <a href="${ctp}/user/userList" class="w3-bar-item w3-button">UserList1</a>
      <a href="${ctp}/user2/user2List" class="w3-bar-item w3-button">UserList2</a>
      <a href="${ctp}/study/ajax/ajaxForm" class="w3-bar-item w3-button">AjaxTest</a>
    </div>
	 </div>
	 <div class="w3-dropdown-hover">
	  <button class="w3-padding-large w3-button" title="More">study2 <i class="fa fa-caret-down"></i></button>     
	  <div class="w3-dropdown-content w3-bar-block w3-card-4">
	    <a href="${ctp}/user/userList" class="w3-bar-item w3-button">test1</a>
	    <a href="${ctp}/user2/user2List" class="w3-bar-item w3-button">test2</a>
	    <a href="#" class="w3-bar-item w3-button">test3</a>
	  </div>
	 </div>
  <!-- <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">MERCH</a> -->
</div>
