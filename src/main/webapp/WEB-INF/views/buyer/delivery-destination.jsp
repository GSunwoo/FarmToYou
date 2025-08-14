<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>새 배송지 추가</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/delivery-destination.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- 다음(카카오) 우편번호 API -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="/js/delivery-destination.js"></script>
  
</head>
<body>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/header2.jsp" %>

<section class="order-wrap">
  <div class="order-grid">
    <div class="order-left">
      <h2 class="weekly-title">구매페이지</h2>

      <section class="card">
        <div class="card-hd">
          <strong>배송지</strong> <span class="bar">|</span> <span id="recvName">성명</span>
          <button type="button" class="btn-sm ghost" id="btnAddrEdit">배송지 변경</button>
        </div>
        <div class="card-bd">
          <span class="badge">최근배송지</span>
          <div class="addr-text" id="addrText">상세주소</div>
          <div class="addr-phone" id="addrPhone">휴대폰 : 010-1111-1111</div>
        </div>
      </section>
    </div>
  </div>
</section>

<!-- 주소 변경 모달 -->
<div class="modal" id="modalAddr" aria-hidden="true">
  <div class="panel" role="dialog" aria-modal="true">
    <div class="panel-hd">배송지 변경</div>
    <div class="panel-bd">
      <input class="input-lg" id="m_recv"  name="name"       placeholder="받는분"                 value="">
      <input class="input-lg" id="m_phone" name="phone_num"  placeholder="휴대폰(010-0000-0000)" value="">
      <div class="row">
        <input class="input-lg" id="m_zip"  name="zipcode"    placeholder="우편번호" style="max-width:140px" value="" readonly>
        <button class="btn-sm ghost" id="btnPost">우편번호 찾기</button>
      </div>
      <input class="input-lg" id="m_addr1" name="addr1" placeholder="기본주소" value="" readonly>
      <input class="input-lg" id="m_addr2" name="addr2" placeholder="상세주소" value="">
    </div>
    <div class="panel-ft">
      <button class="btn-sm ghost" data-close="#modalAddr">취소</button>
      <button class="btn-sm solid" id="saveAddr">적용</button>
    </div>
  </div>
</div>

</body>
</html>
