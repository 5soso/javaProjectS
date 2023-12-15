<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxTest4_1.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    function fCheck1() {
    	let mid = document.getElementById("mid").value;
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요");
    		document.getElementById("mid").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "${ctp}/study/ajax/ajaxTest4_1",
    		type : "post",
    		data : {mid : mid},
    		success:function(vo) {
    			console.log(vo);
    			let str = '<h5>VO로 전송된 자료 출력</h5>';
    			if(vo != '') {
    				str += '아이디 : ' + vo.mid + '<br/>';
    				str += '성명 : ' + vo.name + '<br/>';
    				str += '나이 : ' + vo.age + '<br/>';
    				str += '주소 : ' + vo.address;
    			}
    			else {
    				str += '<b>찾고자 하는 자료가 없습니다.</b>';
    			}
    			
    			$("#demo").html(str);
    		}
    	});
    }
    
    function fCheck2() {
    	let mid = document.getElementById("mid").value;
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요");
    		document.getElementById("mid").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "${ctp}/study/ajax/ajaxTest4_2",
    		type : "post",
    		data : {mid : mid},
    		success:function(vos) {
    			console.log(vos);
    			let str = '<h5>VOS로 전송된 자료 출력</h5>';
    			if(vos == '') {
    				str += '<b>찾고자 하는 자료가 없습니다.</b>';
    			}
    			else {
  					str += '<table class="table table-bordered text-center">';
  					str += '<tr class="table-dark text-dark"><th>아이디</th><th>성명</th><th>나이</th><th>주소</th></tr>';
    				for(let i=0; i<vos.length; i++) {
    					str += '<tr>';
    					str += '<td>'+vos[i].mid+'</td>';
    					str += '<td>'+vos[i].name+'</td>';
    					str += '<td>'+vos[i].age+'</td>';
    					str += '<td>'+vos[i].address+'</td>';
    					str += '</tr>';
    				}
  					str += '<tr><td colspan="4" class="m-0 p-0"></td></tr>';
  					str += '</table>';
    			}
    			
    			$("#demo").html(str);
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
  <h2>ajaxTest4_1.jsp(AJax 개별검색(vo) 처리)</h2>
  <hr/>
  <form>
    <div>아이디 :
      <input type="text" name="mid" id="mid" class="form-control mb-3" autofocus />
    </div>
    <div>
	    <input type="button" value="아이디일치(vo)" onclick="fCheck1()" class="btn btn-info mr-3 mb-3"/>
	    <input type="button" value="아이디부분일치(vos)" onclick="fCheck2()" class="btn btn-success mr-3 mb-3"/>
	    <input type="button" value="다시입력" onclick="location.reload()" class="btn btn-info mr-3 mb-3"/>
	    <input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-warning mr-3"/>
    </div>
  </form>
  <hr/>
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>