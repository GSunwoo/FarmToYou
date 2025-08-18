<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>판매자 마이페이지 - 모니터링</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<!-- CSS -->
<link rel="stylesheet" href="<c:url value='/css/seller_mypage.css'/>">
<link rel="stylesheet" href="<c:url value='/css/Dashboard.css'/>">

<!-- Chart.js (판매 통계용) -->
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<!-- 페이지용 JS -->
<script src="<c:url value='/js/seller_myPage.js' />" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
						

						
							<!-- 1) 스마트팜 (판정결과가 이 카드 안에 들어감) -->
							<div class="card card-full">
								<h2 class="card-title">스마트팜 모니터링</h2>
								<div id="cropResultWrap"></div>
								<!-- ← 배지 표시 위치 -->
								<div class="update-time" id="updateTime" style="display: none;"></div>
								<!-- 시간 표시도 여기 -->
							</div>

							<!-- 상품 문의 현황 -->
							<div class="card card-half">
								<h2 class="card-title">상품 문의 현황</h2>
								<div class="stat-wrap">
									<div class="stat-num">
										<c:out value="${inquiryCnt_seller}" default="0" />
									</div>
									<div class="stat-label">현재 문의 수</div>
									<!-- 문의 관리 페이지 링크가 있으면 연결 -->
									<!-- <a class="stat-link" href="<c:url value='/seller/inquiries'/>">자세히 보기</a> -->
								</div>
							</div>
							<!-- 2) 판매 통계 -->
							<div class="card card-half">
								<h2 class="card-title">판매 통계</h2>
								<div class="chart-wrap">
									<canvas id="salesRevenueChart"
										data-api-url="<c:url value='/seller/api/sold-stats' />"></canvas>
								</div>
							</div>

							<!-- 3) 최근 등록된 농작물 (이미지만) -->
							<div class="card card-half">
								<h2 class="card-title">최근 등록된 농작물</h2>
								<div id="cropImageWrap">
									<div class="loading-text">농작물 정보를 불러오는 중...</div>
								</div>
							</div>
						

					</div>
			</main>
		</div>
</body>
</html>
