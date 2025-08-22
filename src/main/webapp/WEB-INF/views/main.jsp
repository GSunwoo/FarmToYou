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
<link rel="stylesheet" href="/css/mainpage.css">
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
			<div class="review-slider slider-horizontal">
				<div class="slide-track slide-track-horizontal">
					<!-- 나중에 모델객체 받아오기(임시) -->
					<c:forEach var="review" items="${reviewList}">
						<div class="review-card">
							<div class="review-top-img">
								<img
									src="${pageContext.request.contextPath}/images/${review.shopImage}"
									alt="상품이미지" />
							</div>
							<div class="review-content">
								<p class="review-text">
									<!-- 50자를 초과할경우 50자까지만 보여주고 뒤에 ... 을 붙어 내용을 축약 -->
									<c:out
										value="${fn:length(review.content) > 50 ? fn:substring(review.content, 0, 50) + '...' : review.content }" />
								</p>
							</div>

							<div class="review-stars">
								<c:forEach var="i" begin="1" end="5">
									<i class="fa-star ${i <= review.star ? 'fas' : 'far'}"></i>
								</c:forEach>
							</div>

							<div class="review-info">
								<img class="shop-logo"
									src="${pageContext.request.contextPath}/images/${review.shopImage}"
									alt="상호 이미지" />
								<div class="review-footer">
									<span class="review-writer">${review.shopName }</span> <span
										class="review-data"> <fmt:formatNumber
											value="${review.postdate }" pattern="yyyy-MM-dd" />
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
			<!-- 메인 컨트롤러에서 모델객체로 bests 하면 추천상품이 나온다 (상품페이지에있는 bests) -->
			<c:forEach var="product" items="${bests}" varStatus="status">
				<div class="weekly-product-card"
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
							<i class="fas fa-phone"></i> <span>1577-1577</span>
						</div>
						<div>
							<i class="fas fa-fax"></i> <span>02-2272-2272</span>
						</div>
						<div>
							<i class="fas fa-envelope"></i> <span>wlstjr2867@gmail.com</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
</body>
</html>