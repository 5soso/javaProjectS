<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>sample.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
  <script>
    var IMP = window.IMP;
    IMP.init("imp26872043");

  //function requestPay() {
    IMP.request_pay(
      {
        pg: "html5_inicis.INIBillTst",
       	//pg: "kakaopay.TC0ONETIME",
        pay_method: "card",
        merchant_uid: "javaProjectS10_" + new Date().getTime(),
        //name: "당근 10kg",
        name: "${vo.name}",
        //amount: 1004,
        amount: "${vo.amount}",
        //buyer_email: "Iamport@chai.finance",
        buyer_email: "${vo.buyer_email}",
        //buyer_name: "포트원 기술지원팀",
        buyer_name: "${vo.buyer_name}",
        //buyer_tel: "010-1234-5678",
        buyer_tel: "${vo.buyer_tel}",
        //buyer_addr: "서울특별시 강남구 삼성동",
        buyer_addr: "${vo.buyer_addr}",
        //buyer_postcode: "123-456",
        buyer_postcode: "${vo.buyer_postcode}",
      },
      function (rsp) {
        if(rsp.success) {
      	  alert("결재가 완료 되었습니다.");
      	  location.href = '${ctp}/study/payment/paymentOk';
        } else {
      	  alert("결재가 취소 되었습니다.");
      	  location.href = '${ctp}/study/payment/payment';
        }
      }
    );
  //}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <p>
  	<img src="${ctp}/images/payment.gif" />
  </p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>