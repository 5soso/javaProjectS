<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxTest3_1.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	// jquery로 onchange 할 때 값 받는 방법
  	// $("#dodo").on("change", function(){});  	//on을 쓸 때 ""에는 click도 들어갈 수 있음
  	$(function(){
			$("#dodo").change(function(){ //on을 안 쓸 때
				let dodo = $("#dodo").val();
				if(dodo == "") {
					alert("지역을 선택하세요");
					return false;
				}
				$.ajax({
					url : "${ctp}/study/ajax/ajaxTest3_1", //action으로 안 넘김 - post전송방식이다.
					type : "post",
					data : {dodo : dodo},
					success:function(res) {
						console.log(res);
						
						//alert("res : "+res + ", 크기 : " + res.length);
						let str = '<option>도시선택</option>'; 
						for(let i=0; i<res.length; i++){
							if(res[i] == null) break; // 정해진 배열의 크기인 100번을 다 돌지 않고, 있는 값의 크기만큼만 돌기 위해서
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
  		let dodo = $("#dodo").val(); //제이쿼리 ()...
  		let city = $("#city").val();
  		
  		if(dodo == "" || city == "") {
  			alert("지역을 선택하세요");
  			return false;
  		}
  		let str = "선택하신 지역은? " + dodo + " / " + city + '&nbsp';
  		str += '<input type="button" value="다시검색" onclick="location.reload()" class="btn btn-secondary btn-sum btn-sm mt-2" />';
  		$("#demo").html(str);
  		
  		//alert("선택한 지역은"+dodo+"/"+city+"입니다.");
  		//$("#demo").html("선택한 지역은"+dodo+"/"+city+"입니다."); 
  		//제이쿼리에서 값 뿌릴 때는 html(); *()안에는 변수를 적어주는게 좋다.  **자바스크립트에서는 .innerHTML = ; 
  	}
  
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>ajaxTest3_1.jsp(AJax 문자열배열처리)</h2>
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
  		<input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-warning" /> <!-- onclick="location.href='ajaxForm';" : 처리할 거 없이 자바스크립트 명령으로 바로 주소로 보낸다.  -->
  </form>
  <div id="demo"></div>
  
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>