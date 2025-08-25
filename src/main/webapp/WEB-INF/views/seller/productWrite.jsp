<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>판매자 마이페이지 - 상품판매등록</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<link href="<c:url value='/css/productRegistration.css' />"
	rel="stylesheet" />
<!-- 공통 CSS -->
<link href="<c:url value='/css/seller_mypage.css' />" rel="stylesheet" />
<link href="<c:url value='/css/Dashboard.css' />" rel="stylesheet" />
<!-- 페이지 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- 페이지 JS -->
<script src="<c:url value='/js/seller_myPage.js' />"></script>
<script defer src="<c:url value='/js/productWrite.js' />"></script>
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
			<section class="seller-update-section">
				<h3>상품판매등록</h3>

				<form id="productForm" class="product-form" method="post"
					enctype="multipart/form-data" action="/seller/write.do">

					<div class="form-line section-divider-top">
						<label for="prod_name">상품명</label>
						<div class="form-group">
						<input id="prod_name" type="text" name="prod_name" placeholder="상품명" />
						</div>
					</div>

					<div class="form-line">
					  <label for="prod_explain">설명</label>
					  <div class="form-group">
					  <textarea id="prod_explain" name="prod_content" placeholder="설명" rows="4"></textarea>
					  </div>
					</div>

					<div class="form-line">
					  <label for="stock">재고</label>
					  <div class="form-group">
					  <input type="number" id="stock" name="prod_stock" placeholder="재고">
					  </div>
					</div>

					<div class="form-line">
					  <label for="price">가격 (원)</label>
					  <div class="form-group">
					  <input type="number" id="price" name="prod_price" placeholder="가격 (원)">
					  </div>
					</div>

					<div class="form-line">
						<label for="prod_cate">카테고리</label>
						<div class="form-group">
						<select id="prod_cate" name="prod_cate">
							<option value="">선택하세요</option>
							<option value="fruit">과일</option>
							<option value="vegetable">채소</option>
						</select>
						</div>
					</div>

					
					
					<div class="form-line section-divider-bottom">
					  <label for="image">사진등록</label>
					  <div class="form-group">
					  <input id="imageInput" type="file" name="image" accept="image/*" multiple /> 
					<input type="hidden" name="main_idx" id="main_idx" />
					  <div id="previewWrap" style="display:none; margin-bottom:10px;">
						<img id="previewImg" alt="미리보기 이미지" style="max-width:200px; max-height:200px;"/>
					</div>
					  </div>
					</div>
					
					
					<!-- 이미지 미리보기 영역 ➕ -->
					<!-- <div id="previewWrap" style="display:none; margin-bottom:10px;">
						<img id="previewImg" alt="미리보기 이미지" style="max-width:200px; max-height:200px;"/>
					</div> -->

					<!-- 오류 메시지 표시 영역 ➕ -->
					<div id="errorMsg" style="display:none; color:red; margin-bottom:10px;"></div>

					<div id="previewContainer"></div>
					<!-- <input id="imageInput" type="file" name="image" accept="image/*" multiple /> --> 
					<input type="hidden" name="main_idx" id="main_idx" />
					

					<div class="button-group">
						<button type="submit">등록</button>
						<!-- <button type="button" id="cancelBtn">취소</button> -->
					</div>
				</form>
			</section>
		</main>
	</div>

</body>
</html>