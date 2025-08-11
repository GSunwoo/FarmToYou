<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
function deletePost(review_id){
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
        var form = document.writeFrm;      
        form.method = "post";  
        form.action = "delete.do";
        form.submit();  
    }
}
</script>
<body>
	<h2>게시판 읽기(Mybatis)</h2>	
	<form name="writeFrm">
		<input type="hid-den" name="review_id" value="${reviewboardDTO.review_id }" />
	</form>
	<table border="1" width="90%">
	    <colgroup>
	        <col width="15%"/> <col width="35%"/>
	        <col width="15%"/> <col width="*"/>
	    </colgroup>	
	    <!-- 게시글 정보 -->
	    <tr>
	        <td>번호</td> <td>${ reviewboardDTO.review_id }</td>
	        <td>작성자</td> <td>${ reviewboardDTO.member_id }</td>
	    </tr>
	    <tr>
	        <td>조회수</td> <td>${ reviewboardDTO.postdate }</td>
	    </tr>
	    <tr>
	        <td>제목</td>
	        <td colspan="3">${ reviewboardDTO.title }</td>
	    </tr>
	    <tr>
	        <td>내용</td>
	        <td colspan="3" height="100">
	        	${ reviewboardDTO.content }	        	
	        </td>
	    </tr>
	    <!-- 하단 메뉴(버튼) -->
	    <tr>
	        <td colspan="4" align="center">
	            <button type="button" onclick="location.href='/buyer/review/edit.do?review_id=${ param.review_id }';">
	                수정하기
	            </button>
	            <button type="button" onclick="deletePost(${ param.review_id });">
	                삭제하기
	            </button>
	            <button type="button" onclick="location.href='./list.do';">
	                목록 바로가기
	            </button>
	        </td>
	    </tr>
	</table>
</body>

</html>