<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 홈페이지 메인</title>
<!-- 필요한 스타일 -->
<link rel="stylesheet" href="/css/mainpage.css">
<!-- 돋보기, 별 css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

</head>

<body>
	<%@ include file="./common/header.jsp"%>

	<section>
		<div class="review-hero-cont">
			<div class="rhc-wrapper">
				<h3>
					베스트 리뷰로 <br /> 선정된 리뷰들입니다.
				</h3>
				<p>
					생생한 리뷰를 작성해 주시면, 베스트 리뷰로 선정됩니다. <br /> 많은 관심 부탁드립니다.
				</p>
			</div>

			<div class="review-best-items">

				<div class="review-top-card">
					<div class="review-info">
						<div class="review-img">
							<img src="${best.image}" alt="${best.title }" />
						</div>
						<div class="rating">
							<c:forEach var="i" begin="1" end="5">
								<c:choose>
									<!-- 백에서 연결하는 rating 값 교체 -->
									<c:when test="${i <= best.rating }">
										<i class="fa-solid fa-star"></i>
										<!-- 채운 별 -->
									</c:when>
									<c:otherwise>
										<i class="fa-regular fa-star"></i>
										<!-- 빈 별 -->
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
					<div class="review-content">
						<!-- 백에서 연결하는 내용 dto 받기 -->
						<p>simple date</p>
					</div>
					<div class="review-author">
						<%-- review.date 가 java.util.Date/java.time 이라면 바로 포맷 --%>
						<fmt:formatDate value="${best.date}" pattern="yyyy-MM-dd"
							var="isoBest" />
						<fmt:formatDate value="${best.date}" pattern="yyyy년 M월 d일"
							var="humanBest" />

						<time class="review-date" datetime="${isoBest}">${humanBest}</time>
						<!-- 백에서 연결하는 이름 dto 받기 -->
						<div class="title">
							<span class="author">김영*님</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="review-grid-lists">
			<!-- 임시확인용. 백엔드에서 제어시 비긴,앤드 제거 -->
			<c:forEach var="review" items="${reviewList }" begin="0" end="4">
				<div class="review-cards">
					<div class="review-imgs">
						<img src="${review.image }" alt="${review.title }" />
					</div>

					<div class="bottom-rating">
						<c:forEach var="i" begin="1" end="5">
							<c:choose>
								<!-- 백에서 연결하는 rating 값 교체 -->
								<c:when test="${i <= review.rating }">
									<i class="fa-solid fa-star"></i>
									<!-- 채운 별 -->
								</c:when>
								<c:otherwise>
									<i class="fa-regular fa-star"></i>
									<!-- 빈 별 -->
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
					<div class="review-bottom-content">
						<!-- 백에서 연결하는 내용 dto 받기 -->
						<p>simple date</p>
					</div>
					<div class="review-bottom-author">
						<!-- 백에서 연결하는 날짜 dto 받기 -->
						<%-- review.date 가 java.util.Date/java.time 이라면 바로 포맷 --%>
						<fmt:formatDate value="${review.date}" pattern="yyyy-MM-dd"
							var="iso" /> <!-- 기계식 표현 yyyy-MM-dd -->
						<fmt:formatDate value="${review.date}" pattern="yyyy년 M월 d일"
							var="human" /> <!-- 사람용 표현 yyyy- m월 d일 -->

						<!-- 태그 속성에 기계표현, 태그 안 텍스트에 사람표현 -->
						<time class="review-date" datetime="${iso}">${human}</time>
						<!-- 백에서 연결하는 이름 dto 받기 -->
						<div class="title">
							<span class="author">김영*님</span>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
</body>
</html>