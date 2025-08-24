<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>리뷰 관리</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <!-- 공통 스타일 -->
  <script src="<c:url value='/js/seller_myPage.js' />"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reviewManagement.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>

<body>
<%@ include file="../common/header.jsp"%>
<div class="mypage-wrapper">
    <div class="sub-content">
	    <aside class="mypage-sidebar">
	        <%@ include file="../common/header3.jsp"%>
	    </aside>
    <div class="container">
        <h2>📝 나의 리뷰 관리</h2>

        <div class="review-table-container">
            <table>
            	<colgroup>
					  <col style="width:10%;">
					  <col style="width:10%;">
	                  <col style="width:10%;">
	                  <col style="width:35%;">
	                  <col style="width:35%;">
				</colgroup>
                <thead>
                    <tr>
                        <th>리뷰번호</th>
                        <th>날짜</th>
                        <th>상품명</th>
                        <th>상품 이미지</th>
                        <th>내용</th>
                    </tr>
                </thead>
                    <tbody>
            <c:if test="${not empty myReviewList}">
              <c:forEach var="rls" items="${myReviewList}">
                <tr>
                  <td>
                  	<c:out value="${rls.review_id}"/></td>
                  <td>
  					<time><c:out value="${rls.postdate}"/></time>
                  </td>
                  <td>
                  	<c:out value="${rls.prod_name}"/>
                  </td>

                  <td>
                    <c:choose>
                      <c:when test="${not empty rls.filename}">
                        <img
                          src="${pageContext.request.contextPath}/uploads/reviewimg/${rls.review_id}/${rls.filename}"
                          alt="<c:out value='${rls.title}'/>"
                          class="review-thumb"
                        />
                      </c:when>
                      <c:otherwise>
                        <span class="no-image">이미지 없음</span>
                      </c:otherwise>
                    </c:choose>
                  </td>

                  <td class="review-content"><c:out value="${rls.content}"/></td>
                </tr>
              </c:forEach>
            </c:if>

            <c:if test="${empty myReviewList}">
              <tr>
                <td colspan="5" class="no-data">리뷰를 작성할 구매 내역이 없습니다.</td>
              </tr>
            </c:if>
          </tbody>
            </table>
        </div>
    </div>
</div>
</div>
</body>
</html>
