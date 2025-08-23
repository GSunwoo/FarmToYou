<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품문의 수정</title>
<style>

.mypage-wrapper {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.mypage-container {
  display: flex;
  width: 100%;
  max-width: 1200px;
}

/* 왼쪽 사이드바 */
.mypage-sidebar {
  width: 220px;
  margin-right: 40px;
}

/* 오른쪽 콘텐츠 */
.mypage-content {
  flex: 1;
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 4px;
  padding: 20px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
}

/* 제목 영역 */
.mypage-zone-tit {
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
  margin-bottom: 15px;
}

.mypage-zone-tit h2 {
  margin: 0;
  font-size: 1.5em;
  font-weight: bold;
}

/* 테이블 공통 스타일 */
.board-white-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
  border-top: 2px solid #333;
}

.board-white-table th {
  width: 20%;
  background-color: #f7f7f7;
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #ddd;
  font-weight: bold;
}

.board-white-table td {
  padding: 12px;
  border-bottom: 1px solid #ddd;
}

.board-white-table input[type="text"],
.board-white-table textarea {
  width: 90%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 14px;
}

.board-white-table textarea {
  height: 150px;
  resize: none;
}

/* 버튼 영역 */
.btn-center-box {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-top: 15px;
}

.btn-before,
.btn-write-ok {
  padding: 8px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

.btn-before {
  background-color: #ccc;
  color: #333;
}

.btn-write-ok {
  background-color: #2e8b57;
  color: white;
}

.btn-before:hover {
  background-color: #aaa;
}

.btn-write-ok:hover {
  background-color: #256d45;
}
</style>
</head>
<!-- 공통 css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mainpage.css">
<body class="simple-page">
<!-- 상단 공통 헤더 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="mypage-wrapper">
  <div class="mypage-container">
    <!-- 왼쪽 사이드바 -->
    <aside class="mypage-sidebar">
      <%@ include file="../common/header2.jsp"%>
    </aside>
    

<div class="mypage-content">
      <div class="mypage-zone-tit">
  <h2 style="font-size: 1.5em;">상품문의 수정</h2>
  </div>

  <form action="${pageContext.request.contextPath}/buyer/inquiryUpdate.do" method="post">
    <!-- 컨트롤러에서 요구하는 파라미터 -->
   	<input type="hidden" name="prod_id" value="${inquiryDTO.prod_id}">
    <input type="hidden" name="inquiry_id" value="${inquiryDTO.inquiry_id}" />
    <input type="hidden" name="member_id" value="${inquiryDTO.member_id}" />

    <div class="board-white-box">
      <table class="board-white-table">
        <colgroup>
          <col style="width: 15%;">
          <col style="width: 85%;">
        </colgroup>
        <tbody>
          <tr>
            <th scope="row">말머리</th>
            <td><p>${inquiryDTO.prod_name}</p></td>
          </tr>
          <tr>
            <th scope="row">작성자</th>
            <td><c:out value="${inquiryDTO.user_id}" /></td>
          </tr>
          <tr>
            <th scope="row">제목</th>
            <td>
              <input type="text" name="title" value="${inquiryDTO.title}"
                     placeholder="제목을 입력하세요" style="width:60%;" maxlength="200" required>
            </td>
          </tr>
          <tr>
            <th scope="row">본문</th>
            <td>
              <textarea name="content" rows="10" style="width:90%;" placeholder="내용을 입력하세요" required>${inquiryDTO.content}</textarea>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="btn-center-box">
      <button type="button" class="btn-before" onclick="history.back();"><strong>이전</strong></button>
      <button type="submit" class="btn-write-ok"><strong>수정 저장</strong></button>
    </div>
  </form>
</div>
</div>
</div>
</div>
</body>
</html>
