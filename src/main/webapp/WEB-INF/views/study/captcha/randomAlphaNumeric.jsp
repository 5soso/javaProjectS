<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>randomAlphaNumeric.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    let str = '';
    let cnt = 0;
    
    function randomAlphaNumericCheck() {
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/study/captcha/randomAlphaNumeric",
    		success:function(res) {
    			cnt++;
    			str += cnt + " : " + res + "<br/>";
    			$("#demo").html(str);
    		},
    		error : function() {
    			alert("전송오류!!")
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
  <h2>randomAlphaNumeric</h2>
  <div>
    알파벳과 숫자를 랜덤하게 출력시켜줄수 있다.
  </div>
  <br/>
  <div>
    <input type="button" value="randomAlphaNumeric" onclick="randomAlphaNumericCheck()" class="btn btn-success"/>
    <input type="button" value="새로고침" onclick="location.reload();" class="btn btn-primary"/>
  </div>
  <hr/>
  <div>
    <div>출력결과 : </div>
    <span id="demo"></span>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>