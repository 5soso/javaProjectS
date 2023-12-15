<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxTest3_2.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	// jquery로 onchange 할 때 값 받는 방법
  	// $("#dodo").on("change", function(){});  
  	$(function(){
			$("#dodo").change(function(){ 
				let dodo = $("#dodo").val();
				if(dodo == "") {
					alert("지역을 선택하세요");
					return false;
				}
				$.ajax({
					url : "${ctp}/study/ajax/ajaxTest3_2", 
					type : "post",
					data : {dodo : dodo},
					success:function(res) {
						console.log(res);
						
						//alert("res : "+res + ", 크기 : " + res.length);
						let str = '<option>도시선택</option>'; 
						for(let i=0; i<res.length; i++){
							if(res[i] == null) break; 
							str += '<option>'+res[i]+'</option>';
						}
						$("#city").html(str);
					},
					error:function(){
						alert("전송오류");
					}
				});
			});	
  	});
  	
  	
  	function fCheck() {
  		let dodo = $("#dodo").val(); 
  		let city = $("#city").val();
  		
  		if(dodo == "" || city == "") {
  			alert("지역을 선택하세요");
  			return false;
  		}
  		let str = "선택하신 지역은? " + dodo + " / " + city + '&nbsp';
  		str += '<input type="button" value="다시검색" onclick="location.reload()" class="btn btn-secondary btn-sum btn-sm mt-2" />';
  		$("#demo").html(str);
  	}
  
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>ajaxTest3_2.jsp(AJax ArrayList 배열처리)</h2>
  <hr/>
  <form>
	  <h3>도시를 선택하세요.</h3>
	  	<select name="dodo" id="dodo">
	  		<option value="">지역선택</option>
	  		<option>서울</option>
	  		<option>경기</option>
	  		<option>충북</option>
	  		<option>충남</option>
	  	</select>
  		<select name="city" id="city">
  			<option>도시선택</option>
  		</select>
  		<input type="button" value="선택" onclick="fCheck()" class="btn btn-info mr-2" />
  		<input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-warning" />
  </form>
  <div id="demo"></div>
  
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>