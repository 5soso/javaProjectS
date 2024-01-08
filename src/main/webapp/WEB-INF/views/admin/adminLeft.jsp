<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adminLeft.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body style="background-color:#efa; font-size:0.8em;">
<p><br/></p>
<div class="text-center card-hover" id="accordion">
  <h5>관리자메뉴</h5>
  <div class="card bg-success text-light">
    <div class="m-0 p-2"><a href="${ctp}/" target="_top">홈으로</a></div>
  </div>
  <div class="card">
    <div class="card-header bg-warning m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse1">회원관리</a>
    </div>
    <div id="collapse1" class="collapse" data-parent="#accordion">	<!-- 처음부터 메뉴 보이게 하려면?  class="collapse show" -->
		  <div class="card-body p-2"><a href="${ctp}/admin/member/adminMemberList" target="adminContent">회원리스트</a></div>
    </div>
  </div>
  <div class="card">
    <div class="card-header bg-warning m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse2">커뮤니티</a>
    </div>
    <div id="collapse2" class="collapse" data-parent="#accordion">
		  <div class="card-body p-1"><a href="${ctp}/guest/guestList" target="adminContent">방명록</a></div>
		  <div class="card-body p-1"><a href="${ctp}/board/boardList" target="adminContent">게시판</a></div>
		  <div class="card-body p-1"><a href="${ctp}/pds/pdsList" target="adminContent">자료실</a></div>
    </div>
  </div>
  <div class="card">
    <div class="card-header bg-warning p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse3">예약관리</a>
    </div>
    <div id="collapse3" class="collapse" data-parent="#accordion">
      <div class="card-body p-1"><a href="#" target="adminContent">예약관리등록</a></div>
      <div class="card-body p-1"><a href="#" target="adminContent">예약현황조회</a></div>
    </div>
  </div>
  <div class="card">
    <div class="card-header bg-warning p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse4">상품관리</a>
    </div>
    <div id="collapse4" class="collapse" data-parent="#accordion">
      <div class="card-body p-1"><a href="${ctp}/dbShop/dbCategory" target="adminContent">상품분류등록</a></div>
      <div class="card-body p-1"><a href="${ctp}/dbShop/dbProduct" target="adminContent">상품등록관리</a></div>
      <div class="card-body p-1"><a href="#" target="adminContent">상품등록조회</a></div>
      <div class="card-body p-1"><a href="#" target="adminContent">옵션등록관리</a></div>
      <div class="card-body p-1"><a href="#" target="adminContent">주문관리</a></div>
      <div class="card-body p-1"><a href="#" target="adminContent">1:1문의</a></div>
      <div class="card-body p-1"><a href="#" target="adminContent">메인이미지관리</a></div>
    </div>
  </div>
  <div class="card">
    <div class="card-header bg-secondary p-2">
      <div class="card-link"><a data-toggle="collapse" href="#collapse5">설문조사관리</a></div>
    </div>
    <div id="collapse5" class="collapse" data-parent="#accordion">
      <div class="card-body p-1"><a href="#" target="adminContent">설문조사등록</a></div>
      <div class="card-body p-1"><a href="#" target="adminContent">설문조사분석</a></div>
    </div>
  </div>
  <div class="card">
    <div class="card-header bg-secondary p-2">
      <div class="card-link"><a data-toggle="collapse" href="#collapse6">기타관리</a></div>
    </div>
    <div id="collapse6" class="collapse" data-parent="#accordion">
      <div class="panel-body p-1"><a href="#" target="adminContent">공지사항관리</a></div>
      <div class="panel-body p-1"><a href="#" target="adminContent">사이트분석</a></div>
      <div class="panel-body p-1"><a href="#" target="adminContent">임시파일관리</a></div>
    </div>
  </div>
</div>
<p><br/></p>
</body>
</html>