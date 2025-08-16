<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="main-content">
        <h2 style="font-size: 1.5em;">상품문의</h2>
        <div class="board-white-box">
          <table class="board-white-table">
            <colgroup>
              <col style="width: 15%;">
              <col style="width: 85%;">
            </colgroup>
            <tbody>
              <tr>
                <th scope="row">말머리</th>
                <td>
                  <div class="category-select">
                    <select name="category" id="category" style="width: 130px;">
                      <option value="상품">상품</option>
                    </select>
                  </div>
                </td>
              </tr>
              <tr>
                <th scope="row">작성자</th>
                <td>작성자</td>
              </tr>
              <tr>
                <th scope="row">제목</th>
                <td><input type="text" placeholder="제목을 입력하세요" style="width: 60%;"></td>
              </tr>
              <tr>
                <th scope="row">본문</th>
                <td><textarea placeholder="내용을 입력하세요"></textarea></td>
              </tr>
              <tr>
                <th scope="row">첨부파일</th>
                <td id="uploadBox">
                  <div class="file-upload">
                    <input type="text" class="file-text" title="파일 첨부하기" readonly="readonly">
                  </div>
                  <div class="btn-upload-box">
                    <button type="button" class="btn-upload" title="찾아보기"><em>찾아보기</em></button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
      
      <div class="btn-center-box">
        <button type="button" class="btn-before" onclick=""><strong>이전</strong></button>
        <button type="submit" class="btn-write-ok"><strong>저장</strong></button>
      </div>
</body>
</html>