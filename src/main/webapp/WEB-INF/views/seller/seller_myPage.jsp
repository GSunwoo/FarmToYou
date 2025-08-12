<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <title>판매자 마이페이지 - 모니터링</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />

  <!-- CSS -->
  <link href="<c:url value='/css/seller_mypage.css' />" rel="stylesheet" />
  <link href="<c:url value='/css/Dashboard.css' />" rel="stylesheet" />

  <!-- Chart.js (판매 통계용) -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
  <!-- 페이지용 JS -->
  <script src="<c:url value='/js/seller_myPage.js' />"></script>
</head>

<body class="simple-page">
    <form id="seller" method="post" action="/seller/mypage.do">
  <!-- 상단 공통 헤더 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <!-- 레이아웃 래퍼 -->
  <div class="mypage-wrapper">
    <!-- 좌측: 판매자 전용 사이드바 (header3.jsp는 '사이드바만' 출력하도록 구성) -->
    <jsp:include page="/WEB-INF/views/common/header3.jsp">
      <jsp:param name="active" value="monitor" />
    </jsp:include>

    <!-- 우측 컨텐츠 -->
    <main class="sub-content">
      <div class="mypage-cont">
        <div class="mypage-info">
          <div class="mypage-zone-tit">
            <h3>모니터링</h3>
          </div>

          <div class="dashboard-wrapper-2rows">
            <!-- 1행: 스마트팜 모니터링 -->
            <div class="card card-full">
              <h2 class="card-title">스마트팜 모니터링</h2>
            </div>

            <!-- 2행 왼쪽: 판매 통계 -->
            <div class="card card-half">
              <h2 class="card-title">판매 통계</h2>
              <div class="chart-wrap">
                <canvas id="salesRevenueChart"></canvas>
              </div>
            </div>

            <!-- 2행 오른쪽: 이미지 + 판정결과 -->
            <div class="card card-half">
              <h2 class="card-title">최근 등록된 농작물</h2>
              <div id="cropContainer">
                <div class="loading-text">농작물 정보를 불러오는 중...</div>
              </div>
              <div class="update-time" id="updateTime" style="display:none;"></div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</body>
</html>
