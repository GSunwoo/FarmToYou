<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품 목록 페이지</title>
</head>
<body>
<h2>상품 목록</h2>

<table>
    <thead>
        <tr>
            <th>상품번호</th>
            <th>상품명</th>
            <th>상품가격</th>
            <th>품목</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.prod_id}</td>
                <td><a href="/admin/product/view.do?prod_id=${product.prod_id}">${product.prod_name}</a></td>
                <td>${product.prod_price}</td>
                <td>${product.prod_cate}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- 페이지네이션 -->
<div class="pagination">
    <c:set var="totalPages" value="${(paramMap.totalCount / paramMap.pageSize) + ((paramMap.totalCount % paramMap.pageSize) > 0 ? 1 : 0)}" />
    <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="?pageNum=${i}" class="${i == paramMap.pageNum ? 'active' : ''}">${i}</a>
    </c:forEach>
</div>
</body>
</html>