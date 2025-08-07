<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인페이지</title>

<!-- CSS (상대경로) -->
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="/js/search.js"></script>
<script src="/js/bannerSlider.js"></script>
<script src="/js/reviewSlider.js"></script>
</head>
<body>
	<!-- 로그인 및 회원가입 메뉴 -->
	<div class="top-util">
		<ul style="font-size: 1em;">
			<li><a href="/myLogin.do">로그인</a></li>
			<li>|</li>
			<li class="dropdown"><a href="#">회원가입</a>
				<ul class="dropdown-menu">
					<li><a href="/memberForm/buyer.do">구매자 회원가입</a></li>
					<li><a href="/memberForm/seller.do">판매자 회원가입</a></li>
				</ul></li>
			<li>|</li>
			<li><a href="#">마이페이지</a></li>
			<li>|</li>
			<li><a href="#">장바구니</a></li>
			<li>|</li>
			<li><a href="#">1:1문의</a></li>
		</ul>
	</div>

	<div class="search-logo-line">
		<div class="search-box">
			<input type="text" placeholder="과일 전문 쇼핑몰"
				style="border-bottom: #888;">
			<button type="button">
				<i class="fas fa-search"></i>
			</button>

			<div id="search-dropdown" class="custom-search-dropdown">
				<div class="recent-keywords">
					<strong>최근검색어</strong>
					<ul>
						<li>1. 사과</li>
						<li>2. 바나나</li>
						<li>3. 레몬</li>
					</ul>
				</div>
			</div>
		</div>
		<a href="/" class="logo-section"> <img
			src="./images/shopping mall-Photoroom.png"
			style="transform: scaleX(2);">
		</a>

		<div class="category-bar">
			<ul class="category-menu">
				<li style="font-size: 1.3em;">상품</li>
				<li style="font-size: 1.3em;">추천상품</li>
				<li style="font-size: 1.3em;">추천리뷰</li>
				<li style="font-size: 1.3em;">이달의추천</li>
				<li style="font-size: 1.3em;">1:1문의</li>
				<li style="font-size: 1.3em;">하나더추가</li>
			</ul>
		</div>

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
				<h3 style="font-size: 2em; margin-top: -50px;">고객의 솔직한 후기를
					만나보세요</h3>
			</div>

			<div class="review-slider-wrapper">

				<div class="review-slider slider-left">
					<div class="slide-track slide-track-left">
						<div class="review-card">
							<a href="#">sample 1</a>
						</div>
						<div class="review-card">
							<a href="#">sample 2</a>
						</div>
						<div class="review-card">
							<a href="#">sample 3</a>
						</div>
						<div class="review-card">
							<a href="#">sample 4</a>
						</div>
						<div class="review-card">
							<a href="#">sample 5</a>
						</div>
						<div class="review-card">
							<a href="#">sample 6</a>
						</div>
						<div class="review-card">
							<a href="#">sample 7</a>
						</div>
						<div class="review-card">
							<a href="#">sample 8</a>
						</div>
						<div class="review-card">
							<a href="#">sample 9</a>
						</div>
						<div class="review-card">
							<a href="#">sample 10</a>
						</div>
						<div class="review-card">
							<a href="#">sample 11</a>
						</div>
						<div class="review-card">
							<a href="#">sample 12</a>
						</div>
					</div>
				</div>

				<div class="review-slider slider-right" style="margin-top: 30px;">
					<div class="slide-track slide-track-right">
						<div class="review-card">
							<a href="#">sample 13</a>
						</div>
						<div class="review-card">
							<a href="#">sample 14</a>
						</div>
						<div class="review-card">
							<a href="#">sample 15</a>
						</div>
						<div class="review-card">
							<a href="#">sample 16</a>
						</div>
						<div class="review-card">
							<a href="#">sample 17</a>
						</div>
						<div class="review-card">
							<a href="#">sample 18</a>
						</div>
						<div class="review-card">
							<a href="#">sample 19</a>
						</div>
						<div class="review-card">
							<a href="#">sample 20</a>
						</div>
						<div class="review-card">
							<a href="#">sample 21</a>
						</div>
						<div class="review-card">
							<a href="#">sample 22</a>
						</div>
						<div class="review-card">
							<a href="#">sample 23</a>
						</div>
						<div class="review-card">
							<a href="#">sample 24</a>
						</div>
					</div>
				</div>
			</div>
		</section>

		<section class="weekly-best">
			<h2 class="weekly-title">WEEKLY PICK</h2>
			<div class="weekly-product-wrapper">
				<div class="weekly-product-card">
					<img src="./images/img1.jpg">
					<button class="cart-button">
						<i class="fas fa-shopping-cart"></i>장바구니
					</button>
				</div>
				<div class="weekly-product-card">
					<img src="./images/img2.jpg">
					<button class="cart-button">
						<i class="fas fa-shopping-cart"></i>장바구니
					</button>
				</div>
				<div class="weekly-product-card">
					<img src="./images/img3.jpg">
					<button class="cart-button">
						<i class="fas fa-shopping-cart"></i>장바구니
					</button>
				</div>
				<div class="weekly-product-card">
					<img src="./images/img4.jpg">
					<button class="cart-button">
						<i class="fas fa-shopping-cart"></i>장바구니
					</button>
				</div>
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

					<div class="contact-right">
						<div class="input-row">
							<input type="text" placeholder="성명"> <input type="text"
								placeholder="휴대폰">
						</div>
						<textarea placeholder="전달사항을 적어주세요"></textarea>

						<div class="agree-row">
							<input type="checkbox" id="agree"> <label for="agree">개인정보수집
								및 이용안내 <span class="check-guide">(동의함)</span>
							</label> <a href="#" class="view-detail">자세히보기</a>
						</div>

						<button class="inquiry-btn">
							상담문의 <i class="fas fa-arrow-right"></i>
						</button>
					</div>
				</div>
		</footer>
</body>
</html>