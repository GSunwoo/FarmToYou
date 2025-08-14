<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Productpage.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="${pageContext.request.contextPath}/js/search.js"></script>
</head>
<body>
  <%@ include file="../common/header.jsp" %>

  <div class="main-content">
    <div class="recommend-items">

      <!-- 금주의 추천상품 -->
      <div class="goods-list-items-warp">
        <div class="goods-list-tit"><h2>위시리스트</h2></div>

        <c:choose>
          <c:when test="${not empty wishlist}">
            <ul class="good-list-items-content three-items-per-row">
              <c:forEach var="row" items="${wishlist}">
                <li>
                  <div class="item-info-box">
                    <div class="item-info-cont">
                      <div class="item-tit-box">
                        <a href="${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${row.prod_id}">
                          ${row.prod_name}
                        </a>
                      </div>
                      <div class="item-money-box">
                         <span>${row.prod_qty}</span>
                          <span><fmt:formatNumber value="${row.prod_price}"/>원</span>
                      </div>
                    </div>
                  </div>
                </li>
              </c:forEach>
            </ul>
          </c:when>
          <c:otherwise>
            <div style="text-align: center; padding: 20px;">추천 상품이 없습니다.</div>
          </c:otherwise>
        </c:choose>
      </div>

      
      </div>

    </div>
  </div>
</body>
</html>
