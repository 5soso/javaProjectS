<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxForm.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function ajaxTest1(idx) {
  		//alert("idx : " + idx);
  		$.ajax({
  			url : "${ctp}/study/ajax/ajaxTest1",
  			type : "post",
  			data : {idx : idx},
  			success : function(res) {
  				$("#demo1").html(res);
  			},
  			error : function() {
  				alert("전송오류!");
  			}
  		});
  	}
  	
  	function ajaxTest2(str) {
  		$.ajax({
  			url : "${ctp}/study/ajax/ajaxTest2",
  			type : "post",
  			//contentType : "application/x-www-form-urlencoded; charset=UTF-8"
  			//headers : {
  			//	"Content-Type" : "application/json"},
  			//} 
  			data : {str : str},
  			success : function(res) {
  				$("#demo2").html(res);
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
  <h2>AJax 연습</h2>
	<hr/>
	<div> 기본1(String) :
		<a href="javascript:ajaxTest1(10)" class="btn btn-secondary mr-2 ">값전달1</a> 
		: <span id="demo1"></span>
	</div>
	
	<div> 기본2(String) :
		<a href="javascript:ajaxTest2('안녕')" class="btn btn-secondary mt-2">값전달2</a> 
		: <span id="demo2"></span>
	</div>
	<hr/>
	<div>응용(배열/arrayList/Map)
		<a href="${ctp}/study/ajax/ajaxTest3_1" class="btn btn-primary mr-2">시(도)/구(시,군,동)(String배열)</a>
		<a href="${ctp}/study/ajax/ajaxTest3_2" class="btn btn-primary mr-2">시(도)/구(시,군,동)(String배열-arrayList)</a>
		<a href="${ctp}/study/ajax/ajaxTest3_3" class="btn btn-primary mr-2">시(도)/구(시,군,동)(String배열-Map)</a>
	</div>
	
	<hr/>
	<div>응용(Database)
		<a href="${ctp}/study/ajax/ajaxTest4_1" class="btn btn-warning mr-2">회원정보 1인(vo)/회원정보 여러명(vos)</a>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>