<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <title>판매자 마이페이지 - 판매자정보 변경신청</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />

  <!-- 공통 CSS -->
  <link href="<c:url value='/css/seller_mypage.css' />" rel="stylesheet" />
  <link href="<c:url value='/css/Dashboard.css' />" rel="stylesheet" />
  <!-- 페이지 CSS -->
  <link href="<c:url value='/css/sellerUpdateForm.css' />" rel="stylesheet" />
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<script src="<c:url value='/js/seller_myPage.js' />"></script>

<body class="simple-page">
<form id="seller" action="/seller/update.do" method="post">
  <!-- 상단 공통 헤더 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <!-- 레이아웃 래퍼 -->
  <div class="mypage-wrapper">
    <!-- 좌측: 판매자 사이드바 -->
    <jsp:include page="/WEB-INF/views/common/header3.jsp">
      <jsp:param name="active" value="update" />
    </jsp:include>

    <!-- 우측 컨텐츠 -->
    <main class="sub-content">
      <!-- ▼▼ 반드시 main.sub-content 내부에 위치 ▼▼ -->
      <div class="mypage-cont">
      <section class="seller-update-section">
        <div class="mypage-zone-tit"><h3>판매자 정보 변경 신청</h3></div>

        <form id="sellerUpdateForm" class="form-wrapper">
          <!-- 사업자등록번호 + 인증 -->
          <div class="form-line section-divider-top">
            <label for="bizNum">사업자등록번호</label>
            <div class="form-group">
              <!-- name 속성은 기존 DB 컬럼명으로 유지하세요 -->
              <input type="text" id="bizNum" placeholder="숫자만 입력" />
              <button type="button" id="btnVerify">인증</button>
            </div>
          </div>

          <!-- 대표자 / 상호 -->
          <div class="form-line">
            <label for="ceoName">대표자명</label>
            <div class="form-group">
              <input type="text" id="ceoName" readonly class="readonly" />
            </div>
          </div>
          <div class="form-line">
            <label for="companyName">상호</label>
            <div class="form-group">
              <input type="text" id="companyName" readonly class="readonly" />
            </div>
          </div>

          <!-- 주소 -->
          <!-- 사업장 주소 -->
            <div class="form-line">
              <label for="zipcode">사업장 주소</label>
              <div class="form-group">
                <input type="text" id="zipcode" name="com_zip" placeholder="우편번호" class="half-width" readonly />
                <input type="text" id="address" name="com_addr1" placeholder="기본주소" readonly />
                <input type="text" id="detailAddress" name="com_addr2" placeholder="상세주소" />
              </div>
            </div>

          <!-- 정산정보 -->
          <div class="form-line">
            <label for="managerName">예금주</label>
            <div class="form-group">
              <input type="text" id="managerName" name="entryman" readonly class="readonly" />
            </div>
          </div>
          <div class="form-line">
            <label for="accountNumber">정산 계좌</label>
            <div class="form-group account-group">
              <select id="bank" name="bank">
                <option value="">은행 선택</option>
                <option value="국민">국민</option>
                <option value="신한">신한</option>
                <option value="우리">우리</option>
                <option value="하나">하나</option>
              </select>
              <input type="text" id="accountNumber" name="account" readonly class="readonly"/>
            </div>
          	</div>
          	<div class="section-divider-top">
                <button type="submit" id="submitBtn" class="submit-btn" disabled>신청</button>
          </div>
        </form>
      </section>
      <!-- ▲▲ 반드시 main.sub-content 내부에 위치 ▲▲ -->
    </main>
  </div>
	</div>
  <!-- 페이지 스크립트: 본문 뒤에서 로드 -->
  <script src="<c:url value='/js/sellerUpdateForm.js' />"></script>
</body>
</html>
