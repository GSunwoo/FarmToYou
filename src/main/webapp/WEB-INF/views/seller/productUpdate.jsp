<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>판매자 마이페이지 - 상품판매변경</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<!-- 공통 CSS -->
<link href="<c:url value='/css/seller_mypage.css' />" rel="stylesheet" />
<link href="<c:url value='/css/Dashboard.css' />" rel="stylesheet" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- 페이지 JS -->

<script defer src="<c:url value='/js/prodUpdate.js' />"></script>
<link href="<c:url value='/css/productRegistration.css' />" rel="stylesheet" />
</head>

<body class="simple-page">
<!-- 상단 공통 헤더 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div id="seller" class="mypage-wrapper">
    <!-- 좌측: 판매자 전용 사이드바 -->
    <jsp:include page="/WEB-INF/views/common/header3.jsp">
        <jsp:param name="active" value="product" />
    </jsp:include>

    <!-- 우측 컨텐츠 -->
    <main class="sub-content">
        <section class="product-form-page">
            <h3>상품판매변경</h3>

            <form id="productForm" class="product-form" method="post" 
                  enctype="multipart/form-data" action="${pageContext.request.contextPath}/seller/update.do">

                <!-- 상품명 -->
                <div class="form-row">
                    <label for="prod_name">상품명</label>
                    <input id="prod_name" type="text" name="prod_name" 
                           value="${productDTO.prod_name}" />
                </div>

                <!-- 상품 설명 -->
                <div class="form-row">
                    <label for="prod_content">설명</label>
                    <textarea id="prod_content" name="prod_content" rows="4">${productDTO.prod_content}</textarea>
                </div>

                <!-- 재고 -->
                <div class="form-row">
                    <label for="prod_stock">재고</label>
                    <input id="prod_stock" type="number" name="prod_stock" 
                           value="${productDTO.prod_stock}" />
                </div>

                <!-- 가격 -->
                <div class="form-row">
                    <label for="prod_price">가격 (원)</label>
                    <input id="prod_price" type="number" name="prod_price" 
                           value="${productDTO.prod_price}" />
                </div>

                <!-- 카테고리 -->
                <div class="form-row">
                    <label for="prod_cate">카테고리</label>
                    <select id="prod_cate" name="prod_cate">
                        <option value="">선택하세요</option>
                        <option value="fruit" <c:if test="${productDTO.prod_cate eq 'fruit'}">selected</c:if>>과일</option>
                        <option value="vegetable" <c:if test="${productDTO.prod_cate eq 'vegetable'}">selected</c:if>>채소</option>
                    </select>
                </div>

                <!-- 이미지 -->
                <div class="form-row">
                    <label for="imageInput">상품 이미지</label>
                    <input id="imageInput" type="file" name="image" accept="image/*" multiple />
                </div>

                <!-- 이미지 미리보기 + 메인 선택 -->
                <div id="previewContainer">
                    <c:forEach var="img" items="${imglist}">
                        <div class="preview-wrap">
                            <img src="${pageContext.request.contextPath}/uploads/prodimg/prod_id/${img.prod_id}/${img.filename}" class="preview-img" />
                            <input type="radio" name="main_image" value="${img.idx}" 
                                   <c:if test="${img.main_idx == 1}">checked</c:if> />
                        </div>
                    </c:forEach>
                </div>

                <!-- 히든 필드: 상품 번호 및 메인 이미지 선택 -->
                <input type="hidden" name="prod_id" value="${productDTO.prod_id}" />
                <input type="hidden" name="main_idx" id="main_idx" value="${productImgDTO.mainIdx}" />

                <!-- 버튼 그룹 -->
                <div class="button-group">
                    <button type="submit">수정</button>
                    <button type="button" id="cancelBtn">취소</button>
                </div>
            </form>
        </section>
    </main>
</div>
</body>
</html>
