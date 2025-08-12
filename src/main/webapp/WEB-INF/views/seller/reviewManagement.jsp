<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>판매자 마이페이지 - 리뷰 관리</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <!-- 공통 CSS -->
  <link href="<c:url value='/css/seller_mypage.css' />" rel="stylesheet" />
  <link href="<c:url value='/css/Dashboard.css' />" rel="stylesheet" />
  <!-- 페이지 CSS -->
  <link href="<c:url value='/css/reviewManagement.css' />" rel="stylesheet" />
</head>

<body class="simple-page">
  <!-- 상단 공통 헤더 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <div class="mypage-wrapper">
    <!-- 판매자 전용 사이드바 -->
    <form id="seller" method="post" action="/seller/mypage.do">
    <jsp:include page="/WEB-INF/views/common/header3.jsp">
      <jsp:param name="active" value="reviews" />
    </jsp:include>

    <!-- 우측 컨텐츠 -->
    <main class="sub-content">
      <section class="review-management-page">
        <h3>리뷰 관리</h3>

        <!-- 리뷰 목록 -->
        <div class="review-grid" id="reviewGrid">
          <!-- JS에서 데이터 렌더링 -->
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination" id="pageNumbers">
          <button class="rm-page__first">&lt;&lt;</button>
          <button class="rm-page__prev">&lt;</button>
          <!-- 페이지 번호 버튼 생성 -->
          <button class="rm-page__next">&gt;</button>
          <button class="rm-page__last">&gt;&gt;</button>
        </div>

        <!-- 리뷰 모달 -->
        <div id="reviewModal" class="modal" hidden>
          <div class="modal-content">
            <span class="modal-close">&times;</span>
            <div class="modal-body">
              <!-- JS에서 리뷰 상세 출력 -->
            </div>
          </div>
        </div>
      </section>
    </main>
  </div>

  <!-- 페이지 스크립트 -->
  <script src="<c:url value='/js/reviewManagement.js' />"></script>
</body>
</html>
