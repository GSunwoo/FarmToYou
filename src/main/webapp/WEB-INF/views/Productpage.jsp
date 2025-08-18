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
  <%@ include file="./common/header.jsp" %>

  <div class="main-content">
    <div class="recommend-items">

      <!-- 금주의 추천상품 -->
      <div class="goods-list-items-warp">
        <div class="goods-list-tit"><h2>금주의 추천상품</h2></div>

        <c:choose>
          <c:when test="${not empty bests}">
            <ul class="good-list-items-content three-items-per-row">
              <c:forEach var="best" items="${bests}">
                <li>
                  <div class="item-photo-box">
                    <img
                      src="${pageContext.request.contextPath}/uploads/prodimg/prod_id/${best.prod_id}/${best.filename}"
                      alt="${best.filename}"
                      onclick="location.href='${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${best.prod_id}'">
                  </div>
                  <div class="item-info-box">
                    <div class="item-info-cont">
                      <div class="item-tit-box">
                        <a href="${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${best.prod_id}">
                          ${best.prod_name}
                        </a>
                      </div>
                      <div class="item-money-box">
                        <%-- <c:if test="${p.originalPrice gt p.salePrice}"> --%>
                          <span><fmt:formatNumber value="${best.prod_price}"/>원</span>
                        <%-- </c:if> --%>
                        <%-- <div class="price-inline">
                          <strong class="item-price">
                            <span><fmt:formatNumber value="${p.salePrice}"/>원</span>
                          </strong>
                        </div> --%>
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

      <!-- 국산과일 & 해외과일 -->
      <div class="goods-list-items-warp">
        <div class="goods-list-tit"><h2>국산과일 & 해외과일</h2></div>

        <c:choose>
          <c:when test="${not empty lists}">
            <ul class="good-list-items-content four-items-per-row">
              <c:forEach var="prod" items="${lists}" >
                <li>
                  <div class="item-photo-box">
                  
                    <img
                      src="${pageContext.request.contextPath}/uploads/prodimg/prod_id/${prod.prod_id}/${prod.filename}"
                      alt="${prod.filename}"
                      onclick="location.href='${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${prod.prod_id}'">
                  
                  </div>
                  <div class="item-info-box">
                    <div class="item-info-cont">
                      <div class="item-tit-box">
                        <a href="${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${prod.prod_id}">
                          ${prod.prod_name}
                        </a>
                      </div>
                      <div class="item-money-box">
                        <%-- <c:if test="${prod.prod_price gt prod.prod_salePrice}"> --%>
                          <span><fmt:formatNumber value="${prod.prod_price}"/>원</span>
                         <%-- </c:if> --%>
                      </div>
                      <%-- <div class="price-inline">
                        <strong class="item-price">
                          <span><fmt:formatNumber value="${prod.prod_salePrice}"/>원</span>
                        </strong>
                      </div> --%>
                    </div>
                  </div>
                </li>
              </c:forEach>
            </ul>
          </c:when>
          <c:otherwise>
            <div style="text-align: center; padding: 20px;">상품이 없습니다.</div>
          </c:otherwise>
        </c:choose>
      </div>

    </div>
  </div>
</body>
</html>
