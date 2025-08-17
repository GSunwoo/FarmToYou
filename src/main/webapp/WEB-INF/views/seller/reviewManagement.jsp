<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>리뷰 관리</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <!-- 공통 스타일 -->
  <script src="<c:url value='/js/seller_myPage.js' />"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reviewManagement.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>

<body class="simple-page">
    <!-- 상단 공통 헤더 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <!-- 레이아웃 래퍼 -->
    <div class="mypage-wrapper">
      <!-- 좌측: 판매자 전용 사이드바 -->
  <main class="sub-content">
      <jsp:include page="/WEB-INF/views/common/header3.jsp">
        <jsp:param name="active" value="reviewManagement" />
      </jsp:include>
	<main class="sub-content">
    <div class="mypage-cont">
    <div class="rm-wrap">
      <div class="mypage-info">
        <div class="mypage-zone-tit">
          <h3>리뷰</h3>
        </div>

        <!-- 리뷰 관리 섹션 -->
        <section id="review-section" class="rm-wrap" aria-label="리뷰 관리">
          <header class="rm-header">
            <h3 class="rm-title">리뷰 관리</h3>
          </header>

          <!-- 3×5 그리드 -->
          <ul id="reviewGrid" class="rm-grid" aria-live="polite" aria-busy="false"></ul>

          <!-- 페이지네이션 -->
          <nav class="rm-pagination" aria-label="페이지">
            <button class="rm-page__first is-hidden" data-action="first" hidden aria-label="첫 페이지로 이동">«</button>
            <button class="rm-page__prev is-hidden" data-action="prev" hidden aria-label="이전 페이지">‹</button>
            <ol id="pageNumbers" class="rm-page__list"></ol>
            <button class="rm-page__next" data-action="next" aria-label="다음 페이지">›</button>
          </nav>
        </section>

        <!-- 모달 -->
        <div id="reviewModal" class="rm-modal" role="dialog" aria-modal="true" aria-labelledby="rmModalTitle" hidden>
          <div class="rm-modal__overlay" data-close="overlay"></div>
          <div class="rm-modal__dialog">
            <button type="button" class="rm-modal__close" aria-label="닫기" data-close="x">×</button>

            <div class="rm-modal__content">
              <div class="rm-modal__left">
                <figure class="rm-modal__figure">
                  <img id="rmModalImage" class="rm-modal__img" src="" alt="리뷰 이미지" />
                </figure>
              </div>

              <div class="rm-modal__right">
                <header class="rm-modal__header">
                  <div class="rm-modal__product-top">
                    <a id="rmModalProductLink" class="rm-modal__product-link" href="#">
                      상품명(링크 자리)
                    </a>
                  </div>
                  <h4 id="rmModalTitle" class="rm-modal__title">리뷰 제목</h4>
                  <div class="rm-modal__rating" data-rating="5" aria-label="별점 5점 만점"></div>
                  <div class="rm-modal__meta">
                    <span id="rmModalAuthor" class="rm-modal__author">작성자명</span>
                    <time id="rmModalDate" class="rm-modal__date" datetime=""></time>
                  </div>
                </header>

                <article id="rmModalContent" class="rm-modal__body">
                  리뷰 본문 내용
                </article>

                <footer class="rm-modal__footer">
                  <button id="rmHelpBtn" class="rm-help" data-action="like" data-like-url-base="/guest/review/api"
                    data-review-id="">
                    도움이 됐어요 <span id="rmHelpCount" class="rm-help__count">0</span>
                  </button>
                </footer>
              </div>
            </div>
          </div>
        </div>
		</div>
      </div>
    </div>
    </div>
    </div>
  </main>

  <!-- 리뷰 관리 전용 JS -->
  <script src="${pageContext.request.contextPath}/js/reviewManagement.js"></script>
</body>
</html>
