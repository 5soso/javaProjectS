<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>pdsInput.jsp</title>
   <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    let cnt = 1;
    
    function fileBoxAppend() {
    	cnt++;
    	let fileBox = '';
    	//fileBox += '<div id="fBox'+cnt+'">('+cnt+')';
    	fileBox += '<div id="fBox'+cnt+'">';
    	fileBox += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'" class="form-control-file border mb-2" style="float:left;width:85%;" />';
    	fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-danger form-control mb-2 ml-2" style="width:10%;" />';
    	fileBox += '</div>';
    	$("#fileBoxAppend").append(fileBox);
    }
    
    // 추가된 파일박스 삭제처리
    function deleteBox(cnt) {
    	$("#fBox"+cnt).remove();
    	cnt--;
    }
    
    function fCheck() {
    	let fName1 = document.getElementById("fName1").value;
    	let title = $("#title").val();
    	let pwd = $("#pwd").val();
    	let maxSize = 1024 * 1024 * 30;   // 전체 30MByte 제한
    	
    	if(fName1.trim() == "") {
    		alert("업로드할 파일을 선택하세요!");
    		return false;
    	}
    	else if(title.trim() == "") {
    		alert("업로드할 파일의 제목을 입력하세요");
    		$("#title").focus()
    		return false;
    	}
    	else if(pwd.trim() == "") {
    		alert("비밀번호를 입력하세요");
    		$("#pwd").focus();
    		return false;
    	}
    	
    	// 파일 사이즈 처리
    	/* multiple형식이기 때문에 이렇게 꺼내 쓸 수 없음.
    	let fileSize = 0;
    	for(let i=1; i<=cnt; i++) {
    		let imsiName = 'fName' + i;
    		if(isNaN(document.getElementById(imsiName))) {
    			let fName = document.getElementById(imsiName).value;
	    		if(fName != "") {
	    			fileSize += document.getElementById(imsiName).files[0].size;
	    			let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
			    	if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'zip' && ext != 'hwp' && ext != 'ppt' && ext != 'pptx' && ext != 'xlsx') {
			    		alert("업로드 가능한 파일은 'jgp/gif/png/zip/hwp/ppt/pptx/xlsx' 만 가능합니다.");
			    		return false;
			    	}
	    		}
    		}
    	}
    	*/
    	
    	let fileSize = document.getElementById("fName1").files[0].size;
    	
    	if(fileSize > maxSize) {
    		alert("업로드할 파일의 최대용량은 20MByte입니다.");
    		return false;
    	}
    	else {
    		myform.fileSize.value = fileSize;
    		//alert("파일 사이즈 : " + fileSize);
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
  <form name="myform" method="post" enctype="multipart/form-data">
	  <h2 class="text-center">자 료 올 리 기</h2>
	  <br/>
	  <div>
	    <!-- <input type="button" value="파일박스추가" onclick="fileBoxAppend()" class="btn btn-info btn-sm mb-2"/> -->
	    <input type="file" name="file" id="fName1" multiple class="form-control-file border mb-2"/>
	  </div>
	  <!-- <div id="fileBoxAppend"></div> -->
	  <div class="mb-2">
	    올린이 : ${sNickName}
	  </div>
	  <div class="mb-2">
	    제목 : <input type="text" name="title" id="title" placeholder="자료의 제목을 입력하세요" class="form-control" required />
	  </div>
	  <div class="mb-2">
	    내용 : <textarea rows="4" name="content" id="content" placeholder="자료의 상세내역을 입력하세요" class="form-control"></textarea>
	  </div>
	  <div class="mb-2">
	    분류 :
	    <select name="part" id="part" class="form-control">
	    	<option value="기타">분류선택</option>
  	    <option ${part="학습" ? "selected" : ""}>학습</option>
  	    <option ${part="여행" ? "selected" : ""}>여행</option>
  	    <option ${part="음식" ? "selected" : ""}>음식</option>
  	    <option ${part="기타" ? "selected" : ""}>기타</option>
	    </select>
	  </div>
	  <div class="mb-2">
	    공개여부 :
	    <input type="radio" name="openSw" value="공개" checked />공개 &nbsp;&nbsp;
	    <input type="radio" name="openSw" value="비공개" />비공개
	  </div>
	  <div class="mb-2">
	    비밀번호 : <input type="password" name="pwd" id="pwd" value="1234" placeholder="비밀번호를 입력하세요" required />
	  </div>
	  <div>
	    <input type="button" value="자료올리기" onclick="fCheck()" class="btn btn-success"/>
	    <input type="reset" value="다시쓰기" class="btn btn-warning"/>
	    <input type="button" value="돌아가기" onclick="location.href='pdsList?part=${part}';" class="btn btn-primary"/>
	  </div>
	  <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
	  <input type="hidden" name="fileSize"/>
	  <input type="hidden" name="mid" value="${sMid}" />
	  <input type="hidden" name="nickName" value="${sNickName}" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>