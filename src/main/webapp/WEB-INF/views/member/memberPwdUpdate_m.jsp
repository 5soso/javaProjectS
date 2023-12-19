<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberPwdUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function pwdCheck() {
  		let mid = $("#mid").val().trim();
  		let pwd = $("#pwd").val().trim();
  		
  		if(pwd == "") {
  			alert("비밀번호를 입력해주세요.");
  			$("#pwd").focus();
  			return false;
  		}
  		
  		$.ajax({
  			url : '${ctp}/member/memberPwdCheck',
  			type : 'post',
  			data : {
  				mid : mid,
  				pwd : pwd
  			},
  			success : function(res) {
	  			let str = "";
  				
	  			if(res == "0") {
  					alert("비밀번호가 틀립니다. 다시 입력하세요.");
  					$("#pwd").focus();
  				}
  				else {
  					str += "<table class='table table-bordered text-center'>";
  					str += "<tr>";
  					str += "<th>새 비밀번호</th>";
  					str += "<td><input type='password' name='newPwd' id='newPwd' class='form-control' /></td>";
  					str += "</tr>";
  					str += "<tr>";
  					str += "<th>비밀번호 확인</th>";
  					str += "<td><input type='password' name='newPwd2' id='newPwd2' class='form-control' /></td>";
  					str += "</tr>";
  					str += "<tr>";
  					str += "<td colspan='2'><input type='button' value='비밀번호 변경하기' onclick='newPwdCheck()' class='btn btn-primary mr-3' />";
  					str += "<input type='reset' value='다시입력' class='btn btn-warning' /></td>";
  					str += "</tr>";
  					str += "</table>";
  				}
  				$("#demo").html(str);
  			},
  			error : function() {
  				alert("전송오류!");
  			}
  		}); 
  	}
  	
  	function newPwdCheck() {
  		let pwd1 = $("#newPwd").val();
  		let pwd2 = $("#newPwd2").val();
  		if(pwd1 != pwd2) {
  			alert("비밀번호가 일치하지 않습니다. 다시 확인하세요");
  			$("#newPwd").focus();
  			return false;
  		}

  		$.ajax({
  			url : '${ctp}/member/memberPwdUpdate',
  			type : 'post',
  			data : {pwd : pwd1},
  			success : function(res) {
  				if(res != 0) {
  					alert("비밀번호가 변경되었습니다. 다시 로그인하세요.");
  					location.href="${ctp}/member/memberLogin";
  				}
  				else {
  					alert("비밀번호 변경에 실패하였습니다.");
  					$("#newPwd").focus();
  				}
  			},
  			error : function() {
  				alert("전송오류");
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
  <h2>비밀번호 변경하기</h2>
  <form name="pwdCheckForm" method="post" class="text-center">
  	<div class="mt-4">비밀번호를 변경하시려면 기존 비밀번호를 입력하세요.<br/> 
  		<input type="password" name="pwd" id="pwd" class="mt-4 mb-3" required autofocus />
  		<input type="button" value="비밀번호 확인" onclick="pwdCheck()" class="btn btn-secondary text-center" />
  		<input type="hidden" value="${sMid}" id="mid" />
  	</div>
  </form>
  <hr/><br/>
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>