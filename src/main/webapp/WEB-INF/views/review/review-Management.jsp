<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>리뷰 관리 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/review.css">
</head>
<body>
    <div class="container">
        <h2>📝 리뷰 관리 및 작성</h2>
        <p class="description">구매하신 상품에 대한 리뷰를 작성해 주세요.</p>

        <div class="review-table-container">
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>구매일</th>
                        <th>이름</th>
                        <th>상품 이미지</th>
                        <th>간략 내용</th>
                        <th>리뷰</th>
                    </tr>
                </thead>
                <tbody>
                        <c:forEach var="item" items="${purchaseList}">
                            <tr>
                                <td>${ReviewBoardDTO.review_id }</td>
                                <td>${ReviewBoardDTO.postdate }</td>
                                <td>${ReviewBoardDTO.name }</td>
                                <td>
                                    <img src="" alt="상품 이미지" class="product-thumb">
                                </td>
                                <td>${ReviewBoardDTO.content }</td>
                                <td>
                                    <button type="button" class="btn-review-write" onclick="">리뷰 작성</button>
                                </td>
                            </tr>
                        </c:forEach>
                    <tr>
                        <td colspan="6" class="no-data">리뷰를 작성할 구매 내역이 없습니다.</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>