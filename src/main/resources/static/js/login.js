/*
로그인 자바스크립트()
*/
document.addEventListener("DOMContentLoaded", () => {
	//상단 판매회원 일반회원 탭 전환
	const tabs = document.querySelectorAll('.tab');
	tabs.forEach(tab => {
		tab.addEventListener('click', () => {
			tabs.forEach(t => t.classList.remove('active'));
			tab.classList.add('active');
		});
	});
	
	//로그인 유효성 검사
	const loginForm = document.querySelector('form');
	loginForm.addEventListener('submit', (e) => {
		const id = document.getElementById("id").value.trim();
		const pw = document.getElementById("pw").value.trim();

		if (!id || !pw) {
			e.preventDefault();
			alert("아이디와 비밀번호 모두 입력해 주세요.");
		}
	});
});