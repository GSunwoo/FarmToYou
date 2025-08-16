<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <div class="main-content">
        <h2 style="font-size: 1.5em;">상품문의</h2>
        
        <form action="/buyer/inquiryList.do"></form>
        
        
        <div class="board-white-box">
          <table class="board-white-table">
            <colgroup>
              <col style="width: 15%;">
              <col style="width: 85%;">
            </colgroup>
            <tbody>
              <tr>
                <th scope="row">말머리</th>
                <td><p>
                ${prod_name}
                </p></td>
              </tr>
              <tr>
                <th scope="row">작성자</th>
                <td><c:out value="${user_id }" /></td>
              </tr>
              <tr>
                <th scope="row">제목</th>
                <td><input type="text" name="title" placeholder="제목을 입력하세요" style="width: 60%;" maxlength="200" required></td>
              </tr>
              <tr>
                <th scope="row">본문</th>
                <td><textarea name="content" rows="10" style="width:90%;" placeholder="내용을 입력하세요"></textarea></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      
      <div class="btn-center-box">
        <button type="button" class="btn-before" onclick=""><strong>이전</strong></button>
        <button type="button" class="btn-write-ok" onclick=""><strong>저장</strong></button>
        
      </div>
</body>
</html>