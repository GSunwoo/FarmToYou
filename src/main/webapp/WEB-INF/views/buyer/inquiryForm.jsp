<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품문의 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiryForm.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<%@ include file="../common/header.jsp" %>

<div class="mypage-wrapper">
    <div class="sub-content">
    <aside class="mypage-sidebar">
        <%@ include file="../common/header2.jsp"%>
    </aside>  
        	<div class="mypage-main-cont">
            <div class="mypage-main-info">
                <h2 style="font-size: 1.5em; margin-bottom: 20px;">상품문의 글쓰기</h2>
                
                <form action="/buyer/inquiryList.do" method="post">
                    <input type="hidden" name="prod_id" value="${prod_id}">
                    <input type="hidden" name="member_id" value="${member_id}">
                    <input type="hidden" name="user_id" value="${user_id}">
                
                    <div class="board-white-box"> <table class="board-white-table">
                        <colgroup>
                          <col style="width: 15%;">
                          <col style="width: 85%;">
                        </colgroup>
                        <tbody>
                          <tr>
                            <th scope="row">말머리</th>
                            <td><p>${prod_name}</p></td>
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
                  
                  <div class="btn-center-box">
                    <button type="button" class="btn-before" onclick="history.back();"><strong>이전</strong></button>
                    <button type="submit" class="btn-write-ok"><strong>저장</strong></button>
                  </div>
                </form>
            </div> <%-- // .mypage-main-info --%>
        </div> <%-- // .mypage-main-cont --%>
    </div> <%-- // .sub-content --%>
</div> <%-- // .mypage-wrapper --%>
</body>
</html>