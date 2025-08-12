<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>판매자 마이페이지 - 상품판매등록</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<!-- 공통 CSS -->
<link href="<c:url value='/css/seller_mypage.css' />" rel="stylesheet" />
<link href="<c:url value='/css/Dashboard.css' />" rel="stylesheet" />
<!-- 페이지 CSS -->
<link href="<c:url value='/css/productRegistration.css' />"
	rel="stylesheet" />
</head>

<body class="simple-page">
<form id="seller" method="post" action="/seller/mypage.do">
	<!-- 상단 공통 헤더 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<!-- 레이아웃 래퍼 -->
	<div class="mypage-wrapper">
		<!-- 좌측: 판매자 전용 사이드바 -->
		<jsp:include page="/WEB-INF/views/common/header3.jsp">
			<jsp:param name="active" value="product" />
		</jsp:include>

		<!-- 우측 컨텐츠 -->
		<main class="sub-content">
			<section class="product-form-page">
				<h3>상품 판매 등록</h3>
				<form id="productForm" class="product-form"
					enctype="multipart/form-data">



					<!-- 상품명 -->
					<input type="text" name="prod_name" placeholder="상품명" />

					<!-- 상품 설명 -->
					<textarea name="prod_content" placeholder="상품 설명" rows="4"></textarea>

					<!-- 재고 -->
					<input type="number" name="prod_stock" placeholder="재고 수량" />

					<!-- 가격 -->
					<input type="number" name="prod_pirce" placeholder="가격(원)" />
					
					<!-- 판매자 농장명 -->
					<input type="text" name="farm_name" placeholder="농장명" />

					<!-- 카테고리 -->
					<select name="prod_cate">
						<option value="">카테고리 선택</option>
						<option value="fruit">과일</option>
						<option value="vegetable">채소</option>
					</select>

					<!-- 이미지 업로드 -->
					<input type="file" id="imageInput" accept="image/*" />
					<div class="image-preview" id="previewWrap" style="display: none;">
						<img id="previewImg" alt="미리보기" />
					</div>

					<!-- 오류 메시지 -->
					<div id="errorMsg" class="error" style="display: none;"></div>

					<!-- 버튼 -->
					<div class="button-group">
						<button type="submit">등록</button>
						<button type="button" id="cancelBtn">취소</button>
					</div>
				</form>
			</section>
		</main>
	</div>

	<!-- 페이지 스크립트 -->
	<script src="<c:url value='/js/productRegistration.js' />"></script>
</body>
</html>
