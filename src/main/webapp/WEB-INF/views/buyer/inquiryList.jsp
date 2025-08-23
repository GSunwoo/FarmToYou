<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="com.farm.dto.InquiryDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품문의</title>
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
  border: 1px solid #ddd;  /* 테두리 추가 */
  border-radius: 4px;      /* 모서리 살짝 둥글게 */
  padding: 20px;           /* 내부 여백 */
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05); /* 은은한 그림자 */

}


/* 제목 영역 */
.mypage-zone-tit {
  padding-bottom: 10px;
  border-bottom: 1px solid #eee; /* 제목 아래 구분선 */
  margin-bottom: 15px;
}

.mypage-zone-tit h3 {
  margin: 0;
  font-size: 18px;
  font-weight: bold;
}


/* 테이블 스타일 */
.mypage-table-type table {
  width: 100%;
  border-collapse: collapse;
}

.mypage-table-type th,
.mypage-table-type td {
  padding: 10px;
  border-bottom: 1px solid #eee;
  text-align: center;
}

/* 조회내역 없음 스타일 */
.mypage-table-type tbody tr td[colspan] {
  text-align: center;
  color: #999;
  padding: 30px 0;
  border: 1px dashed #ddd;  /* dotted 대신 dashed */
  border-radius: 6px;
}

.ellipsis {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
<!-- 공통 css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mainpage.css">
	
	
</head>
<body class="simple-page">
<%
    // 페이지 번호 읽기
    String pageParam = request.getParameter("page");
    int currentPage = (pageParam == null || pageParam.equals("")) ? 1 : Integer.parseInt(pageParam);

    // 한 페이지당 10개씩
    int pageSize = 10;

    // 문의 리스트 받아오기
    List<com.farm.dto.InquiryDTO> inquiryList =
        (List<com.farm.dto.InquiryDTO>) request.getAttribute("inquiries");

    // 최신순 정렬 (postdate 기준 내림차순)
    if (inquiryList != null) {
        java.util.Collections.sort(inquiryList, new java.util.Comparator<com.farm.dto.InquiryDTO>() {
            @Override
            public int compare(com.farm.dto.InquiryDTO a, com.farm.dto.InquiryDTO b) {
                return b.getPostdate().compareTo(a.getPostdate());
            }
        });
    }

    // 전체 게시글 개수
    int totalCount = inquiryList != null ? inquiryList.size() : 0;

    // 전체 페이지 수
    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

    // 현재 블록 계산
    int pageBlock = 10;
    int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
    int endPage = startPage + pageBlock - 1;
    if (endPage > totalPages) endPage = totalPages;

    // 현재 페이지에서 보여줄 데이터 인덱스
    int startIndex = (currentPage - 1) * pageSize;
    int endIndex = Math.min(startIndex + pageSize, totalCount);

    // JSP에서 사용하기 위해 저장
    request.setAttribute("inquiriesSorted", inquiryList);
    request.setAttribute("startIndex", startIndex);
    request.setAttribute("endIndex", endIndex);
    request.setAttribute("startPage", startPage);
    request.setAttribute("endPage", endPage);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("currentPage", currentPage);
%>

	<!-- 상단 공통 헤더 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="mypage-wrapper">
  <div class="mypage-container">
    <!-- 왼쪽 사이드바 -->
    <aside class="mypage-sidebar">
      <%@ include file="../common/header2.jsp"%>
    </aside>

    <!-- 오른쪽 콘텐츠 -->
    <div class="mypage-content">
      <div class="mypage-zone-tit">
        <h3>상품문의 목록</h3>
      </div>
		<div class="mypage-info-cont">			
      <div class="mypage-table-type">
        <table>
          <colgroup>
            <col style="width: 15%;">
            <col>
            <col style="width: 20%;">
            <col style="width: 15%;">
            <col style="width: 15%;">
          </colgroup>
							<thead>
								<tr>
									<th>날짜</th>
									<th>상품명</th>
									<th>제목</th>
									<th>상세보기</th>
									<th>문의상태</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty inquiries}">
										<c:forEach var="q" items="${inquiries}" begin="${startIndex}" end="${endIndex - 1}">
											<tr>
												  <td>
										            <fmt:formatDate value="${q.postdate}" pattern="yyyy-MM-dd"/>
										          </td>
												<!-- 카테고리: 스키마가 없으니 고정 -->
												<td>${q.prod_id}</td>

												<%-- <!-- 제목: 수정 페이지로 이동 (컨트롤러에 존재) -->
												<td class="ellipsis"><a
													href="${pageContext.request.contextPath}/buyer/inquiryUpdate.do?inquiry_id=${q.inquiry_id}">
														<c:out value="${q.title}" />
												</td> --%>
												<!-- 제목: 수정 페이지로 이동 (컨트롤러에 존재) -->
												<td class="ellipsis">
														<c:out value="${q.title}" />
												</td>
												<!-- 문의 상세보기 -->
												<td class="ellipsis">
												<a
													href="${pageContext.request.contextPath}/buyer/inquiryDetail.do?inquiry_id=${q.inquiry_id}">상세보기
												</a>
												</td>
												<!-- 문의상태: 스키마가 없으니 고정 -->
												<td>대기</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5" style="text-align: center;">조회내역이 없습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					 <!-- 페이지네이션 -->
	      <div class="pagination">
	        <!-- 처음으로 -->
	        <a href="?page=1" class="${currentPage == 1 ? 'disabled' : ''}">처음</a>

	        <!-- 이전 블록 -->
	        <c:if test="${startPage > 1}">
	          <a href="?page=${startPage - 1}">&lt;</a>
	        </c:if>

	        <!-- 페이지 번호들 -->
	        <c:forEach var="p" begin="${startPage}" end="${endPage}">
	          <a href="?page=${p}" class="${p == currentPage ? 'active' : ''}">${p}</a>
	        </c:forEach>

	        <!-- 다음 블록 -->
	        <c:if test="${endPage < totalPages}">
	          <a href="?page=${endPage + 1}">&gt;</a>
	        </c:if>

	        <!-- 끝으로 -->
	        <a href="?page=${totalPages}" class="${currentPage == totalPages ? 'disabled' : ''}">끝</a>
	      </div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>
