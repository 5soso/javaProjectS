<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>thumbnailForm.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
   <script>
  	'use strict';
  	
  	// 썸네일 이미지 업로드 체크
  	function fCheck() {
  		let file = document.getElementById("file").value;
  		let ext = file.substring(file.lastIndexOf(".")+1).toLowerCase();
  		let maxSize = 1024 * 1024 * 10; //업로드 가능파일 최대용량은 10MByte
  	
  		if(file.trim() == "") {
  			alert("업로드할 파일을 선택하세요.");
  		}
  		
  		let fileSize = document.getElementById("file").files[0].size;
  		
  		if(ext != "jpg" && ext != "gif" && ext != "png") {
  			alert("업로드 가능한 파일은 'jpg/gif/png' 파일 입니다.");
  		}
  		else if(fileSize > maxSize) {
  			alert("업로드할 파일의 최대용량은 20MByte입니다.");
  		}
  		else {
  			//alert("전송완료"); 위에 체크 확인하려고 메세지 띄운 거임..
  			myform.submit();
  		}
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>썸네일 연습</h2>
  <form name="myform" method="post" enctype="multipart/form-data">
  	<p>파일명 :
  		<input type="file" name="file" id="file" class="form-control-file border" accept=".jpg,.gif,.png" />
  	</p>
  	<p>
  		<input type="button" value="썸네일만들기" onclick="fCheck()" class="btn btn-success" />
  		<input type="reset" value="다시선택" class="btn btn-warning" />
  		<input type="button" value="파일리스트로이동" onclick="location.href='thumbnailResult';" class="btn btn-info" />
  	</p>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>