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

<section class="order-wrap">
  <div class="order-grid">
    <div class="order-left">
      <h2 class="weekly-title">배송지 관리</h2>

      <section class="card">
        <div class="card-hd">
          <strong>배송지</strong> <span class="bar">|</span> <span id="recvName">${AddressDTO.name }</span>
          <button type="button" class="btn-sm ghost" id="btnAddrEdit">배송지 변경</button>
          <button type="button" class="btn-sm solid" id="btnAddrNew" style="margin-left:8px">새 배송지 추가</button>
          
        </div>
        <div class="card-bd">
          <span class="badge">최근배송지</span>
          <div class="addr-text" id="addrText">
          	<c:choose>
          		<c:when test="${not empty AddressDTO }">
          			<c:out value="${AddressDTO.addr1 }" /> <c:out value="${AddressDTO.addr2 }" /> 
          		</c:when>
          		<c:otherwise>상세주소</c:otherwise>
          	</c:choose>
        </div>
        <div class="addr-phone" id="addrPhone">
        	휴대폰 : 
        	<c:choose>
        		<c:when test="${not empty AddressDTO }">
        			<c:out value="${AddressDTO.phone_num }" />
        		</c:when>
        		<c:otherwise>010-1111-1111</c:otherwise>
        	</c:choose>
        </div>
        </div>
      </section>
    </div>
  </div>
</section>

<!-- 주소 변경 모달 -->
<!-- 임시 액션 경로 저장 나중에 컨트롤러 확인, js확인, 그리고 내일 dto 맞는지확인, ajax를 사용 json으로 받을거임 -->
	<div class="modal" id="modalAddr" aria-hidden="true">
	  <div class="panel" role="dialog" aria-modal="true">
	    <div class="panel-hd">배송지 변경</div>
	    <div class="panel-bd">
	      <input class="input-lg" id="m_recv"  name="name"       placeholder="받는분"                value="${AddressDTO.name }">
	      <input class="input-lg" id="m_phone" name="phone_num"  placeholder="휴대폰(010-0000-0000)" value="${AddressDTO.phone_num }">
	      <div class="row">
	        <input class="input-lg" id="m_zip"  name="zipcode"    placeholder="우편번호" style="max-width:140px" value="${AddressDTO.zipcode }" readonly>
	        <button class="btn-sm ghost" id="btnPost">우편번호 찾기</button>
	      </div>
	      <input class="input-lg" id="m_addr1" name="addr1" placeholder="기본주소" value="${AddressDTO.addr1 }" readonly>
	      <input class="input-lg" id="m_addr2" name="addr2" placeholder="상세주소" value="${AddressDTO.addr2 }">
	    </div>
	    <div class="panel-ft">
	      <button type="button" class="btn-sm ghost" data-close="#modalAddr">취소</button>
	      <button type="button" class="btn-sm solid" id="saveAddr">적용</button>
	    </div>
	  </div>
	</div>
<!-- 새 배송지 추가 모달 -->
	<div class="modal" id="modalAddrNew" aria-hidden="true">
		<div class="panel" role="dialog" aria-modal="true">
			<div class="panel-hd">새 배송지 추가</div>
			<div class="panel-bd">
				<input class="input-lg" id="n_recv" name="name" placeholder="받는분">
				<input class="input-lg" id="n_phone" name="phone_num" placeholder="휴대폰(010-0000-0000)">
				<div class="row">
					<input class="input-lg" id="n_zip" name="zipcode" placeholder="우편번호" style="max-width:140px" readonly/>
					<button class="btn-sm ghost" id="btnPostNew" type="button">우편번호 찾기</button>
				</div>
				<input class="input-lg" id="n_addr1" name="addr1" placeholder="기본주소" readonly>
				<input class="input-lg" id="n_addr2" name="addr2" placeholder="상세주소">
			</div>
			<div class="panel-ft">
				<button type="button" class="btn-sm ghost" data-close="#modalAddrNew">취소</button>
				<button type="button" class="btn-sm solid" id="saveAddrNew">저장</button>
			</div>
		</div>
	
	</div>
</body>
</html>
