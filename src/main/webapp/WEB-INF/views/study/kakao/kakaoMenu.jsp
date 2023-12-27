<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<div>
  <p>
    <a href="${ctp}/study/kakao/kakaoEx1" class="btn btn-success">마커표시/저장</a>
    <a href="${ctp}/study/kakao/kakaoEx2" class="btn btn-primary">MyDB에 저장된 지명검색</a>
    <a href="${ctp}/study/kakao/kakaoEx3" class="btn btn-secondary">KakaoDB에 저장된 키워드로 검색</a>
    <a href="${ctp}/study/kakao/kakaoEx4" class="btn btn-info">주변검색(카테고리별 장소 검색하기)</a>
    <a href="${ctp}/study/kakao/kakaoEx5" class="btn btn-info">거리계산</a>
  </p>
</div>