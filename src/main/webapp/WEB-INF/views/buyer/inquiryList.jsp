<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품문의</title>
</head>
<body>
   <div class="sub-content">
      <div class="mypage-cont">
        <div class="mypage-info">
        
          <div class="mypage-zone-tit">
            <h3>상품문의 목록</h3>
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
                <tr>
                  <th>날짜</th>
                  <th>카테고리</th>
                  <th>제목</th>
                  <th>문의상태</th>
                </tr>
                </thead>
                <tbody>
                  <c:choose>
                  <c:when test="${not empty inquiries}">
                    <c:forEach var="q" items="${inquiries}">
                      <tr>
                        <td>
                          <time>
                            <fmt:formatDate value="${q.inquiry_date}" pattern="yyyy-MM-dd" />
                          </time>
                        </td>
                        <td class="ellipsis">
                          <a href="${pageContext.request.contextPath}/inquiry/detail?inquiry_id=${q.inquiry_id}">
                            <c:out value="${q.title}" />
                          </a>
                        </td>
                        <td>
                          <c:out value="${q.status}" />
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <tr>
                      <td colspan="4" style="text-align:center;">
                        <p>조회내역이 없습니다.</p>
                      </td>
                    </tr>
                  </c:otherwise>
                </c:choose>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
</body>
</html>