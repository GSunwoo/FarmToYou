<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="${pageContext.request.contextPath}/js/search.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Productpage.css">
</head>
<body>
  <%@ include file="./common/header.jsp" %>

  <div class="main-content">
  <div class="recommend-items">

    <!-- 금주의 추천상품 -->
    <div class="goods-list-items-warp">
      <div class="goods-list-tit"><h2>베스트상품</h2></div>

      <ul class="good-list-items-content four-items-per-row">
        <c:choose>
          <c:when test="${not empty bests}">
            <c:forEach var="best" items="${bests}">
              <li>
                <div class="item-photo-box">
                  <img src="${pageContext.request.contextPath}/uploads/prodimg/prod_id/${best.prod_id}/${best.filename}"
                       alt="${best.filename}"
                       onclick="location.href='${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${best.prod_id}'">
                </div>
                <div class="item-info-box">
                  <div class="item-tit-box">
                    <a href="${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${best.prod_id}">
                      ${best.prod_name}
                    </a>
                  </div>
                  <div class="item-money-box">
                    <span><fmt:formatNumber value="${best.prod_price}"/>원</span>
                  </div>
                </div>
              </li>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <li class="no-item">추천 상품이 없습니다.</li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>

    <!-- 국산과일 & 해외과일 -->
    <div class="goods-list-items-warp">
      <div class="goods-list-tit"><h2>국산과일 & 국산채소</h2></div>

      <ul class="good-list-items-content four-items-per-row">
        <c:choose>
          <c:when test="${not empty lists}">
            <c:forEach var="prod" items="${lists}">
              <li>
                <div class="item-photo-box">
                  <img src="${pageContext.request.contextPath}/uploads/prodimg/prod_id/${prod.prod_id}/${prod.filename}"
                       alt="${prod.filename}"
                       onclick="location.href='${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${prod.prod_id}'">
                </div>
                <div class="item-info-box">
                  <div class="item-tit-box">
                    <a href="${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${prod.prod_id}">
                      ${prod.prod_name}
                    </a>
                  </div>
                  <div class="item-money-box">
                    <span><fmt:formatNumber value="${prod.prod_price}"/>원</span>
                  </div>
                </div>
              </li>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <li class="no-item">상품이 없습니다.</li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>

  </div>
</div>
	<table  width="100%">
        <tr align="center">
            <td>
                ${ pagingImg }
            </td>
        </tr>
    </table>
	

</body>
</html>
