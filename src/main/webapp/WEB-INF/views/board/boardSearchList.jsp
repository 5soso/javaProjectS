<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardSearchList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <table class="table table-borderless m-0 p-0">
    <tr>
  		<td colspan="2" class="text-center">
  		  <h2>게 시 판 조 건 검 색 리 스 트</h2>
  		  (<font color="blue">${searchTitle}</font>(으)로 <font color="red">${pageVO.searchString}</font>(을)를 검색한 결과 <font color="blue"><b>${searchCount}</b></font>건이 검색되었습니다.)
  		</td>
    </tr>
    <tr>
      <td>
        <%-- <a href="boardList?pag=${pag}&pageSize=${pageSize}" class="btn btn-warning btn-sm">돌아가기</a> --%>
        <a href="boardList?pageSize=${pageVO.pageSize}" class="btn btn-warning btn-sm">돌아가기</a>
      </td>
    </tr>
  </table>
  <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>글번호</th>
      <th>글제목</th>
      <th>글쓴이</th>
      <th>글쓴날짜</th>
      <th>조회수(좋아요)</th>
    </tr>
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"></c:set>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${curScrStartNo}</td>
        <td class="text-left">
          <a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&flag=search&search=${pageVO.search}&searchString=${pageVO.searchString}">${vo.title}</a>
          <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
        </td>
        <td>${vo.nickName}</td>
        <td><!-- new.gif가 표시된 글은 시간만 표시시켜주고, 그렇지 않은 자료는 일자만 표시시켜주시오. -->
          <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
          <c:if test="${vo.hour_diff <= 24}">
            ${vo.date_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,16)}
          </c:if>
        </td>
        <td>${vo.readNum}(${vo.good})</td>
      </tr>
      <tr><td colspan="5" class="m-0 p-0"></td></tr>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
  </table>
</div>
<!-- 블록페이지 시작(1블록의 크기를 3개(3Page)로 한다. 한페이지 기본은 5개 -->
<br/>
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="boardSearch?search=${pageVO.search}&searchString=${pageVO.searchString}&pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="boardSearch?search=${pageVO.search}&searchString=${pageVO.searchString}&pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(cpageVO.urBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="boardSearch?search=${pageVO.search}&searchString=${pageVO.searchString}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="boardSearch?search=${pageVO.search}&searchString=${pageVO.searchString}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="boardSearch?search=${pageVO.search}&searchString=${pageVO.searchString}&pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="boardSearch?search=${pageVO.search}&searchString=${pageVO.searchString}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>