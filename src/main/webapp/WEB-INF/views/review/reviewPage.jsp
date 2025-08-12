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
<link rel="stylesheet" href="/css/reviewPage.css">
<!-- 돋보기, 별 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<script src="/js/reviewModal.js"></script>
<script src="/js/reviewInfiniteScroll.js"></script>

</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<!-- 베스트 리뷰 섹션 -->
	<section>
		<div class="review-hero-cont">
			<div class="rhc-wrapper">
				<h3> 베스트 리뷰로 <br /> 선정된 리뷰들입니다. </h3>
				<p> 생생한 리뷰를 작성해 주시면, 베스트 리뷰로 선정됩니다. <br /> 많은 관심 부탁드립니다. </p>
			</div>

			<div class="review-best-items">
				<div class="review-top-card">
					<div class="review-info">
						<div class="review-img">
							<c:choose>
								<c:when test="${not empty best.image }">
									<img src="${best.image}" alt="${best.title }" />
								</c:when>
								<c:otherwise>
									<img alt="${best.title }" />
								</c:otherwise>
							</c:choose>
						</div>
						<div class="review-content">
							<p>${best.content }</p>
						</div>
						
						<div class="rating">
							<c:forEach var="i" begin="1" end="5">
								<c:choose>
									<c:when test="${i <= best.star }">
										<i class="fa-solid fa-star"></i>
									</c:when>
									<c:otherwise>
										<i class="fa-regular fa-star"></i>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
					<div class="review-author">
						<span class="author">
							<c:choose>
								<c:when test="${not empty best.memberName }">
									${best.memberName }
								</c:when>
								<c:otherwise>
									회원 ${best.member_id }
								</c:otherwise>
							</c:choose>		
						</span>
						
						<c:choose>
							<c:when test="${not empty best.postdate }">
								<time class="review-date" datetime="${best.postdate }">${best.postdate }</time>
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${best.date}" pattern="yyyy-MM-dd"
									var="isoBest" /> 
								<fmt:formatDate value="${best.date}" pattern="yyyy년 M월 d일"
									var="humanBest" /> 
								
								<time class="review-date" datetime="${isoBest}">${humanBest}</time>
								
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<!-- 일반 리뷰 섹션 -->
	<section>
		<div class="review-grid-lists">
			<!-- 임시확인용. 백엔드에서 제어시 비긴,앤드 제거 -->
			<c:forEach var="review" items="${reviewList }" begin="0" end="4">
				<div class="review-cards">
					<div class="review-imgs">
						<c:choose>
							<c:when test="${not empty review.image }">
								<img src="${review.image}" alt="${review.title }" />
							</c:when>
							<c:otherwise>
								<img alt="${review.title }" />
							</c:otherwise>
						</c:choose>
					</div>
					<div class="review-bottom-content">
						<h5 class="review-title">${review.title }</h5>
					</div>

					<div class="bottom-rating">
						<c:forEach var="i" begin="1" end="5">
							<c:choose>
								<c:when test="${i <= review.star }">
									<i class="fa-solid fa-star"></i>
								</c:when>
								<c:otherwise>
									<i class="fa-regular fa-star"></i>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
					
					<div class="review-bottom-author">
						<span class="author">
							<c:choose>
								<c:when test="${not empty review.memberName }">
									${review.memberName }
								</c:when>
								<c:otherwise>
									회원 ${review.member_id }
								</c:otherwise>
							</c:choose>		
						</span>
						
						<c:choose>
							<c:when test="${not empty review.postdate }">
								<time class="review-date" datetime="${review.postdate }">${review.postdate }</time>
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${review.date}" pattern="yyyy-MM-dd"
									var="iso" /> 
								<fmt:formatDate value="${review.date}" pattern="yyyy년 M월 d일"
									var="human" /> 
		
								<!-- 태그 속성에 기계표현, 태그 안 텍스트에 사람표현 -->
								<time class="review-date" datetime="${iso}">${human}</time>
								<!-- 백에서 연결하는 이름 dto 받기 -->
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
	
	<%@ include file="./reviewModal.jsp" %>
</body>
</html>