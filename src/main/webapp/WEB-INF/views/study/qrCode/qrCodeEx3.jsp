<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qrCodeEx3.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    function qrCreate() {
    	let mid = $("#mid").val();
    	let movieName = $("#movieName").val();
    	let movieDate = $("#movieDate").val();
    	let movieTime = $("#movieTime").val();
    	let movieAdult = $("#movieAdult").val();
    	let movieChild = $("#movieChild").val();
    	
    	if(mid.trim() == "" || movieName.trim() == "" || movieDate.trim() == "" || movieTime.trim() == "" || movieAdult.trim() == "" || movieChild.trim() == "") {
    		alert("개인 정보를 입력해주세요");
    		$("#mid").focus();
    		return false;
    	}
    	
    	let query = {
    			mid   : mid,
    			movieName : movieName,
    			movieDate   : movieDate,
    			movieTime   : movieTime,
    			movieAdult   : movieAdult,
    			movieChild   : movieChild
    	}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/study/qrCode/qrCodeEx3",
    		data  : query,
    		success:function(res) {
    			if(res != "") {
    				alert("생성된 QR코드명 : " + res);
    				let qrCode = 'QR Code명 : ' + res + '<br/>';
    				qrCode += '<img src="${ctp}/qrCode/'+res+'.png"/>';
    				$("#demo").html(qrCode);
    			}
    			else alert("QR코드 생성 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!!");
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
  <h2>영화티켓 예매정보를 QR코드로 생성하기</h2>
  <div>(생성된 QR코드를 메일로 보내드립니다. QR코드를 입장시 매표소에 제시해주세요.)</div>
  <hr/>
  <form method="post">
	  <table class="table table-bordered">
	    <tr>
	      <th>영화명선택</th>
	      <td>
	      	<select name="movieName" id="movieName" class="form-control" required>
	      		<option value="">영화선택</option>
	      		<option>서울의 봄</option>
	      		<option>노량:죽음의바다</option>
	      		<option>괴물</option>
	      		<option>기생충</option>
	      		<option>라라랜드</option>
	      		<option>해리포터</option>
	      	</select>
	      </td>
	    </tr>
	    <tr>
	      <th>상영일자선택</th>
	      <td><input type="text" name="movieDate" id="movieDate" value="<%=LocalDate.now()%>" class="form-control"/></td>
	    </tr>
	    <tr>
	      <th>상영시간선택</th>
	      <td>
	      	<select name="movieTime" id="movieTime" class="form-control" required>
	      		<option value="">시간선택</option>
	      		<option>12시00분</option>
	      		<option>14시30분</option>
	      		<option>17시00분</option>
	      		<option>19시30분</option>
	      		<option>22시00분</option>
	      	</select>
	      </td>
	    </tr>
	     <tr>
	      <th>인원수</th>
	      <td>
	      	<input type="number" name="movieAdult" id="movieAdult" value="1" min="1" class="form-control"/>
	      	<input type="number" name="movieChild" id="movieChild" value="0" min="0" class="form-control"/>
	      </td>
	    </tr>
	    <tr>
	      <td colspan="2" class="text-center">
	        <input type="button" value="티켓예매하기" onclick="qrCreate()" class="btn btn-success mr-2"/>
	        <input type="button" value="다시예매하기" onclick="location.reload()" class="btn btn-warning mr-2"/>
	        <input type="button" value="돌아가기" onclick="location.href='qrCodeForm';" class="btn btn-info"/>
	      </td>
	    </tr>
	  </table>
	  <input type="hidden" name="mid" id="mid" value="${sMid}" />
  </form>
  <hr/>
  <div>생성된 QR 코드 :<br/>
    <div id="demo"></div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>