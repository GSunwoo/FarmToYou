<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <title>판매자 마이페이지 - 주문상태</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />

  <!-- 공통/페이지 CSS -->
  <link href="<c:url value='/css/Dashboard.css' />" rel="stylesheet" />
  <link href="<c:url value='/css/seller_mypage.css' />" rel="stylesheet" />
  <link rel="stylesheet" href="<c:url value='/css/sellerManagement.css'/>">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <script src="<c:url value='/js/seller_myPage.js' />"></script>
</head>

<body class="simple-page">
  <form id="seller" method="post" action="/seller/mypage.do">
    <!-- 상단 공통 헤더 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <!-- 레이아웃 래퍼 -->
    <div class="mypage-wrapper">
      <!-- 좌측: 판매자 전용 사이드바 -->
      <jsp:include page="/WEB-INF/views/common/header3.jsp">
        <jsp:param name="active" value="orders" />
      </jsp:include>

      <!-- 우측 컨텐츠 -->
      <main class="sub-content">
        <div class="mypage-cont">
          <div class="mypage-info">
            <div class="mypage-zone-tit">
              <h3>주문 상태 관리</h3>
            </div>

            <!-- ===== 여기부터 1번 디자인 그대로 적용되는 본문 ===== -->
            <div class="buyer-page">

              <!-- 진행 중인 주문 -->
              <section class="order-section">
                <h2 class="section-title">진행 중인 주문</h2>

                <div class="order-status progress-row">
                  <div class="status-item" data-code="chk_order">
                    <div class="status-label">주문확인</div>
                    <div class="status-circle">
                      <span id="count-chk_order">
                        <c:out value="${countChkOrder}" default="0"/>
                      </span>
                    </div>
                  </div>
                  <span class="status-sep">›</span>

                  <div class="status-item" data-code="prepare_order">
                    <div class="status-label">상품준비중</div>
                    <div class="status-circle">
                      <span id="count-prepare_order">
                        <c:out value="${countPrepareOrder}" default="0"/>
                      </span>
                    </div>
                  </div>
                  <span class="status-sep">›</span>

                  <div class="status-item" data-code="deli_order">
                    <div class="status-label">배송중</div>
                    <div class="status-circle">
                      <span id="count-deli_order">
                        <c:out value="${countDeliOrder}" default="0"/>
                      </span>
                    </div>
                  </div>
                  <span class="status-sep">›</span>

                  <div class="status-item" data-code="cmpl_order">
                    <div class="status-label">배송완료</div>
                    <div class="status-circle">
                      <span id="count-cmpl_order">
                        <c:out value="${countCmplOrder}" default="0"/>
                      </span>
                    </div>
                  </div>
                </div>
              </section>

              <!-- 최근 주문 정보 -->
              <section class="order-section">
                <h2 class="section-title">최근 주문 정보</h2>

                <table class="orders-table buyer-table">
                  <thead>
                    <tr>
                      <th style="width:160px;">주문번호/날짜</th>
                      <th>상품명</th>
                      <th style="width:160px;">결제금액(수량)</th>
                      <th style="width:120px;">상태</th>
                      <th style="width:120px;">확인</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="order" items="${orderList}">
                      <tr>
                        <td>
                          <!-- DB 컬럼명 유지 -->
                          <div class="order-no"><c:out value="${order.order_no}"/></div>
                          <div class="order-date"><c:out value="${order.order_date}"/></div>
                        </td>

                        <td class="text-left"><c:out value="${order.prod_name}"/></td>

                        <td>
                          <c:out value="${order.total_price}"/>원
                          (<c:out value="${order.quantity}"/>)
                        </td>

                        <!-- 상태 배지: 코드값을 그대로 클래스에 매핑 -->
                        <td>
                          <span class="badge badge-${order.status_code}">
                            <c:out value="${order.status_name}"/>
                          </span>
                        </td>

                        <!-- 다음/완료 버튼 -->
                        <td>
                          <c:choose>
                            <c:when test="${order.status_code eq 'cmpl_order'}">
                              <button class="btn-confirm" type="button" disabled>완료</button>
                            </c:when>
                            <c:otherwise>
                              <button class="btn-confirm" type="button" data-order-no="${order.order_no}">다음</button>
                            </c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach>

                    <!-- 주문이 없을 때 -->
                    <c:if test="${empty orderList}">
                      <tr>
                        <td colspan="5" class="empty-state">주문 내역이 없습니다.</td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </section>

            </div>
            <!-- ===== /본문 끝 ===== -->

          </div>
        </div>
      </main>
    </div>

    <!-- 페이지 스크립트: 반드시 본문 뒤에서 로드 -->
    <script src="<c:url value='/js/sellerManagement.js' />"></script>
  </form>
</body>
</html>
