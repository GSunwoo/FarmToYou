<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>상품문의 상세(view)</title>
</head>
<body>
  <div class="main-content">
    <h2>상품문의 상세</h2>

    <c:set var="inq" value="${inquiry}" />

    <div class="board-white-box">
      <table class="board-white-table">
        <colgroup>
          <col style="width: 15%;"/>
          <col style="width: 15%;"/>
          <col style="width: 15%;"/>
          <col>
        </colgroup>
        <tbody>
          <tr>
            <th scope="row">번호</th>
            <td><c:out value="${inq.inquiry_id}" /></td>
            <th scope="row">작성자</th>
            <td><c:out value="${inq.user_id}" /></td>
          </tr>
          <tr>
            <th scope="row">제목</th>
            <td colspan="3"><c:out value="${inq.title}" /></td>
          </tr>
          <tr>
            <th scope="row">내용</th>
            <td colspan="3">
              <div><c:out value="${inq.content}" /></div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- 버튼 영역 -->
    <div class="btn-center-box">
      <!-- 목록 -->
      <a class="btn-before"
         href="<c:url value='/buyer/inquiryList.do'></c:url>"><strong>목록</strong></a>

      <!-- 수정  -->
      <a class="btn-write-ok"
         href="<c:url value='/buyer/inquiryUpdate.do'></c:url>"><strong>수정</strong></a>

      <!-- 삭제 (POST) -->
      <!-- <form action="${pageContext.request.contextPath}/buyer/inquiryDelete.do" method="post" style="display:inline;">
        <button type="submit" class="btn-write-ok" onclick="return confirm('삭제하시겠습니까?');">
          <strong>삭제</strong>
        </button>
      </form>  -->
    </div>
  </div>
</body>
</html>
