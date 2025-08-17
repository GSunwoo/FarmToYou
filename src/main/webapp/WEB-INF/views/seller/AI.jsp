<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>사과 모니터링</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
#imageResult div { margin-bottom: 15px; }
#imageResult img { border: 1px solid #ccc; padding: 3px; }
</style>
<script>
  // 서버에서 context path를 JS 변수로 전달
  const contextPath = "${pageContext.request.contextPath}";
</script>
</head>
<body>
<h2>사과 모니터링</h2>

<div id="monitorArea">
    <button id="startBtn">모니터링 시작</button>
    <button id="stopBtn" style="display:none;">모니터링 중단</button>
    <div id="status">대기중...</div>
    <div id="imageResult"></div>
</div>

<!-- 외부 JS를 body 끝에서 로드 -->
<script src="${pageContext.request.contextPath}/js/ai/ai.js"></script>
</body>
</html>