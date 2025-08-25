<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품문의 상세(view)</title>
<style>
/* 메인 컨테이너 */
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

/* 제목 */
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
/* 내용 셀만 패딩 늘리기 */
.board-white-table td.content-cell {
    padding-top: 70px;   /* 상단 패딩 */
    padding-bottom: 70px; /* 하단 패딩 */
    vertical-align: top;  /* 위쪽부터 내용 표시 */
}


/* 버튼 영역 */
.btn-center-box {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 15px;
}

.btn-before, .btn-write-ok {
	padding: 8px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-weight: bold;
	text-decoration: none;
	display: inline-block;
	text-align: center;
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

.comments-wrap { margin-top: 30px; }
.comments-title { font-size: 18px; font-weight: bold; margin-bottom: 12px; }
.comments-list { list-style: none; padding: 0; margin: 0 0 16px; }
.comment-item { border:1px solid #eee; border-radius:6px; padding:10px; margin-bottom:10px; background:#fafafa; }
.comment-meta { font-size: 13px; color:#777; margin-bottom: 6px; }
.comment-content { white-space: pre-wrap; line-height: 1.5; }
.no-comments { color:#999; margin-bottom: 12px; }
.comment-form textarea { width: 100%; padding: 8px; resize: vertical; border: 1px solid #ccc; border-radius: 4px; }
.comment-form .btns { margin-top: 8px; text-align: right; }



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

			<!-- 오른쪽 콘텐츠 -->
			<div class="mypage-content">
				<div class="mypage-zone-tit">
					<h2>상품문의 상세</h2>
				</div>

				<!-- inquiry 또는 inquiryDTO로 넘어와도 대응 -->
				<c:set var="inq" value="${not empty inquiry ? inquiry : inquiryDTO}" />

				<!-- 방어: 없으면 목록으로 -->
				<c:if test="${empty inq}">
					<p style="color: #d00">조회할 문의가 없습니다.</p>
					<p>
						<a href="<c:url value='/inq/inquiryList.do'/>">목록으로</a>
					</p>
					<c:remove var="inq" />
					<c:redirect url="/inq/inquiryList.do" />
				</c:if>

				<div class="board-white-box">
					<table class="board-white-table">
						<colgroup>
							<col style="width: 20%;" />
							<col style="width: 80%;" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">번호</th>
								<td><c:out value="${inquiry.inquiry_id}" /></td>
							</tr>
							<tr>
								<th scope="row">작성자</th>
								<td><c:out value="${inquiry.user_id}"/></td>
							</tr>
							<tr>
								<th scope="row">작성일</th>
								<td><fmt:formatDate value="${inquiry.postdate}"
										pattern="yyyy-MM-dd HH:mm" /></td>
							</tr>
							<tr>
								<th scope="row">제목</th>
								<td><c:out value="${inquiry.title}" /></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td class="content-cell"><c:out value="${inquiry.content}" /></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="btn-center-box">
					<!-- 목록 -->
					<a class="btn-before" href="/inq/inquiryList.do"><strong>목록</strong></a>

					<!-- ====== 판매자 답변 섹션 ====== -->
<div class="comments-wrap">
  <h3 class="comments-title">판매자 답변</h3>

  <!-- 답변 리스트 -->
  <c:choose>
    <c:when test="${not empty comments}">
      <ul class="comments-list">
        <c:forEach var="cmt" items="${comments}">
          <li class="comment-item">
            <div class="comment-meta">
              <span class="comment-date">
                <fmt:formatDate value="${cmt.com_date}" pattern="yyyy-MM-dd HH:mm" />
              </span>
            </div>
            <div class="comment-content">
              <c:out value="${cmt.com_content}" />
            </div>
          </li>
        </c:forEach>
      </ul>
    </c:when>
    <c:otherwise>
      <p class="no-comments">등록된 답변이 없습니다.</p>
    </c:otherwise>
  </c:choose>

 <!-- 문의 상세 내용 아래에 답변 작성 폼 추가 -->
<div id="comment-section" style="margin-top:30px;">
  <h3>판매자 답변</h3>

  <!-- 답변 작성 폼 -->
  <form id="commentForm">
    <input type="hidden" name="inquiry_id" value="${inquiry.inquiry_id}">
    <textarea id="com_content" name="com_content" rows="4" placeholder="답변을 입력하세요" required></textarea>
    <button type="submit" id="commentSubmitBtn">등록</button>
  </form>

  <!-- 답변 리스트 출력 영역 -->
  <div id="commentList" style="margin-top:20px;">
    <c:forEach var="comment" items="${comments}">
      <div class="comment-item">
        <p>${comment.com_content}</p>
        <span><fmt:formatDate value="${comment.com_date}" pattern="yyyy-MM-dd HH:mm"/></span>
      </div>
    </c:forEach>
  </div>
</div>

					<!-- 삭제 (POST) -->
					<!-- <form action="${pageContext.request.contextPath}/buyer/inquiryDelete.do" method="post" style="display:inline;">
        <button type="submit" class="btn-write-ok" onclick="return confirm('삭제하시겠습니까?');">
          <strong>삭제</strong>
        </button>
      </form>  -->
				</div>
			</div>
		</div>
	</div>
	<script>
	document.addEventListener("DOMContentLoaded", function () {
		  const form = document.getElementById("commentForm");
		  const commentList = document.getElementById("commentList");

		  form.addEventListener("submit", function (e) {
		    e.preventDefault();

		    const formData = new FormData(form);

		    fetch("seller/updateComment", {

		      method: "POST",
		      body: formData
		    })
		    .then(res => res.json())
		    .then(data => {
		      if (data.success) {
		        // 신규 답변 추가
		        const newComment = document.createElement("div");
		        newComment.classList.add("comment-item");
		        newComment.innerHTML = `
		          <p>${data.comment.com_content}</p>
		          <span>${data.comment.com_date}</span>
		        `;
		        commentList.appendChild(newComment);

		        // 입력창 초기화
		        document.getElementById("com_content").value = "";
		      } else {
		        alert("답변 작성에 실패했습니다.");
		      }
		    })
		    .catch(err => console.error("댓글 작성 에러:", err));
		  });
		});

</script>
</body>
</html>