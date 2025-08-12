<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <title>판매자 마이페이지 - 주문상태</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />

  <!-- 공통 CSS -->
  <link href="<c:url value='/css/Dashboard.css' />" rel="stylesheet" />
  <link href="<c:url value='/css/seller_mypage.css' />" rel="stylesheet" />

  <!-- 페이지 전용 추가 스타일이 있다면 여기에서 불러오세요 -->
  <%-- <link href="<c:url value='/css/sellerManagement.css' />" rel="stylesheet" /> --%>
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

          <!-- 진행 중인 주문 카운트/필터 바 -->
          <div class="orders-status-bar">
            <ul class="status-list">
              <li class="status-item" data-code="chk_order">
                주문확인 (<span id="count-chk_order">0</span>)
              </li>
              <li class="status-item" data-code="prepare_order">
                상품준비중 (<span id="count-prepare_order">0</span>)
              </li>
              <li class="status-item" data-code="deli_order">
                배송중 (<span id="count-deli_order">0</span>)
              </li>
              <li class="status-item" data-code="cmpl_order">
                배송완료 (<span id="count-cmpl_order">0</span>)
              </li>
            </ul>
            <p class="status-tip">상태를 클릭하면 해당 상태의 주문만 필터링됩니다. 다시 클릭하면 해제됩니다.</p>
          </div>

          <!-- 최근 주문 정보 테이블 -->
          <div class="orders-table-wrap">
            <table class="orders-table">
              <thead>
                <tr>
                  <th style="width:120px;">주문번호</th>
                  <th>상품명</th>
                  <th style="width:120px;">주문자</th>
                  <th style="width:140px;">상태</th>
                  <th style="width:120px;">작업</th>
                </tr>
              </thead>
              <tbody>
                <%-- 예시 데이터 (백엔드 연동 시 서버 데이터로 렌더링) --%>
                <tr data-status="chk_order">
                  <td>O-240801-001</td>
                  <td>레드자몽 5kg</td>
                  <td>홍길동</td>
                  <td><span class="badge badge-chk_order">주문확인</span></td>
                  <td><button class="next-btn" type="button">다음</button></td>
                </tr>
                <tr data-status="prepare_order">
                  <td>O-240801-002</td>
                  <td>청포도 3kg</td>
                  <td>김영희</td>
                  <td><span class="badge badge-prepare_order">상품준비중</span></td>
                  <td><button class="next-btn" type="button">다음</button></td>
                </tr>
                <tr data-status="deli_order">
                  <td>O-240801-003</td>
                  <td>레몬 2kg</td>
                  <td>이강</td>
                  <td><span class="badge badge-deli_order">배송중</span></td>
                  <td><button class="next-btn" type="button">다음</button></td>
                </tr>
                <tr data-status="cmpl_order">
                  <td>O-240801-004</td>
                  <td>블루베리 1kg</td>
                  <td>박수현</td>
                  <td><span class="badge badge-cmpl_order">배송완료</span></td>
                  <td><button class="next-btn" type="button" disabled>완료</button></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </main>
  </div>

  <!-- 페이지 스크립트: 반드시 본문 뒤에서 로드 -->
  <script src="<c:url value='/js/sellerManagement.js' />"></script>
</body>
</html>
