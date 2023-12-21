<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>user2List.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	$(function(){
  		$("#fNewFormCloseBtn").hide();
  	});
  	
  	function userDelete(idx) {
  		let ans = confirm("선택한 유저를 삭제하시겠습니까?")
  		if(!ans) return false;
  		else location.href="user2Delete?idx="+idx;
  	}
  
  	function nameSearch() {
  		let name = document.getElementById("name").value;
  		location.href= "user2Search?name="+name; //값 넘길 때 '=' 꼭 쓰기
  	}
  	
  	function fNewForm() {
  		$("#fNewFormCloseBtn").show();
  		$("#fNewFormBtn").hide();
  		
  		let str = '';
  		str += '<form method="post">';
  		str += '<table class="table table-bordered">';
  		str += '<tr>';
  		str += '<th>아이디</th>';
  		str += '<td><input type="text" name="mid" class="form-control" /></td>';
  		str += '</tr>';
  		str += '<tr>';
  		str += '<th>성명</th>';
  		str += '<td><input type="text" name="name" class="form-control"  /></td>';
  		str += '</tr>';
  		str += '<tr>';
  		str += '<th>나이</th>';
  		str += '<td><input type="number" name="age" class="form-control" value="20" /></td>';
  		str += '</tr>';
  		str += '<tr>';
  		str += '<th>주소</th>';
  		str += '<td><input type="text" name="address" class="form-control" /></td>';
  		str += '</tr>';
  		str += '<tr>';
  		str += '<td colspan="2" class="text-center"><input type="submit" value="회원가입" class="btn btn-info" /></td>';
  		str += '</tr>';
  		str += '</table>';
  		str += '</form>';
  		document.getElementById("demo").innerHTML = str;
  	}
  	
  	function userUpdate(idx,name,age,address) {
  		$("#myModal .modal-body #idx").val(idx); //모달에 있는 아이디의 값을 읽어온다. 
  		$("#myModal .modal-body #name").val(name); // name다른 곳에서 사용하고 있음. 어디에서 쓰는 name인지 명확하게 준다.
  		$("#myModal .modal-body #age").val(age);
  		$("#myModal .modal-body #address").val(address);
  	}
  	
  	function fNewFormClose() {
  		location.reload();
  		
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>회 원 리 스 트 2</h2>
  <%-- 
  <div class="row"> <!-- class="row" 뜻? -->
  	<div class="col-7"> <!-- 전체 합쳐서 12개 나오면 됨.  -->
  		<input type="button" value="회원가입폼" onclick="fNewForm()" id="fNewFormBtn" class="btn btn-primary btn-sm" />
  		<input type="button" value="회원가입폼닫기" onclick="fNewFormClose()" id="fNewFormCloseBtn" class="btn btn-info btn-sm" />
  	</div>
  	<div class="col-5">
	  	 <div class="input-group">
		  	<input type="text" name="name" value="${name}" id="name" style="margin: 7px;"/>
		  	<div class="input-group-append"><input type="button" value="검색" onclick="nameSearch()" class="btn btn-success mb-2" /></div>
  		</div>
  	</div>
  </div>
  --%>
  <div class="row">
    <div class="col-7">
      <input type="button" value="회원가입폼" onclick="fNewForm()" id="fNewFormBtn" class="btn btn-primary btn-sm mb-2"/>
      <input type="button" value="회원가입폼닫기" onclick="fNewFormClose()" id="fNewFormCloseBtn" class="btn btn-info btn-sm mb-2"/>
    </div>
    <div class="col-5">
	    <div class="input-group">
	      <input type="text" name="name" id="name" value="${name}" class="form-control mb-2">
	      <div class="input-group-append"><input type="button" value="이름검색" onclick="nameSearch()" class="btn btn-success btn-sm mb-2"/></div>
	    </div>
    </div>
  </div>
  <div id="demo"></div>
  <table class="table table-hover">
  	<tr class="table table-dark text-dark text-center">
  		<th>번호</th>
  		<th>아이디</th>
  		<th>성명</th>
  		<th>나이</th>
  		<th>주소</th>
  		<th>비고</th>
  	</tr>
  	<c:forEach var="vo" items="${vos}" varStatus="st">
	  	<tr class="text-center">
	  		<td>${vo.idx}</td>
	  		<td>${vo.mid}</td>
	  		<td>${vo.name}</td>
	  		<td>${vo.age}</td>
	  		<td>${vo.address}</td>
	  		<td>
		  		<a href="#" onclick="userUpdate('${vo.idx}','${vo.name}','${vo.age}','${vo.address}')" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">수정</a> <!-- 클릭하는 순간 값을 보낸다. onclick 함수에 값을 다 넘긴다. 타입은 모두 문자로...-->
		  		<a href="javaScript:userDelete(${vo.idx})" class="btn btn-danger btn-sm">삭제</a>
	  		</td>
	  	</tr>
  	</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
  </table>
  <br/>
  <div><a href="${ctp}/" class="btn btn-warning">돌아가기</a></div>
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원정보 수정</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
      	<form method="post" action="${ctp}/user2/user2Update">
      		<div>성명 : <input type="text" name="name" id="name" class="form-control mb-2" required /></div>
      		<div>나이 : <input type="number" name="age" id="age" class="form-control mb-2" /></div>
      		<div>주소 : <input type="text" name="address" id="address" class="form-control mb-2" /></div>
      		<div><input type="submit" value="정보수정" class="btn btn-info" /></div>
      		<div><input type="hidden" name="idx" id="idx" /></div>
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
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>