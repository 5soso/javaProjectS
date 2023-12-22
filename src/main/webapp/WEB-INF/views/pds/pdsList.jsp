<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>pdsList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    function partCheck() {
    	let part = $("#part").val();
    	location.href = 'pdsList?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part='+part;
    }
    
    function pdsDeleteCheck(idx, title) {
    	$("#myModal #idx").val(idx);
    	$("#myModal #title").html(title);
    }
    
    function pdsDeleteOk() {
    	let idx = $("#myModal #idx").val();
    	let pwd = $("#myModal #pwd").val();
    	
    	let query = {
    			idx  : idx,
    			pwd  : pwd
    	}
    	
    	$.ajax({
    		url  : "${ctp}/pds/pdsDeleteOk",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res == "1") alert("삭제 되었습니다.");
    			else alert("삭제 실패~~~");
  				location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 다운로드수 증가시키기
    function downNumCheck(idx) {
    	$.ajax({
    		url  : "${ctp}/pds/pdsDownNumCheck",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res=="1") location.reload();
    			else alert("다운로드 실패");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">자 료 실 리 스 트(${pageVO.part})</h2>
  <br/>
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td style="width:20%" class="text-left">
      	<form name="partForm">
      	  <select name="part" id="part" onchange="partCheck()" class="form-control">
      	    <option ${pageVO.part=="전체" ? "selected" : ""}>전체</option>
      	    <option ${pageVO.part=="학습" ? "selected" : ""}>학습</option>
      	    <option ${pageVO.part=="여행" ? "selected" : ""}>여행</option>
      	    <option ${pageVO.part=="음식" ? "selected" : ""}>음식</option>
      	    <option ${pageVO.part=="기타" ? "selected" : ""}>기타</option>
      	  </select>
      	</form>
      </td>
      <td class="text-right">
        <a href="pdsInput?part=${pageVO.part}" class="btn btn-success">자료올리기</a>
      </td>
    </tr>
  </table>
  <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>자료제목</th>
      <th>올린이</th>
      <th>올린날짜</th>
      <th>분류</th>
      <th>파일명(크기)</th>
      <th>다운수</th>
      <th>비고</th>
    </tr>
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
    <c:forEach var="vo" items="${vos}" varStatus="st">
	    <tr>
	      <td>${curScrStartNo}</td>
	      <td>
	        <a href="pdsContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${pageVO.part}">${vo.title}</a>
          <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
	      </td>
	      <td>${vo.nickName}</td>
	      <td>${vo.FDate}
	        <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.FDate,0,10)}</c:if>
          <c:if test="${vo.hour_diff <= 24}">
            ${vo.date_diff == 0 ? fn:substring(vo.FDate,11,19) : fn:substring(vo.FDate,0,16)}
          </c:if>
	      </td>
	      <td>${vo.part}</td>
	      <td>
	        <c:set var="fNames" value="${fn:split(vo.FName,'/')}"/>
	        <c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
	        <c:forEach var="fName" items="${fNames}" varStatus="st">
	          <a href="${ctp}/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
	        </c:forEach>
	        (<fmt:formatNumber value="${vo.FSize/1024}" pattern="#,##0" />  KByte)
	      </td>
	      <td>${vo.downNum}</td>
	      <td>
	        <c:if test="${vo.mid == sMid || sLevel == 0}">
	          <a href="#" onclick="pdsDeleteCheck('${vo.idx}','${vo.title}')" class="badge badge-danger" data-toggle="modal" data-target="#myModal">삭제</a>
	        </c:if>
	        <br/>
	        <a href="pdsTotalDown.pds?idx=${vo.idx}" class="badge badge-primary">전체다운</a>
	      </td>
	    </tr>
    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    	<tr><td colspan="8" class="m-0 p-0"></td></tr>
    </c:forEach>
  </table>
</div>
<!-- 블록페이지 시작(1블록의 크기를 3개(3Page)로 한다. 한페이지 기본은 5개 -->
<br/>
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVO.part}&pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVO.part}&pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVO.totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="pdsList?part=${pageVO.part}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVO.totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVO.part}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVO.part}&pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVO.part}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->

<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content modal-sm">
      <!-- Modal Header -->
      <div class="modal-header">
        <h5 class="modal-title">선택한 자료를 삭제합니다.</h5>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <div>현재글 제목 : <span class="mb-2" id="title"></span></div>
        <hr class="m-2"/>
        <form name="modalForm">
	        <b>등록시 입력한 비밀번호를 입력하세요.</b>
          <div><input type="password" name="pwd" id="pwd" value="1234" class="form-control"/></div>
          <hr class="m-2"/>
          <input type="button" value="확인" onclick="pdsDeleteOk()" class="btn btn-success form-control" />
          <input type="hidden" name="idx" id="idx"/>
        </form>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>