<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>판매자 마이페이지 - 모니터링</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<!-- 기존 공통 CSS -->
<link rel="stylesheet" href="<c:url value='/css/seller_mypage.css'/>">
<link rel="stylesheet" href="<c:url value='/css/Dashboard.css'/>">
<link rel="stylesheet" href="<c:url value='/css/myPageMain.css'/>">
<link rel="stylesheet" href="<c:url value='/css/mainpage.css'/>">
<!-- 모니터 전용 CSS (아래 제공) -->
<link rel="stylesheet" href="<c:url value='/css/ai/ai.css'/>">
<!-- 아이콘/차트(필요 시) -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 페이지 스크립트 -->
<script>
	// 컨텍스트 경로 & Flask 예측 API 엔드포인트 (ai.js에서 사용)
	const contextPath = "${pageContext.request.contextPath}";
	window.FLASK_PREDICT_URL = "http://127.0.0.1:8587/predict"; // 필요 시 환경에 맞게 변경
</script>
</head>

<body class="simple-page">
	<!-- 상단 공통 헤더 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="mypage-wrapper">
    <div class="sub-content">
       <aside class="mypage-sidebar">
           <%@ include file="../common/header3.jsp"%>
       </aside>
       </div>

		<!-- 우측 컨텐츠 -->
		<main class="sub-content">
			<div class="mypage-cont">
				<div class="mypage-zone-tit">
					<h3>스마트팜 모니터링</h3>
				</div>

				<div class="dashboard-wrapper-2rows">
					<!-- 모니터링 카드 -->
					<section class="card card-full">
						<div class="card-head">
							<h2 class="card-title">
								<i class="fa-solid fa-seedling"></i> 실시간 판별
							</h2>
							<div class="monitor-controls">
								<button class="btn btn-primary" id="startBtn">모니터링 시작</button>
								<button class="btn btn-light" id="stopBtn"
									style="display: none;">모니터링 중단</button>
							</div>
						</div>

						<div class="monitor-status">
							<span id="statusDot" class="dot idle"></span> <span id="status">대기중...</span>
							<span id="update-time" class="lastUpdate" style="display: none;"></span>
						</div>

						<!-- 결과 영역 -->
						<div id="cropResultWrap">
							<!-- ai.js가 카드들을 채움 -->
							<div id="imageResult" class="monitor-grid"></div>
						</div>
					</section>

					<!-- (예시) 다른 카드들: 문의/통계/최근등록 등은 기존 페이지와 동일 -->
					<!-- 필요 시 그대로 유지 -->
				</div>
			</div>
		</main>
	</div>
	<script src="${pageContext.request.contextPath}/js/ai/ai.js"></script>
</body>
</html>
