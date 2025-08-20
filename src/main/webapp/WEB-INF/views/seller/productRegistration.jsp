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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="<c:url value='/css/productRegistration.css' />" rel="stylesheet" />
<!-- 페이지 JS -->
<script src="<c:url value='/js/seller_myPage.js' />"></script>
<script defer src="<c:url value='/js/productRegistration.js' />"></script>
<script defer src="<c:url value='/js/prodimage/image.js' />"></script>
</head>

<body class="simple-page">
	<!-- 상단 공통 헤더 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<<div class="mypage-wrapper">
    <div class="sub-content">
       <aside class="mypage-sidebar">
           <%@ include file="../common/header3.jsp"%>
       </aside>
       </div>

		<!-- 우측 컨텐츠 -->
		<main class="sub-content">
			<section class="product-form-page">
				<h3>상품판매등록</h3>

				<form id="productForm" class="product-form" method="post"
					enctype="multipart/form-data" action="/seller/write.do">


					<div class="form-row">
						<label for="prod_name">상품명</label> <input id="prod_name"
							type="text" name="prod_name" placeholder="상품명" />
					</div>

					<div class="form-row">
						<label for="prod_content">설명</label>
						<textarea id="prod_content" name="prod_content" placeholder="설명"
							rows="4"></textarea>
					</div>

					<div class="form-row">
						<label for="prod_stock">재고</label> <input id="prod_stock"
							type="number" name="prod_stock" placeholder="재고" />
					</div>

					<div class="form-row">
						<label for="prod_price">가격 (원)</label> <input id="prod_price"
							type="number" name="prod_price" placeholder="가격 (원)" />
					</div>


					<div class="form-row">
						<label for="prod_cate">카테고리</label> <select id="prod_cate"
							name="prod_cate">
							<option value="">선택하세요</option>
							<option value="fruit">과일</option>
							<option value="vegetable">채소</option>
						</select>
					</div>

					<div class="form-row">
						<label for="imageInput">상품 이미지</label> <input id="imageInput"
							type="file" name="image" accept="image/*" multiple />
					</div>



					<div id="previewContainer"></div>
					<input id="imageInput" type="file" name="image" accept="image/*"
						multiple /> <input type="hidden" name="main_idx" id="main_idx" />


					<div class="button-group">
						<button type="submit">등록</button>
						<button type="button" id="cancelBtn">취소</button>
					</div>
				</form>
			</section>

		</main>
	</div>
</body>
</html>
