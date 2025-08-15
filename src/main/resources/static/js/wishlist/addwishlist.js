document.addEventListener("DOMContentLoaded", function() {
	const cartForm = document.getElementById("cart_form");

	cartForm.addEventListener("submit", function(e) {
		e.preventDefault(); // 기본 제출 막기

		// FormData 객체로 form 데이터 읽기
		const formData = new FormData(cartForm);

		// Fetch로 POST 전송
		fetch("/wishlist/add.do", {
			method: "POST",
			body: new URLSearchParams(formData) // application/x-www-form-urlencoded 형식
		})
			.then(response => response.text())
			.then(result => {
				const res = parseInt(result, 10);
				if (res > 0) alert("장바구니에 담겼습니다.");
				else if (res === -1) alert("로그인 후 이용해주세요.");
				else alert("장바구니 담기 실패");
			})
			.catch(err => console.log("AJAX 에러:", err));
	});
});


