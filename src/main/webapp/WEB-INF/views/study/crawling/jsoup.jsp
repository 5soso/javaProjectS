<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jsoup.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    function crawling() {
    	let url = document.getElementById("url").value;
    	let selector = document.getElementById("selector").value;
    	
    	if(url.trim() == "") {
    		alert("웹크롤링할 주소를 입력하세요");
    		document.getElementById("url").focus();
    		return false;
    	}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/study/crawling/jsoup",
    		data  : {
    			url : url.substring(url.indexOf(".")+1),
    			selector : selector.substring(selector.indexOf(".")+1)
    		},
    		success:function(vos) {
    			//console.log(vos);
    			$("#demo").show();
    			if(vos != "") {
    				let str = '';
    				for(let i=0; i<vos.length; i++) {
    					str += vos[i] + '<br/>';
    				}
    				$("#demo").html(str);
    			}
    			else $("#demo").html("검색된 자료가 없습니다.");
    		},
    		error : function() {
    			alert("전송오류!!");
    		}
    	});
    }
    
    $(function() {
    	
    	$("#url").change(function() {
	    	let url = document.querySelector("select[name=url]");
	    	let urlNo = url.options[url.selectedIndex].text.substring(0,url.options[url.selectedIndex].text.indexOf("("));
	    	
	    	let temp = '<option>';
	    	let selector = document.myform.selector;
	    	for(let i=0; i<selector.length; i++) {
	    		if(urlNo == selector[i].value.substring(0,selector[i].value.indexOf("."))) {
	    			temp += selector[i].value;
	    			break;
	    		}
	    	}
	    	temp += "</option>";
	    	$("#selector").html(temp);
	    	url = "<option>" + url.value + "</option>";
	    	$("#url").html(url);
    	});
	    	
    });
    	
    function naverSearch() {
    	let searchString = document.getElementById("searchString").value;
    	if(searchString.trim() == "") {
    		alert("검색어를 입력하세요");
    		document.getElementById("searchString").focus();
    		return false;
    	}
    	let page = document.getElementById("page").value;
    	let search = "https://search.naver.com/search.naver?nso=&page="+page+"&query="+searchString+"&sm=tab_pge&start="+(page*15)+"&where=web";
    	let searchSelector = document.getElementById("searchSelector").value;
    	let query = {
    			search : search,
    			searchSelector : searchSelector
    	}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/study/crawling/naverSearch",
    		data  : query,
    		success:function(vos) {
    			//console.log(vos);
    			$("#demo").show();
    			if(vos != "") {
    				let str = '';
    				for(let i=0; i<vos.length; i++) {
    					str += vos[i] + '<br/>';
    				}
    				$("#demo").html(str);
    			}
    			else $("#demo").html("검색된 자료가 없습니다.");
    		},
    		error : function() {
    			alert("전송오류!!");
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
  <h2>jsoup를 이용한 웹 크롤링</h2>
  <hr/>
  <form name="myform">
    <div class="input-group mb-3">
      <div class="input-group-prepend"><span class="input-group-text">클롤링할 웹 주소</span></div>
      <!-- <input type="text" name="url" id="url" value="https://news.naver.com/" class="form-control"/> -->
      <select name="url" id="url" class="form-control">
        <option value="">URL을 선택하세요</option>
        <option>1(네이버뉴스).https://news.naver.com</option>
        <option>2(네이버뉴스).https://news.naver.com</option>
        <option>3(다음 영화순위).https://movie.daum.net/ranking/reservation</option>
        <option>4(다음 영화순위).https://movie.daum.net/ranking/reservation</option>
        <option>5(다음 영화순위).https://movie.daum.net/ranking/reservation</option>
      </select>
      <div class="input-group-append"><input type="button" value="새로고침" onclick="location.reload()" class="btn btn-success"/></div>
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend"><span class="input-group-text">검색할 셀렉터 내용</span></div>
      <select name="selector" id="selector" class="form-control">
        <option value="">셀렉터를 선택하세요</option>
        <option>1.div.cjs_t</option>
        <option>2.div.cjs_news_mw</option>
        <option>3.div.item_poster</option>
        <option>4.div.thumb_cont</option>
        <option>5.div.thumb_cont .tit_item</option>
      </select>
      <div class="input-group-append"><input type="button" value="크롤링" onclick="crawling()" class="btn btn-success"/></div>
    </div>
    <hr/>
    <div class="input-group mb-3">
      <div class="input-group-prepend"><span class="input-group-text">네이버 검색어</span></div>
      <input type="text" name="searchString" id="searchString" value="서울의봄" class="form-control"/>
      <div class="input-group-append"><input type="reset" value="다시입력" onclick="location.reload()" class="btn btn-primary"/></div>
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend"><span class="input-group-text">검색할 페이지</span></div>
      <input type="number" name="page" id="page" value="1" class="form-control"/>
      <div class="input-group-append"><input type="reset" value="다시입력" class="btn btn-primary"/></div>
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend"><span class="input-group-text">검색할 셀렉터</span></div>
      <input type="text" name="searchSelector" id="searchSelector" value="div.total_dsc_wrap" class="form-control"/>
      <div class="input-group-append"><input type="button" value="검색" onclick="naverSearch()" class="btn btn-primary"/></div>
    </div>
  </form>
  <hr/>
  <div id="demo" style="width:100%;height:600px;overflow:auto;border:1px solid gray;display:none;"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>