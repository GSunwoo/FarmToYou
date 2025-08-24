<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>구매페이지</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <!-- CSS -->
  <link rel="stylesheet" href="<c:url value='/css/mainpage.css' />">
  <link rel="stylesheet" href="<c:url value='/css/order_page.css' />">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
<%@ include file="./common/header.jsp"%>
<form action="" method="post" id="pay"></form>

<div class="mypage-wrapper">
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
            <strong>배송지</strong>
            <button type="button" class="btn-sm ghost" id="btnAddrEdit">배송지 변경</button>
          </div>
          <div class="card-bd">
            <span class="badge">최근배송지</span>
            <div class="addr-text" id="addrText">
              주소:
              <c:out value="${addr.addr1}" />
              <c:if test="${not empty addr.addr2}"> <c:out value="${addr.addr2}" /></c:if>
            </div>

            <!-- 화면 값 보관용 (DB 컬럼명 유지) -->
            <input type="hidden" name="zipcode" value="<c:out value='${zipcode}'/>">
            <input type="hidden" name="addr1"   value="<c:out value='${addr1}'/>">
            <input type="hidden" name="addr2"   value="<c:out value='${addr2}'/>">
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
            <input type="hidden" name="delivery_msg" id="delivery_msg"
                   value="<c:out value='${empty delivery_msg ? "문 앞" : delivery_msg}'/>">
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
            <button type="button" class="btn-lg solid" id="btnPay">결제하기</button>
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

      <!-- ✅ 저장된 배송지 목록 -->
      <div class="saved-addr-wrap" style="margin-bottom:12px">
        <strong>저장된 배송지</strong>
        <ul id="addrSavedList" class="saved-addr-list">
		  <c:choose>
		    <c:when test="${empty savedAddresses}">
		      <li class="saved-addr-item">저장된 배송지가 없습니다.</li>
		    </c:when>
		    <c:otherwise>
		      <c:forEach var="it" items="${savedAddresses}">
		        <li class="saved-addr-item">
		          <label style="display:flex; gap:10px; width:100%; cursor:pointer">
		            <input type="radio" name="addr_pick" value="${it.addr_id}"
		                   data-addr_id="${it.addr_id}"
		                   data-zipcode="${it.zipcode}"
		                   data-addr1="${fn:escapeXml(it.addr1)}"
		                   data-addr2="${fn:escapeXml(it.addr2)}">
		            <div>
		              <div>
		                <strong><c:out value="${it.main == 1 ? '기본배송지' : '배송지'}"/></strong>
		              </div>
		              <div>[<c:out value="${it.zipcode}"/>] <c:out value="${it.addr1}"/> <c:out value="${it.addr2}"/></div>
		            </div>
		          </label>
		        </li>
		      </c:forEach>
		    </c:otherwise>
		  </c:choose>
		</ul>
      </div>

      <div class="panel-bd">
        <div class="row">
          <input class="input-lg" id="m_zip"  name="zipcode" placeholder="우편번호" style="max-width:140px"
                 value="<c:out value='${zipcode}'/>" readonly>
          <button class="btn-sm ghost" id="btnPost" type="button">우편번호 찾기</button>
        </div>
        <input class="input-lg" id="m_addr1" name="addr1" placeholder="기본주소" value="<c:out value='${addr1}'/>" readonly>
        <input class="input-lg" id="m_addr2" name="addr2" placeholder="상세주소" value="<c:out value='${addr2}'/>">
      </div>

      <div class="panel-ft">
        <button class="btn-sm ghost" data-close="#modalAddr" type="button">취소</button>
        <button class="btn-sm solid" id="saveAddr" type="button">적용</button>
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
        <button class="btn-sm ghost" data-close="#modalReq" type="button">취소</button>
        <button class="btn-sm solid" id="saveReq" type="button">저장</button>
      </div>
    </div>
  </div>
  <!-- ===================== 구매페이지 끝 ===================== -->
</div>

<!-- 주문명 빌드 (필요 시 사용) -->
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
<%
    String wishListJson = new com.fasterxml.jackson.databind.ObjectMapper()
                             .writeValueAsString(request.getAttribute("wishList"));
%>
<script>
  // 문자열 라인브레이크 제거
  const orderName =
`<c:forEach var="row" items="${cart}" varStatus="st"><c:if test="${st.first}">
${row.prod_name}
<c:if test="${(fn:length(cart) - 1)>0}">
 외 ${fn:length(cart) - 1}건
</c:if>
</c:if>
</c:forEach>`.replace(/(\r\n|\n|\r)/g, "");
  window.orderName = orderName;

  // ===== 모달/주소 선택 동작(간단 버전) =====
  const $  = (s, el=document) => el.querySelector(s);
  const openM  = sel => $(sel)?.classList.add('on');
  const closeM = sel => $(sel)?.classList.remove('on');

  // 배송지 변경 버튼 → 모달 열기
  $('#btnAddrEdit')?.addEventListener('click', () => openM('#modalAddr'));

  // 모달 닫기
  document.querySelectorAll('#modalAddr [data-close="#modalAddr"]').forEach(btn => {
    btn.addEventListener('click', () => closeM('#modalAddr'));
  });

  // 저장된 배송지 라디오 선택 → 모달 입력칸에 채우기
  $('#addrSavedList')?.addEventListener('change', (e) => {
    const r = e.target.closest('input[type="radio"][name="addr_pick"]');
    if (!r) return;
    $('#m_zip').value   = r.dataset.zipcode || '';
    $('#m_addr1').value = r.dataset.addr1   || '';
    $('#m_addr2').value = r.dataset.addr2   || '';
  });

  // 우편번호 찾기
  $('#btnPost')?.addEventListener('click', (e) => {
    e.preventDefault();
    new daum.Postcode({
      oncomplete(data) {
        $('#m_zip').value   = data.zonecode || '';
        $('#m_addr1').value = data.roadAddress || data.jibunAddress || '';
        $('#m_addr2').focus();
      }
    }).open();
  });

  // 적용 → 본문 표시 + 히든 값 반영 + 모달 닫기
  $('#saveAddr')?.addEventListener('click', (e) => {
    e.preventDefault();
    const zip  = $('#m_zip').value.trim();
    const a1   = $('#m_addr1').value.trim();
    const a2   = $('#m_addr2').value.trim();
    if (!zip || !a1) {
      alert('우편번호/기본주소를 확인해 주세요.');
      return;
    }

    // 화면 표시 업데이트
    $('#addrText').textContent = `주소: ${a1} ${a2}`;

    // 히든 값(DB 컬럼명 유지)
    document.querySelector('input[name="zipcode"]').value = zip;
    document.querySelector('input[name="addr1"]').value    = a1;
    document.querySelector('input[name="addr2"]').value    = a2;

    // 모달 닫기
    closeM('#modalAddr');
  });
  
  window.wishList = JSON.parse('<%= wishListJson %>');
</script>

<!-- 외부 JS 사용 시 (inline 대신) -->
<script src="<c:url value='/js/order_page.js'/>"></script>
</body>
</html>
