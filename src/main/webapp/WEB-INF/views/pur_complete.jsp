<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구매완료</title>
    <style>
        body {
            font-family: 'Malgun Gothic', sans-serif;
            background: #ffffff;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 400px;
            width: 90%;
        }
        
        .success-icon {
            font-size: 60px;
            color: #28a745;
            margin-bottom: 20px;
        }
        
        h3 {
            color: #333;
            font-size: 24px;
            margin-bottom: 30px;
            font-weight: 600;
        }
        
        .link-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        a {
            display: inline-block;
            padding: 12px 24px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        a:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            background: linear-gradient(45deg, #764ba2, #667eea);
        }
        
        a:first-of-type {
            background: linear-gradient(45deg, #28a745, #20c997);
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        a:first-of-type:hover {
            background: linear-gradient(45deg, #20c997, #28a745);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">✓</div>
        <h3>구매가 완료되었습니다.</h3>
        <div class="link-container">
            <a href="/">메인페이지</a>
            <a href="/wishlist/list.do">장바구니</a>
        </div>
    </div>
</body>
</html>