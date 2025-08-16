<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 작성</title>
</head>
<body>
  <h2>리뷰 작성</h2>

  <!-- 필요 가정: 세션에 로그인 사용자 정보가 있음 -->
  <!-- sessionScope.member_id, sessionScope.name  -->
  <!-- prod_id는 쿼리스트링 ?prod_id=... 로 전달된다고 가정 -->

  <form id="review" action="/buyer/review/write.do" method="post">
  
	    <!-- 내부/자동 값 -->
	<input type="hidden" id="review_id" name="review_id" value="">
	<input type="hidden" id="review_like" name="review_like" value="0">
	
	<!-- 작성자(로그인 세션) - 화면 표시용 -->
	<label for="member_id_view">회원 ID</label>
	<input type="text" id="member_id_view"
	       value="<c:out value='${sessionScope.member_id}'/>" readonly><br><br>
	
	<!-- 실제 전송용 (파라미터로 넘어감) -->
	<input type="hidden" id="member_id" name="member_id"
	       value="<c:out value='${sessionScope.member_id}'/>"><br><br>

    <!-- 상품 ID (쿼리스트링에서 받기) -->
    <label for="prod_id">상품 ID</label>
    <input type="text" id="prod_id" name="prod_id"
           value="${param.prod_id}" readonly><br><br>

    <!-- 작성일(오늘 날짜 기본) -->
    <label for="postdate">작성일</label>
    <input type="date" id="postdate" name="postdate"
           value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>" readonly><br><br>

    <!-- 제목 -->
    <label for="title">제목</label>
    <input type="text" id="title" name="title" required maxlength="100"><br><br>

    <!-- 내용 -->
    <label for="content">내용</label><br>
    <textarea id="content" name="content" rows="6" cols="60" required></textarea><br><br>

    <!-- 별점 -->
    <label for="star">별점 (1~5)</label>
    <input type="number" id="star" name="star" min="1" max="5" required><br><br>

    <!-- 평가 (자유 텍스트; 필요 시 select로 변경 가능) -->
    <label for="evaluation">평가</label>
    <input type="text" id="evaluation" name="evaluation" maxlength="50" placeholder="예: 아주 좋아요"><br><br>
    
    <!-- 내부에서 설정할 값 -->
    <input type="hidden" id="reviewimg_id" name="reviewimg_id">
    <input type="hidden" id="idx" name="idx">


    <!-- 파일명 (서버에서 자동 생성 가능) -->
    <label for="filename">파일명:</label>
    <input type="text" id="filename" name="filename" placeholder="업로드 시 자동 설정 가능"><br><br>

    <!-- 실제 이미지 업로드 -->
    <label for="uploadFile">이미지 선택:</label>
    <input type="file" id="uploadFile" name="uploadFile" accept="image/*" multiple required><br><br>

    <input type="submit" value="리뷰 등록">
  </form>
</body>
</html>
