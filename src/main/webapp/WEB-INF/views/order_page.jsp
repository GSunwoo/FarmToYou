<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>구매페이지</title>
	
  <!-- CSS -->
  <link rel="stylesheet" href="<c:url value='/css/order_page.css' />">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- 뷰포트 -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>

<!-- 다음(카카오) 우편번호 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
  // CART를 항상 배열로 생성 (단건/다건 동일)
  const CART = [
  <c:forEach var="row" items="${cart}" varStatus="st">
    {
      id: ${row.prod_id},
      prod_name: '<c:out value="${row.prod_name}" />',
      qty: ${row.prod_qty},
      price: ${row.prod_price}
    }<c:if test="${!st.last}">,</c:if> 
  </c:forEach>
  ];
  
</script>
<body>
<form action="" method="post" id="pay" ></form>
  <!-- 상단 유틸 -->
  
	
   <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <!-- 레이아웃 래퍼 -->
  <div class="mypage-wrapper">
    <!-- 좌측: 판매자 사이드바 -->
    <%-- <jsp:include page="/WEB-INF/views/common/header3.jsp">
      <jsp:param name="active" value="update" />
    </jsp:include> --%>
	<c:set var="total_price" value="0" />
	<c:forEach var="row" items="${cart}">
	  <c:set var="total_price" value="${total_price + (row.prod_price * row.prod_qty)}" />
	</c:forEach>
  <!-- ===================== 구매페이지 시작 ===================== -->
  <section class="order-wrap">
    <div class="order-grid">
      <!-- 좌측 -->
      <div class="order-left">
        <h2 class="weekly-title">구매페이지</h2>

        <!-- 배송지 -->
        <section class="card">
          <div class="card-hd">
            <strong>배송지 <span id="bar">|</span> <span id="recvName"><c:out value="${name}" default="이름"/></span></strong>
            <button type="button" class="btn-sm ghost" id="btnAddrEdit">배송지 변경</button>
          </div>
          <div class="card-bd">
            <span class="badge">최근배송지</span>
            <div class="addr-text" id="addrText">주소: <c:out value="${addr.addr1}" /> <c:out value="${addr.addr2}" /></div>
            <!-- <div class="addr-phone" id="addrPhone">휴대폰 : <c:out value="${phone_num}" /></div>  -->

            <!-- 화면 값 보관용 (DB 컬럼명 유지) -->
            <input type="hidden" name="name" value="<c:out value='${name}'/>">
            <!--              <input type="hidden" id="phone_num" name="phone_num" value="<c:out value='${phone_num}'/>">-->
            <input type="hidden" name="zipcode" value="<c:out value='${zipcode}'/>">
            <input type="hidden" name="addr1" value="<c:out value='${addr1}'/>">
            <input type="hidden" name="addr2" value="<c:out value='${addr2}'/>">
          </div>
        </section>
        <!-- 배송 요청사항 -->
        <section class="card">
          <div class="card-hd">
            <strong>배송 요청사항</strong>
            <button type="button" class="btn-sm ghost" id="btnReqEdit">변경</button>
          </div>
          <div class="card-bd">
            <div id="reqText"><c:out value="${delivery_msg}" default="문 앞"/></div>
            <input type="hidden" name="delivery_msg" id="delivery_msg" value="<c:out value='${empty delivery_msg ? "문 앞" : delivery_msg}'/>">
          </div>
        </section>

        <!-- JS가 배송 박스를 자동 생성 -->
        <div id="shipList"></div>
      </div>

      <!-- 우측: 최종 결제 금액 -->
      <aside class="order-right">
        <div class="bill card sticky">
          <div class="card-hd"><strong>최종 결제 금액</strong></div>
          <div class="card-bd">
            <div class="line">
              <span>총 상품 가격</span>
              <span id="sumProducts">
                <fmt:formatNumber value="${total_price}" type="number"/>원
              </span>
            </div>
            <div class="line"><span>배송비</span><span>0원</span></div>
            <hr>
            <div class="line total">
              <span>총 결제 금액</span>
              <span id="sumTotal">
                <fmt:formatNumber value="${total_price}" type="number"/>원
              </span>
            </div>
            <label class="agree">
              <input type="checkbox" id="agreeAll">
              <span>구매조건/결제대행 약관에 동의합니다.</span>
            </label>
            <button type="button" class="btn-lg solid" id="btnPay">결제하기</button> <!-- type을 submit으로 변경  -->
          </div>
        </div>
        <input type="hidden" id="total_price" name="total_price" value="${total_price}" />
      </aside>
    </div>
  </section>

  <!-- 주소 변경 모달 -->
  <div class="modal" id="modalAddr" aria-hidden="true">
    <div class="panel" role="dialog" aria-modal="true">
      <div class="panel-hd">배송지 변경</div>
      <div class="saved-addr-wrap" style="margin-bottom:12px">
  <strong>저장된 배송지</strong>
  <ul id="addrSavedList" class="saved-addr-list">
    <c:choose>
      <c:when test="${empty savedAddresses}">
        <li class="saved-addr-item">저장된 배송지가 없습니다.</li>
      </c:when>
      <c:otherwise>
        <c:forEach var="it" items="${savedAddresses}" varStatus="st"> 
          <li class="saved-addr-item">
            <label style="display:flex; gap:10px; width:100%; cursor:pointer">
              <input type="radio" name="${it.addr_id}" value="${st.index}"
                     data-addr_id	="${it.addr_id}"
                     data-zipcode="${it.zipcode}"
                     data-addr1="${it.addr1}"
                     data-addr2="${it.addr2}">
              <div>
                <div><strong>${it.addr_id}</strong> <span class="saved-addr-meta">(${it.phone_num})</span></div>
                <div>${it.zipcode} · ${it.addr1} ${it.addr2}</div>
              </div>
            </label>
          </li>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </ul>
</div>
      
      <div class="panel-bd">
        <input class="input-lg" id="m_recv" name="name" placeholder="받는분" value="<c:out value='${name}'/>">

        <!-- 휴대폰 3분할 입력 (010 고정 + 4자리 + 4자리) -->
       <!--  <div class="row" id="phoneRow">
          <input type="text" class="input-lg" value="010" readonly style="max-width:80px;">
          <input type="text" class="input-lg" id="phone2" maxlength="4" placeholder="####" required style="max-width:100px;">
          <input type="text" class="input-lg" id="phone3" maxlength="4" placeholder="####" required style="max-width:100px;">
        </div> -->

        <div class="row">
          <input class="input-lg" id="m_zip" name="zipcode" placeholder="우편번호" style="max-width:140px" value="<c:out value='${zipcode}'/>" readonly>
          <button class="btn-sm ghost" id="btnPost">우편번호 찾기</button>
        </div>
        <input class="input-lg" id="m_addr1" name="addr1" placeholder="기본주소" value="<c:out value='${addr1}'/>" readonly>
        <input class="input-lg" id="m_addr2" name="addr2" placeholder="상세주소" value="<c:out value='${addr2}'/>">
      </div>
      <div class="panel-ft">
        <button class="btn-sm ghost" data-close="#modalAddr">취소</button>
        <button class="btn-sm solid" id="saveAddr">적용</button>
      </div>
    </div>
  </div>

  <!-- 요청사항 모달 -->
  <div class="modal" id="modalReq" aria-hidden="true">
    <div class="panel" role="dialog" aria-modal="true">
      <div class="panel-hd">배송 요청사항</div>
      <div class="panel-bd">
        <select class="input-lg" id="reqSel">
          <option>문 앞</option>
          <option>경비실</option>
          <option>택배함</option>
          <option>직접수령</option>
          <option value="etc">기타(직접입력)</option>
        </select>
        <input class="input-lg" id="reqEtc" placeholder="요청사항 입력" style="display:none">
      </div>
      <div class="panel-ft">
        <button class="btn-sm ghost" data-close="#modalReq">취소</button>
        <button class="btn-sm solid" id="saveReq">저장</button>
      </div>
    </div>
  </div>
  <!-- ===================== 구매페이지 끝 ===================== -->
  <c:set var="orderName">
  <c:forEach var="row" items="${cart}" varStatus="st">
    <c:if test="${st.first}">
      <c:out value="${row.prod_name}" />
    </c:if>
    <c:if test="${fn:length(cart) > 1}">
      외 ${fn:length(cart) - 1}건
    </c:if>
  </c:forEach>
</c:set>
  <script>
  const totalPrice = document.getElementById("total_price").value;
  function openTossPage() {
	  const orderName = "${fn:trim(orderName)}"; 
	  window.open(
	    "/buyer/pay/checkout.do?orderName="+orderName+"&totalPrice="+totalPrice, 
	    "_blank",
	    "width=600,height=800,top=500,left=500,scrollbars=yes,resizable=yes"
	  );
	}
  </script>
  <!-- JS -->
  <script src="<c:url value='/js/order_page.js'/>" defer></script>
  
</body>
</html>
