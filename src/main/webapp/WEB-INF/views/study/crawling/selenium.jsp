<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>selenium.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';

    function crawlingCheck() {
      $("#spinnerIcon").show();

      $.ajax({
        type  : "post",
        url   : "${ctp}/study/crawling/selenium",
        success:function(vos) {
          $("#demo").show();
          if(vos != "") {
            let str = '';
            str += '<table class="table table-bordered text-center"><tr class="table-dark text-dark"><th>영화제목</th><th>포스터</th><th>예매율</th></tr>';
            for(let i=0; i<vos.length; i++) {
              str += '<tr>';
              str += '<td>'+vos[i].title+'</td>'; //vos[i] = map의 .title = 키
              str += '<td>'+vos[i].image+'</td>';
              str += '<td>'+vos[i].percent+'</td>';
              str += '</tr>';
            }
            str += '</tr></table>';
            $("#demo").html(str);

            $("#spinnerIcon").hide();
          }
          else $("#demo").html("검색자료가 없습니다.");

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
  <h2>selenium를 이용한 크롤링</h2>
  <hr/>
  <form name="myform" method="post">
    <div class="input-group mb-3">
      <div class="input-group-prepend"><input type="button" value="새로고침" onclick="location.reload()" class="btn btn-info" /></div>
      <span class="input-group-text" style="width:50%">CGV 상영관 뮤비차트</span>
      <div class="input-group-append mr-4"><input type="button" value="웹크롤링" onclick="crawlingCheck()" class="btn btn-success" /></div>
      <div class="input-group-append"><span id="spinnerIcon" style="display:none"><span class="spinner-border"></span>검색중입니다.<span class="spinner-border"></span></span></div>
    </div>
  </form>
  <hr/>
  <div id="demo" style="width:100%;height:700px;overflow:auto;border:1px solid gray;display:none"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>