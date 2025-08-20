<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title><c:out value="${pageTitle != null ? pageTitle : '관리자'}"/></title>
  <link rel="stylesheet" href="<c:url value='/css/admin.css'/>">
</head>
<body>
  <!-- 상단 헤더 -->
  <header class="admin-topbar">
    <div class="topbar-inner">
      <h1>환영합니다 관리자님</h1>
    </div>
  </header>

  <div class="admin-wrap">
    <!-- 좌측 사이드바: 네가 가진 mypage.jsp 그대로 include -->
    <aside class="admin-sidebar">
      <jsp:include page="/WEB-INF/views/admin/mypage.jsp"/>
    </aside>

    <!-- 우측 컨텐츠 -->
    <main class="admin-main">
      <section class="admin-content">
        <c:choose>
          <c:when test="${not empty contentPage}">
            <jsp:include page="${contentPage}"/>
          </c:when>
          <c:otherwise>
            <div class="card">
              <h2>대시보드</h2>
              <p>좌측 메뉴를 클릭해 각 관리 페이지로 이동하세요.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </section>
    </main>
  </div>

  <script src="<c:url value='/js/admin.js'/>"></script>
</body>
</html>
