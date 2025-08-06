<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품문의</title>
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
                <li><a href="#">주문목록</a></li>
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
          <div class="mypage-zone-tit">
            <h3>상품문의</h3>
            <button type="submit" class="btn-inquiry" onclick="location.href='inquiryForm.html'">글쓰기</button>
          </div>
          <div class="data-check-box">
            <form method="get" name="DateSearch">
              <h3>조회기간</h3>
              <div class="date-check-list" data-target-name="wDate[]">
                <button type="button" data-value="0">오늘</button>
                <button type="button" data-value="7">7일</button>
                <button type="button" data-value="15">15일</button>
                <button type="button" data-value="30">1개월</button>
                <button type="button" data-value="90">3개월</button>
              </div>

              <div class="date-check-calendar">
                <input type="text" id="picker" name="wDate[]" class="js-datepicker" value="2025-08-04">
                 ~
                <input type="text" id="pickerEnd" name="wDate[]" class="js-datepicker" value="2025-08-04">
                <button type="button" class="btn-date-check"><em>조회</em></button>
              </div>
            </form>
          </div>

          <div class="mypage-info-cont">
            <div class="mypage-table-type">
              <table>
                <colgroup>
                  <col style="width: 10%;">
                  <col style="width: 15%;">
                  <col>
                  <col style="width: 10%;">
                </colgroup>
                <thead>
                  <th>문의날짜</th>
                  <th>카테고리</th>
                  <th>제목</th>
                  <th>문의상태</th>
                </thead>
                <tbody>
                  <tr>
                    <td colspan="6">
                      <p>조회내역이 없습니다.</p>
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