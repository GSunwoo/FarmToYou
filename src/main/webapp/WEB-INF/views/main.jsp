<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인페이지</title>

<c:set var="isMainPage" value="${true }" scope="request" />

<!-- CSS (상대경로) -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reviewSlider.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reviewModal.css">

<!-- 돋보기, 별 css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<script src="/js/search.js"></script>
<script src="/js/bannerSlider.js"></script>
<script src="/js/reviewSlider.js"></script>
</head>
<body>
	<%@ include file="./common/header.jsp"%>
	<section class="banner-carousel">
		<div class="banner-wrapper">
			<div class="banner-slide active">
				<img src="./images/2024_main01.jpg" alt="배너1">
			</div>
			<div class="banner-slide">
				<img src="./images/2024_main04.jpg" alt="배너2">
			</div>
			<div class="banner-slide">
				<img src="./images/2024_main02.jpg" alt="배너2">
			</div>
			<div class="banner-slide">
				<img src="./images/2024_main03.jpg" alt="배너2">
			</div>
			<div class="banner-slide">
				<img src="./images/2024_main05.jpg" alt="배너2">
			</div>
			<div class="banner-slide">
				<img src="./images/2024_main10.jpg" alt="배너2">
			</div>
			<!-- 화살표 버튼 -->
			<button class="prev-btn">&#10094;</button>
			<button class="next-btn">&#10095;</button>
		</div>
	</section>


	<section class="review-section">
		<div style="text-align: center;">
			<h2 style="font-size: 4em; margin-top: 0px;">고객 리뷰</h2>
			<h3 style="font-size: 2em; margin-top: -50px;">고객의 솔직한 후기를 만나보세요</h3>
		</div>

		<div class="review-slider-wrapper">
			<div class="review-slider">
				<div class="slide-track">
					<c:forEach var="rvs" items="${reviewPage}">
						<div class="review-cards"
						    data-review-id="${rvs.review_id}"
							data-star="${rvs.star}" 
							data-likes="${rvs.review_like}"
							data-evaluation="${rvs.evaluation}" 
							data-liked="${rvs.review_liked ? 'true' : 'false'}"
							data-content="${rvs.content}"
							data-prod-id="${rvs.prod_id}"
							>
							
							<div class="review-top-img">
								<img
									src="${pageContext.request.contextPath}/uploads/reviewimg/${rvs.review_id}/${rvs.filename}"
									alt="상품이미지" />
							</div>
							<div class="review-content">
								<p class="review-text">
									<c:choose>
									    <c:when test="${fn:length(rvs.content) > 30}">
									        <c:out value="${fn:substring(rvs.content, 0, 30)}" />...
									    </c:when>
									    <c:otherwise>
									        <c:out value="${rvs.content}" />
									    </c:otherwise>
									</c:choose>
								</p>
							</div>

							<div class="review-stars">
								<c:forEach var="i" begin="1" end="5">
									<c:choose>
										<c:when test="${i <= rvs.star }"><i class="fas fa-star"></i></c:when>
										<c:otherwise><i class="far fa-star"></i></c:otherwise>
									</c:choose>
								</c:forEach>
							</div>

							<div class="review-info">
								<div class="review-footer">
									<span class="review-writer">${rvs.name }</span> 
									<span class="review-data"> <fmt:formatDate
											value="${rvs.postdate }" pattern="yyyy-MM-dd" />
									</span>
									<span class="review-likes">
										<i class="fas fa-thumbs-up"></i> ${rvs.review_like }
									</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>

		</div>
	</section>

	<section class="weekly-best">
		<h2 class="weekly-title">WEEKLY PICK</h2>
		<div class="weekly-product-wrapper">
			<c:forEach var="product" items="${bests}" varStatus="status">
				<div class="weekly-product-card big-circle"
					onclick="location.href='${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${product.prod_id}'">
					<div class="circle-img-wrapper">
						<img
							src="${pageContext.request.contextPath}/uploads/prodimg/prod_id/${product.prod_id}/${product.filename}"
							alt="${product.prod_name}"
							
							> 
					</div>
					<div class="main-best-info">
						<div class="prod-name">${product.prod_name}</div>
						<div class="price-box">
							<span class="original-price"> <fmt:formatNumber
									value="${product.prod_price}" />원
							</span>
							<br/>
							<span class="circle-rank">
								이번주 ${status.index + 1}등
							</span>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>


	<footer class="contact-footer">
		<div class="footer-inner">
			<div class="contact-left">
				<div class="footer-title">Contact us</div>
				<div class="footer-sub">상담신청해주시면 검토 후, 친절하게 상담해 드리겠습니다.</div>

				<div class="contact-info">
					<div>
						<i class="fas fa-map-marker-alt"></i> <span>서울특별시 금천구
							가산디지털2로 101 3층</span>
						<div></div>
						<div>
							<i class="fas fa-phone"></i> <span>010-2272-2867</span>
						</div>
						<div>
							<i class="fas fa-fax"></i> <span>02-2272-22867</span>
						</div>
						<div>
							<i class="fas fa-envelope"></i> <span>wlstjr2867@gmail.com</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	
	<%@ include file="./review/reviewModal.jsp" %>
	
	<script src="/js/reviewModal.js" defer></script>
</body>
</html>