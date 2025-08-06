<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이 페이지 메인</title>
</head>
<body>
	<div class="sub-content">
      <div class="side-bar">
        <div class="sub-menu-box">
          <h2>마이페이지</h2>
          <ul class="sub-menu-mypage">
            <li>
              쇼핑정보
              <ul class="sub-depth1">
                <li><a href="myPageList.html">주문목록</a></li>
              </ul>
            </li>
            <li>
              고객센터
              <ul class="sub-depth2">
                <li><a href="#">상품문의</a></li>
              </ul>
            </li>
            <li>
              회원정보
              <ul class="sub-depth3">
                <li><a href="#">회원정보 변경</a></li>
                <li><a href="#">회원 탈퇴</a></li>
                <li><a href="#">배송지 관리</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </div>

      <div class="mypage-cont">
        <div class="mypage-info">
          <div class="mypage-info-cont">
              <h2>최근 주문 정보
                <span class="order-info-subtext">최근 30일 내에 주문하신 내역입니다</span>
              </h2>
            <div class="mypage-table-type">
              <table>
                <colgroup>
                  <col style="width: 15%;">
                  <col>
                  <col style="width: 15;">
                  <col style="width: 15;">
                  <col style="width: 15;">
                </colgroup>
                <thead>
                  <th>날짜/주문번호</th>
                  <th>상품명/옵션</th>
                  <th>상품금액/수량</th>
                  <th>주문상태</th>
                  <th> 확인/리뷰 </th>
                </thead>
                <tbody>
                  <tr>
                    <td colspan="5">
                      <p>조회내역이 없습니다.</p>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>

            <div class="mypage-info-cont">
            <span class="pick-list-num">
              <h2>최근 본 상품
                <span class="order-info-subtext">일반회원님께서 본 최근 상품입니다.</span>
              </h2>
            </span>
                <tbody>
                  <tr>
                    <td colspan="6">
                      <p style="text-align: center;">조회내역이 없습니다.</p>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
</body>
</html>