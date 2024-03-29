<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
  window.Kakao.init("dad8f37ec6bdcb4a3aa33f4ec83986a8");
	function kakaoLogout() {
		  const accessToken = Kakao.Auth.getAccessToken();
		  if(accessToken) {
			  Kakao.Auth.logout(function() {
				  window.location.href = "https://kauth.kakao.com/oauth/logout?client_id=dad8f37ec6bdcb4a3aa33f4ec83986a8&logout_redirect_uri=http://localhost:9090/javaProjectS/member/memberLogout";
			  });
		  }
	}
</script>

<!--Navbar 주메뉴-->
<div class="w3-top">
  <div class="w3-bar w3-black w3-card">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="${ctp}/" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <!-- <a href="http://192.168.50.65:9090/javaProjectS" class="w3-bar-item w3-button w3-padding-large">HOME</a> -->
    <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Guest</a>
    <c:if test="${!empty sLevel}">
	    <a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Board</a>
	    <a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Pds</a>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">Study1 <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/user/userList" class="w3-bar-item w3-button">UserList1</a>
	        <a href="${ctp}/user2/user2List" class="w3-bar-item w3-button">UserList2</a>
	        <a href="${ctp}/study/ajax/ajaxForm" class="w3-bar-item w3-button">AjaxTest</a>
	      	<a href="${ctp}/study/uuid/uidForm" class="w3-bar-item w3-button">랜덤(UUID)</a>
	      	<a href="${ctp}/study/password/sha256" class="w3-bar-item w3-button">암호화(SHA256)</a>
	      	<a href="${ctp}/study/password/aria" class="w3-bar-item w3-button">암호화(ARIA)</a>
	      	<a href="${ctp}/study/password/bCryptPassword" class="w3-bar-item w3-button">암호화(Security)</a>
	      	<a href="${ctp}/study/mail/mail" class="w3-bar-item w3-button">메일연습</a>
	      	<a href="${ctp}/study/fileUpload/fileUpload" class="w3-bar-item w3-button">파일업로드</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">study2 <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/study/kakao/kakaomap" class="w3-bar-item w3-button">kakaomap</a>
	        <a href="${ctp}/study/chart/chart" class="w3-bar-item w3-button">차트연습1</a>
	        <a href="${ctp}/study/chart2/chart" class="w3-bar-item w3-button">차트연습2</a>
	        <a href="#" class="w3-bar-item w3-button">스케줄링(Quartz)</a>
	        <a href="${ctp}/study/captcha/randomAlphaNumeric" class="w3-bar-item w3-button">랜덤알파뉴메릭</a>
	        <a href="${ctp}/study/captcha/captcha" class="w3-bar-item w3-button">캡차연습</a>
	        <a href="${ctp}/study/qrCode/qrCodeForm" class="w3-bar-item w3-button">QR Code 연습</a>
	        <a href="${ctp}/errorPage/errorMain" class="w3-bar-item w3-button">error 연습</a>
	        <a href="${ctp}/study/thumbnail/thumbnailForm" class="w3-bar-item w3-button">썸네일 연습</a>
	        <a href="${ctp}/study/crawling/jsoup" class="w3-bar-item w3-button">크롤링(jsoup)</a>
	        <a href="${ctp}/study/crawling/selenium" class="w3-bar-item w3-button">크롤링(selenium()</a>
	        <a href="${ctp}/study/transaction/transaction" class="w3-bar-item w3-button">트랜잭션</a>
	        <a href="${ctp}/study/payment/payment" class="w3-bar-item w3-button">결제연습</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">Shopping mall <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList" class="w3-bar-item w3-button">상품리스트</a>
	        <a href="${ctp}/dbShop/dbCartList" class="w3-bar-item w3-button">장바구니</a>
	     		<a href="${ctp}/payment/payment" class="w3-bar-item w3-button">결제연습</a>
	       <a href="#" class="w3-bar-item w3-button">주문(배송)현황</a>
	        <a href="#" class="w3-bar-item w3-button">QnA</a>
	        <a href="#" class="w3-bar-item w3-button">1:1문의</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">MyPage <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/user/userList" class="w3-bar-item w3-button">일정관리</a>
	        <a href="${ctp}/user2/user2List" class="w3-bar-item w3-button">회원리스트</a>
	       <a href="${ctp}/member/memberPwdCheck/p" class="w3-bar-item w3-button">비밀번호변경</a>
	        <a href="${ctp}/member/memberPwdCheck/i" class="w3-bar-item w3-button">회원정보수정</a>
	        <a href="javascript:userDelCheck()" class="w3-bar-item w3-button">회원탈퇴</a>
	        <c:if test="${sLevel == 0}"><a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button">관리자</a></c:if>
	      </div>
	    </div>
	  </c:if>  
    <c:if test="${empty sLevel}">
	    <a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Login</a>
	    <a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">join</a>
    </c:if>
   <c:if test="${!empty sLevel}">
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">Logout <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
			  	<a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">일반 Logout</a>
			  	<%-- <a href="${ctp}/member/kakaoLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Kakao Logout</a> --%>
			  	<a href="javascript:kakaoLogout()" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Kakao Logout</a>
	      </div>
	    </div>
	  </c:if>
  	<!-- <a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a> -->
  </div>
</div>

<!-- Navbar 단축메뉴(햄버거) -->
<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Guest</a>
  <c:if test="${empty sLevel}">
    <a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Login</a>
    <a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">join</a>
  </c:if>
  <c:if test="${!empty sLevel}">
  	<a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Logout</a>
	</c:if>
  <c:if test="${!empty sLevel}">
	  <a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Board</a>
	  <a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Pds</a>
		<div class="w3-dropdown-hover" >
	    <button class="w3-padding-large w3-button" title="More">study1 <i class="fa fa-caret-down"></i></button>     
	    <div class="w3-dropdown-content w3-bar-block w3-card-4">
	      <a href="${ctp}/user/userList" class="w3-bar-item w3-button">UserList1</a>
	      <a href="${ctp}/user2/user2List" class="w3-bar-item w3-button">UserList2</a>
	      <a href="${ctp}/study/ajax/ajaxForm" class="w3-bar-item w3-button">AjaxTest</a>
	      <a href="${ctp}/study/uuid/uidForm" class="w3-bar-item w3-button">랜덤(UUID)</a>
	      <a href="${ctp}/study/password/sha256" class="w3-bar-item w3-button">암호화(SHA256)</a>
	      <a href="${ctp}/study/password/aria" class="w3-bar-item w3-button">암호화(ARIA)</a>
	      <a href="${ctp}/study/password/bCryptPassword" class="w3-bar-item w3-button">암호화(Security)</a>
	      <a href="${ctp}/study/mail/mail" class="w3-bar-item w3-button">메일연습</a>
	      <a href="${ctp}/study/fileUpload/fileUpload" class="w3-bar-item w3-button">파일업로드</a>
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
	</c:if> 
</div>
  <!-- <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">MERCH</a> -->
