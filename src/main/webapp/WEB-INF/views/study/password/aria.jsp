<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>aria.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use Strict';
  	
  	let str = '';
  	let cnt = 0;
  	
  	function airaCheck() {
  		let pwd = $("#pwd").val();
  		
  		$.ajax({
  			type : "post",
  			url : "${ctp}/study/password/aria",
  			data : {pwd : pwd},
  			success : function(res) {
  				cnt++;
  				str += cnt + " : " + res + "<br/>";
  				$("#demo").html(str);
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
  <h2>ARIA</h2>
  <div>
  	ARIA 암호화 방식은 경량환경 및 하드ㅜ에어 구현을 위해 최적화된 알고리즘으로, Involutional SPN 구조를 갖는 범용블록 암호화 알고리즘이다.<br/>
  	ARIR가 사용하는 연산은 대부분 XOR과 같은 단순한 바이트 단위 연산으로. 블록크기는 128Bit(총비트수:256Bit=64문자)이다.<br/>
  	ARIA는 Academy(학계), Research Institute(연구소), Agency(정부기관)의 첫글자를 따서 만들었다.<br/>
  	ARIA 암호화 방식은 복호화가 가능하다.
  </div>
  <br/>
  <div>
  	<input type="text" name="pwd" id="pwd" autofocus />
  	<input type="button" value="ARIA암호화" onclick="airaCheck()" class="btn btn-success" />
  	<input type="button" value="다시하기" onclick="location.reload()" class="btn btn-warning" />
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