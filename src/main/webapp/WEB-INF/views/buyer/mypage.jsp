<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<title>마이 페이지 메인</title>
</head>
<body class="simple-page">
  <%@ include file="../common/header.jsp" %>

  <div class="mypage-wrapper">
    <div class="sub-content">
      <%@ include file="../common/header2.jsp" %>  <!-- 이제 side-bar만 출력됨 -->

      <div class="mypage-cont">
        <div class="mypage-info">
          <div class="mypage-info-cont">
            <h2>최근 주문 정보
              <span class="order-info-subtext">최근 30일 내에 주문하신 내역입니다</span>
            </h2>

            <div class="mypage-table-type">
              <table>
                <colgroup>
                  <col style="width:15%;">
                  <col>
                  <col style="width:15%;">
                  <col style="width:15%;">
                  <col style="width:15%;">
                </colgroup>
                <thead>
                  <tr>
                    <th>날짜/주문번호</th>
                    <th>상품명/옵션</th>
                    <th>상품금액/수량</th>
                    <th>주문상태</th>
                    <th>확인/리뷰</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td colspan="5"><p>조회내역이 없습니다.</p></td>
                  </tr>
                </tbody>
              </table>
            </div>

            <div class="mypage-info-cont">
              <h2>최근 본 상품
                <span class="order-info-subtext">일반회원님께서 본 최근 상품입니다.</span>
              </h2>
              <div class="mypage-table-type">
                <table>
                  <thead>
                    <tr>
                      <th>최근 본 상품</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td style="text-align:center;">상품이 존재하지 않습니다.</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>

          </div><!-- .mypage-info-cont -->
        </div><!-- .mypage-info -->
      </div><!-- .mypage-cont -->

    </div><!-- .sub-content -->
  </div><!-- .mypage-wrapper -->
</body>
</html>
