/*
로그인 자바스크립트()
*/
document.addEventListener("DOMContentLoaded", () => {
	const loginForm = document.querySelector("form");
	const idInput = document.getElementById("id");
	const pwInput = document.getElementById("pw");
	const rememberCheckbox = document.querySelector("input[type='checkbox'");
	
	//저장된 아이디 불러오기
	const saveId = localStorage.getItem("saveId");
	if(saveId){
		idInput.value = saveId;
		rememberCheckbox.checked = true;
	}
	
	//로그인 유효성 검사
	loginForm.addEventListener('submit', (e) => {
		const id = document.inInput.value.trim();
		const pw = document.pwInput.value.trim();

		if (!id || !pw) {
			e.preventDefault();
			alert("아이디와 비밀번호 모두 입력해 주세요.");
			return;
		}
		
		if(rememberCheckbox.checked) {
			localStorage.setItem("saveId", id);
		}
		else {
			localStorage.removeItem("saveId");
		}
	});
	
});