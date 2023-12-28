<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>chart.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict' 
  	
  	function chartChange() {
  		let part = document.getElementById("part").value;
  		
  		let str = '';
  		if(part == "barV") {
  			str += '<form name="chartForm" method="post">';
  			str += '<table class="table table-bordered text-center">';
  			str += '<tr><th>차트 주제목</th><td colspan="4"><input type="text" name="title" class="form-control"></td></tr>';
  			str += '<tr><th>차트 부제목</th><td colsapn="4"><input type="text" name="subTitle" class="form-control"></td></tr>';
  			str += '<tr><th colspan="2">범례</th>';
  			str += '<td><input type="text" name="legend1" calss="form-control"></td>';
  			str += '<td><input type="text" name="legend2" calss="form-control"></td>';
  			str += '<td><input type="text" name="legend3" calss="form-control"></td>';
  			str += '</tr>';
  			str += '<tr>';
  			str += '<th>X축1</th>';
  			str += '<td><input type="text" name="x1" class="form-control" /></td>';
  			str += '<td><input type="number" name="x1Value1" class="form-control" /></td>';
  			str += '<td><input type="number" name="x1Value2" class="form-control" /></td>';
  			str += '<td><input type="number" name="x1Value3" class="form-control" /></td>';
  			str += '</tr>';
  			str += '<tr>';
  			str += '<th>X축2</th>';
  			str += '<td><input type="text" name="x2" class="form-control" /></td>';
  			str += '<td><input type="number" name="x2Value1" class="form-control" /></td>';
  			str += '<td><input type="number" name="x2Value2" class="form-control" /></td>';
  			str += '<td><input type="number" name="x2Value3" class="form-control" /></td>';
  			str += '</tr>';
  			str += '<tr>';
  			str += '<th>X축3</th>';
  			str += '<td><input type="text" name="x3" class="form-control" /></td>';
  			str += '<td><input type="number" name="x3Value1" class="form-control" /></td>';
  			str += '<td><input type="number" name="x3Value2" class="form-control" /></td>';
  			str += '<td><input type="number" name="x3Value3" class="form-control" /></td>';
  			str += '</tr>';
  			str += '<tr>';
  			str += '<th>X축4</th>';
  			str += '<td><input type="text" name="x4" class="form-control" /></td>';
  			str += '<td><input type="number" name="x4Value1" class="form-control" /></td>';
  			str += '<td><input type="number" name="x4Value2" class="form-control" /></td>';
  			str += '<td><input type="number" name="x4Value3" class="form-control" /></td>';
  			str += '</tr>';
  			str += '<tr>';
  			str += '<td colspan="5" class="text-center"><input type="button" value="차트그리기" onclick="chartShow(\'barV\')" class="btn btn-success" /></td>';
  			str += '</tr>';
  			str += '</table>';
  			str += '<input type="hidden" name="part" id="part" />';
  			str += '</form>';
  			
  			
  			$("#demo").html(str);
  		}
  	}
  	
  	function chartShow(part) {
  		if(part == 'barV') {
  			alert("part : " + part);
    		document.chartForm.part.value = part;
    		chartForm.submit();
  		}
  	}
  </script>
  <style>
  	th {
  		background-color: #eee;
  	}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>구글 차트를 활용한 분석예제</h2>
  <div>
  	<p>차트선택...
  		<select name="part" id="part" onchange="chartChange()">
  			<option value="">차트선택</option>
  			<option value="barV" ${vo.part == 'barV' ? 'selected' : ''}>수직막대차트</option>
  		</select>
  	</p>
  	<hr/>
  	<div id="demo"></div>
  	<hr/>
  	<div>
  		<c:if test="${vo.part == 'barV'}"><jsp:include page="barVChart.jsp" /></c:if>
  	</div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>