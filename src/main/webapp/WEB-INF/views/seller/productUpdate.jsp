<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>상품 수정</title>
<link href="<c:url value='/css/productRegistration.css' />" rel="stylesheet" />

<script>
    // 서버에서 전달한 기존 이미지 정보를 JS에서 사용 가능하도록 JSON으로 직렬화
    const existingImagesFromDB = [
        <c:forEach var="img" items="${imglist}" varStatus="status">
            {
                idx: ${img.idx},
                prod_id: ${img.prod_id},
                filename: '${img.filename}',
                main_idx: ${img.main_idx}
            }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
</script>

<script defer src="<c:url value='/js/prod/prodUpdate.js' />"></script>
</head>

<body>
<form id="productForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/seller/update.do">

    <div class="form-row">
        <label for="prod_name">상품명</label>
        <input id="prod_name" name="prod_name" type="text" value="${productDTO.prod_name}" />
    </div>

    <div class="form-row">
        <label for="prod_content">설명</label>
        <textarea id="prod_content" name="prod_content" rows="4">${productDTO.prod_content}</textarea>
    </div>

    <div class="form-row">
        <label for="prod_stock">재고</label>
        <input id="prod_stock" name="prod_stock" type="number" value="${productDTO.prod_stock}" />
    </div>

    <div class="form-row">
        <label for="prod_price">가격</label>
        <input id="prod_price" name="prod_price" type="number" value="${productDTO.prod_price}" />
    </div>

    <div class="form-row">
        <label for="prod_cate">카테고리</label>
        <select id="prod_cate" name="prod_cate">
            <option value="">선택</option>
            <option value="fruit" <c:if test="${productDTO.prod_cate eq 'fruit'}">selected</c:if>>과일</option>
            <option value="vegetable" <c:if test="${productDTO.prod_cate eq 'vegetable'}">selected</c:if>>채소</option>
        </select>
    </div>

    <div class="form-row">
        <label for="imageInput">상품 이미지</label>
        <input id="imageInput" type="file" name="image" accept="image/*" multiple />
    </div>

    <div id="previewContainer"></div>

    <!-- 히든 필드: 상품 번호, 메인 이미지 선택, 마지막 idx -->
    <input type="hidden" name="prod_id" value="${productDTO.prod_id}" />
    <input type="hidden" name="main_idx" id="main_idx" value="" />
    <input type="hidden" name="last_idx" id="last_idx" value="${last_idx }" />

    <div class="button-group">
        <button type="submit">수정</button>
        <button type="button" id="cancelBtn">취소</button>
    </div>
</form>
</body>
</html>
