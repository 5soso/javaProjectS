<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
      min-height: 150px;
    }
  </style>
  <script>
    'use strict';
    
    // 좋아요 조회수 증가(중복불허....숙제...)
    function goodCheck() {
    	$.ajax({
    		url  : "boardGoodCheck",
    		type : "post",
    		data : {idx : ${vo.idx}},
    		success:function(res) {
    			if(res == "0") alert('이미 좋아요 버튼을 클릭하셨습니다.');
    			else location.reload();
    		},
    		error : function() {
    			alert("전송 오류!!");
    		}
    	});
    }
    
    //  아래 좋아요수 증가(+1)과 감소(-1)은 같은 루틴의 반복으로 통합처리했음
    // 좋아요 조회수 증가(중복허용)
    function goodCheckPlus() {
    	$.ajax({
    		//url  : "boardGoodCheckPlus",
    		url  : "boardGoodCheckPlusMinus",
    		type : "post",
    		data : {
    			idx : ${vo.idx},
    			goodCnt : +1
    		},
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송 오류!!");
    		}
    	});
    }
    
    // 좋아요 조회수 감소(중복허용)
    function goodCheckMinus() {
    	$.ajax({
    		//url  : "boardGoodCheckMinus",
    		url  : "boardGoodCheckPlusMinus",
    		type : "post",
    		data : {idx : ${vo.idx},
    			goodCnt : -1	
    		},
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송 오류!!");
    		}
    	});
    }
    
    // 게시글 삭제
    function boardDeleteOk() {
    	let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
    	if(ans) location.href = "boardDeleteOk?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
    }
    
    // 댓글 달기
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요!");
    		$("#content").focus();
    		return false;
    	}
    	let query = {
    			boardIdx  : ${vo.idx},
    			mid				: '${sMid}',
    			nickName	: '${sNickName}',
    			hostIp		: '${pageContext.request.remoteAddr}',
    			content		: content
    	}
    	
    	$.ajax({
    		url  : "boardReplyInput",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res == "1") {
    				alert("댓글이 입력되었습니다.");
    				location.reload();
    			}
    			else {
    				alert("댓글 입력 실패~~");
    			}
    		},
    		error : function() {
    			alert("전송오류!!");
    		}
    	});
    }
    
    // 댓글 삭제하기
    function replyDelete(idx) {
    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "boardReplyDelete",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res == "1") {
    				alert("댓글이 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("댓글 삭제 실패~~");
    		},
    		error : function() {
    			alert("전송실패");
    		}
    	});
    }
    
    // 신고시 '기타'텍스트항목 보여주기
    function etcShow() {
    	$("#complaintTxt").show();
    }
    
    // 신고화면 선택후 신고사항 전송하기
    function complaintCheck() {
    	if (!$("input[type=radio][name=complaint]:checked").is(':checked')) {
        alert('신고항목을 선택하세요');
        return false;
      }
    	if($("input[type=radio][id=complaint7]:checked").val() == 'on' && $("#complaintTxt").val() == "") {
        alert("기타 사유를 입력해 주세요.");
        return false;
    	}
      //alert("신고하러갑니다." + $("input[type=radio][id=complaint7]:checked").val());
    	
      let cpContent = modalForm.complaint.value;
      if(cpContent == '기타') cpContent += "/" + $("#complaintTxt").val();
      
      $.ajax({
    	  url  : "boardComplaintInput.ad",
    	  type : "post",
    	  data : {
    		  part    : 'board',
    		  partIdx : ${vo.idx},
    		  cpMid   : '${sMid}',
    		  cpContent : cpContent
    	  },
    	  success:function(res) {
    		  if(res == "1") {
    			  alert("신고 되었습니다.");
    			  location.reload();
    		  }
    		  else alert('신고 실패~~');
    	  },
    	  error : function() {
    		  alert('전송오류!');
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
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td><h2 class="text-center">글 내 용 보 기</h2></td>
    </tr>
  </table>
  <table class="table table-bordered">
    <tr>
      <th>글쓴이</th>
      <td>${vo.nickName}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.WDate, 0, 16)}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">${vo.title}</td>
    </tr>
    <tr>
      <th>전자메일</th>
      <td>
        <c:if test="${empty vo.email}">없음</c:if>
        <c:if test="${!empty vo.email}">${vo.email}</c:if>
      </td>
      <th>조회수</th>
      <td>${vo.readNum}</td>
    </tr>
    <tr>
      <th>홈페이지</th>
      <td>
        <c:if test="${empty vo.homePage || (fn:indexOf(vo.homePage,'http://') == -1 && fn:indexOf(vo.homePage,'https://') == -1) || fn:length(vo.homePage) <= 10}">없음</c:if>
        <c:if test="${!empty vo.homePage && (fn:indexOf(vo.homePage,'http://') != -1 || fn:indexOf(vo.homePage,'https://') != -1) && fn:length(vo.homePage) > 10}"><a href="${vo.homePage}" target="_blank">${vo.homePage}</a></c:if>
      </td>
      <th>좋아요</th>
      <td><font color="red"><a href="javascript:goodCheck()">❤</a></font>(${vo.good}) / <a href="javascript:goodCheckPlus()">👍</a><a href="javascript:goodCheckMinus()">👎</a></td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
  </table>
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td class="text-left">
        <c:if test="${flag != 'search'}"><input type="button" value="돌아가기" onclick="location.href='boardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning"/> &nbsp;</c:if>
        <c:if test="${flag == 'search'}"><input type="button" value="돌아가기" onclick="location.href='boardSearch?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-warning"/> &nbsp;</c:if>
      </td>
      <td class="text-right">
        <%-- <c:if test="${vo.mid != sMid}"><a href="complaintInput.ad" class="btn btn-danger">신고하기</a></c:if> --%>
        <c:if test="${vo.mid != sMid}"><button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal">신고하기</button></c:if>
        <c:if test="${sMid == vo.mid || sLevel == 0}">
        	<input type="button" value="수정하기" onclick="location.href='boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-info"/> &nbsp;
        	<input type="button" value="삭제하기" onclick="boardDeleteOk()" class="btn btn-danger"/>
        </c:if>
      </td>
    </tr>
  </table>
  <hr/>
  <!-- 이전글/다음글 처리 -->
  <table class="table table-borderless">
    <tr>
      <td>
        <c:if test="${!empty nextVo.title}">
        	☝ <a href="boardContent?idx=${nextVo.idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${nextVo.title}</a><br/>
        </c:if>
        <c:if test="${!empty preVo.title}">
        	👇 <a href="boardContent?idx=${preVo.idx}&pag=${pag}&pageSize=${pageSize}">이전글 : ${preVo.title}</a><br/>
        </c:if>
      </td>
    </tr>
  </table>
</div>
<br/>

<!-- 댓글 처리 -->
<div class="container">
	<!-- 댓글 리스트 보여주기 -->
  <table class="table table-hover text-center">
    <tr>
      <th>작성자</th>
      <th class="text-left">댓글내용</th>
      <th>댓글일자</th>
      <th>접속IP</th>
    </tr>
    <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
      <tr>
        <td>${replyVo.nickName}
          <c:if test="${replyVo.mid == sMid || sLevel == 0}">
            (<a href="javascript:replyDelete(${replyVo.idx})">x</a>)
          </c:if>
        </td>
        <td class="text-left">${fn:replace(replyVo.content,newLine,"<br/>")}</td>
        <td>${fn:substring(replyVo.WDate,0,10)}</td>
        <td>${replyVo.hostIp}</td>
      </tr>
      <tr><td colspan="4" class="m-0 p-0"></td></tr>
    </c:forEach>
  </table>
  
  <!-- 댓글 입력창 -->
  <form name="replyForm">
    <table class="table table-center">
      <tr>
        <td style="width:85%" class="text-left">
          글내용 :
          <textarea rows="4" name="content" id="content" class="form-control"></textarea>
        </td>
        <td style="width:15%">
          <br/>
          <p style="font-size:13px">작성자 : ${sNickName}</p>
          <p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm"/></p>
        </td>
      </tr>
    </table>
  </form>
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content modal-sm">
      <!-- Modal Header -->
      <div class="modal-header">
        <h5 class="modal-title">현재 게시글을 신고합니다.</h5>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <b>신고사유 선택</b>
        <hr class="m-2"/>
        <form name="modalForm">
          <div class="form-check"><input type="radio" name="complaint" id="complaint1" value="욕설,비방,차별,혐오" class="form-check-input"/>욕설,비방,차별,혐오</div>
          <div class="form-check"><input type="radio" name="complaint" id="complaint2" value="홍보,영리목적" class="form-check-input"/>홍보,영리목적</div>
          <div class="form-check"><input type="radio" name="complaint" id="complaint3" value="불법정보" class="form-check-input"/>불법정보</div>
          <div class="form-check"><input type="radio" name="complaint" id="complaint4" value="음란,청소년유해" class="form-check-input"/>음란,청소년유해</div>
          <div class="form-check"><input type="radio" name="complaint" id="complaint5" value="개인정보노출,유포,거래" class="form-check-input"/>개인정보노출,유포,거래</div>
          <div class="form-check"><input type="radio" name="complaint" id="complaint6" value="도배,스팸" class="form-check-input"/>도배,스팸</div>
          <div class="form-check"><input type="radio" name="complaint" id="complaint7" value="기타" class="form-check-input" onclick="etcShow()"/>기타</div>
          <div id="etc"><textarea rows="2" name="complaintTxt" id="complaintTxt" class="form-control" style="display:none;"></textarea></div>
          <hr class="m-1"/>
          현재글 제목 : <span class="mb-2">${vo.title}</span><br/>
          신고자 아이디 : <span class="mb-2">${sMid}</span>
          <hr class="m-2"/>
          <input type="button" value="확인" onclick="complaintCheck()" class="btn btn-success form-control" />
          <input type="hidden" name="idx" id="idx" value="${vo.idx}"/>
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