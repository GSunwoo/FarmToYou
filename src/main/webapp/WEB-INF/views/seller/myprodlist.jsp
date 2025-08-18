<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <title>판매자 마이페이지 - 상품목록</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />

  <!-- 공통/페이지 CSS -->
  <link href="<c:url value='/css/Dashboard.css' />" rel="stylesheet" />
  <link href="<c:url value='/css/seller_mypage.css' />" rel="stylesheet" />
  <link rel="stylesheet" href="<c:url value='/css/sellerManagement.css'/>">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
          <div class="mypage-info">
            <div class="mypage-zone-tit">
              <h3>상품 목록</h3>
            </div>

            <div class="seller-page">

              <!-- 상품목록 테이블 -->
              <section class="product-section">
                <table class="products-table seller-table">
                  <thead>
                    <tr>
                      <th style="width:60%;">상품명</th>
                      <th style="width:15%;">가격</th>
                      <th style="width:10%;">재고</th>
                      <th style="width:15%;">관리</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="prod" items="${mylist}">
                      <tr>
                        <!-- 상품명 -->
                        <td class="text-left">
                          <c:out value="${prod.prod_name}" />
                          <input type="hidden" name="prod_id" value="${prod.prod_id}" />
                        </td>

                        <!-- 가격 -->
                        <td>
                          <c:out value="${prod.prod_price}" />원
                        </td>

                        <!-- 재고 -->
                        <td>
                          <c:out value="${prod.prod_stock}" />
                        </td>

                        <!-- 수정 / 삭제 버튼 -->
                        <td>
                          <!-- 수정: GET 방식 -->
                          <form method="get" action="/seller/update.do" style="display:inline;">
                            <input type="hidden" name="prod_id" value="${prod.prod_id}" />
                            <button type="submit" class="btn-update">수정</button>
                          </form>

                          <!-- 삭제: POST 방식 -->
                          <form method="post" action="/seller/delete.do" style="display:inline;">
                            <input type="hidden" name="prod_id" value="${prod.prod_id}" />
                            <button type="submit" class="btn-delete" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                          </form>
                        </td>
                      </tr>
                    </c:forEach>

                    <!-- 상품이 없을 때 -->
                    <c:if test="${empty mylist}">
                      <tr>
                        <td colspan="4" class="empty-state">등록된 상품이 없습니다.</td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </section>

            </div>
          </div>
        </div>
      </main>
    </div>


</body>
</html>
