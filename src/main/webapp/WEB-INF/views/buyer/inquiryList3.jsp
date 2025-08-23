<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>상품문의</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry.css" />
  <script>
    // 서버에서 내려주는 역할/로그인 정보 (JS 분기용)
    window.isBuyer = ${isBuyer ? 'true' : 'false'};
    window.isSeller = ${isSeller ? 'true' : 'false'};
    window.loginMemberId = '<c:out value="${loginMemberId}" />';
    // 경로 상수 (프로젝트 컨벤션에 맞게 조정 가능)
    window.INQUIRY_PATHS = {
      detail : '${pageContext.request.contextPath}/inquiry/detail.do',
      write  : '${pageContext.request.contextPath}/buyer/inquiry/write.do',
      edit   : '${pageContext.request.contextPath}/buyer/inquiry/edit.do',
      del    : '${pageContext.request.contextPath}/buyer/inquiry/delete.do',
      answer : '${pageContext.request.contextPath}/seller/inquiry/answer.do'
    };
  </script>
</head>
<body>
  <div class="sub-content">
    <div class="mypage-cont">
      <div class="mypage-info">

        <div class="mypage-zone-tit">
          <h3>상품문의 목록</h3>
          <c:if test="${isBuyer}">
            <button type="button" class="btn primary" id="btnWrite">문의 작성</button>
          </c:if>
        </div>

        <div class="mypage-info-cont">
          <div class="mypage-table-type">
            <table class="inq-table">
              <colgroup>
                <col style="width: 12%;">
                <col style="width: 16%;">
                <col>
                <col style="width: 12%;">
                <col style="width: 18%;"> <!-- 액션 -->
              </colgroup>
              <thead>
                <tr>
                  <th>날짜</th>
                  <th>카테고리</th>
                  <th>제목</th>
                  <th>상태</th>
                  <th>액션</th>
                </tr>
              </thead>
              <tbody>
              <c:choose>
                <c:when test="${not empty inquiries}">
                  <c:forEach var="q" items="${inquiries}">
                    <tr
                      class="inq-row"
                      data-inquiry-id="${q.inquiry_id}"
                      data-owner="${q.member_id == loginMemberId}"
                    >
                      <td>
                        <time>
                          <fmt:formatDate value="${q.inquiry_date}" pattern="yyyy-MM-dd" />
                        </time>
                      </td>
                      <td>
                        <c:out value="${q.category}" />
                      </td>
                      <td class="ellipsis">
                        <a class="link-title"
                           href="${pageContext.request.contextPath}/inquiry/detail.do?inquiry_id=${q.inquiry_id}">
                          <c:out value="${q.title}" />
                        </a>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${q.status eq 'DONE'}">
                            <span class="badge done">답변완료</span>
                          </c:when>
                          <c:otherwise>
                            <span class="badge wait">대기</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <!-- 구매자(본인 글) 전용 -->
                        <c:if test="${isBuyer and (q.member_id == loginMemberId)}">
                          <button type="button" class="btn ghost btnEdit"  data-id="${q.inquiry_id}">수정</button>
                          <button type="button" class="btn danger btnDel"   data-id="${q.inquiry_id}">삭제</button>
                        </c:if>

                        <!-- 판매자 전용: 미답변 글에만 '답변' -->
                        <c:if test="${isSeller and (q.status ne 'DONE')}">
                          <button type="button" class="btn primary btnAnswer" data-id="${q.inquiry_id}">답변</button>
                        </c:if>
                      </td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="5" class="empty">
                      조회내역이 없습니다.
                    </td>
                  </tr>
                </c:otherwise>
              </c:choose>
              </tbody>
            </table>
          </div>

          <!-- 페이지네이션 (옵션: pageDTO 제공 시) -->
          <c:if test="${not empty pageDTO}">
            <div class="pagination">
              <c:if test="${pageDTO.prev}">
                <a class="page-btn" href="?page=${pageDTO.startPage-1}">&laquo;</a>
              </c:if>

              <c:forEach var="p" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
                <a class="page-btn ${p == pageDTO.page ? 'active' : ''}" href="?page=${p}">${p}</a>
              </c:forEach>

              <c:if test="${pageDTO.next}">
                <a class="page-btn" href="?page=${pageDTO.endPage+1}">&raquo;</a>
              </c:if>
            </div>
          </c:if>

          <!-- 삭제 POST용 폼 (CSRF 미사용 프로젝트 기준) -->
          <form id="delForm" method="post" action="${pageContext.request.contextPath}/buyer/inquiry/delete.do">
            <input type="hidden" name="inquiry_id" id="delId" />
          </form>
        </div>
      </div>
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/js/inquiry.js" defer></script>
</body>
</html>
