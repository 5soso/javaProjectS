<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>lineChartVisitCount.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {'packages':['line']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('number', '${topTitle}');
      data.addColumn('number', '${legend}');

      data.addRows([
    	  <c:forEach var="i" begin="0" end="7" varStatus="st">
    	    [${visitDays[7-i]}, ${visitCounts[7-i]}],
    	  </c:forEach>
      ]);

      var options = {
        chart: {
          title: '${title}',
          subtitle: '${subTitle}'
        },
        width: 800,
        height: 500,
        axes: {
          x: {
            0: {side: 'top'}
          }
        }
      };

      var chart = new google.charts.Line(document.getElementById('line_top_x'));

      chart.draw(data, google.charts.Line.convertOptions(options));
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>꺽은선 차트</h2>
  <div id="line_top_x"></div>
</div>
</body>
</html>