let isIdChecked = false;

document.addEventListener("DOMContentLoaded", () => {
	const form = document.getElementById("registerForm");
	const pwInput = document.getElementById("password");
	const pwCheckInput = document.getElementById("password2");
	const phone1 = document.getElementById("phone1");
	const phone2 = document.getElementById("phone2");
	const phone3 = document.getElementById("phone3");
	const submitBtn = document.querySelector(".submit-btn");

	const useridInput = document.getElementById("userid");
	useridInput.addEventListener("input", () => {
		useridInput.value = useridInput.value.replace(/[^A-Za-z0-9_!@#$%^&*().\-]/g, "");  // 아이디 입력시 숫자 허용 추가
		checkFormValidity();
	});

	// 비밀번호 불일치 메시지
	const pwMismatchMsg = document.createElement("p");
	pwMismatchMsg.id = "pwMismatchMsg";
	pwMismatchMsg.className = "warning-text";
	pwMismatchMsg.style.display = "none";
	pwMismatchMsg.innerText = "비밀번호가 일치하지 않습니다.";
	pwCheckInput.parentNode.appendChild(pwMismatchMsg);

	// 비밀번호 형식 오류 메시지
	const pwFormatMsg = document.createElement("p");
	pwFormatMsg.id = "pwFormatMsg";
	pwFormatMsg.className = "warning-text";
	pwFormatMsg.style.display = "none";
	pwFormatMsg.innerText = "특수기호 포함, 7자 이상이어야 합니다.";
	pwInput.parentNode.appendChild(pwFormatMsg);

	// 비밀번호 유효성 검사
	pwInput.addEventListener("input", () => {
		pwFormatMsg.style.display = validatePassword(pwInput.value) ? "none" : "block";
		checkFormValidity();
	});

	// 비밀번호 재확인
	pwCheckInput.addEventListener("input", () => {
		pwMismatchMsg.style.display = (pwInput.value === pwCheckInput.value) ? "none" : "block";
		checkFormValidity();
	});

	// 이메일 도메인 선택
	document.getElementById("domainSelect").addEventListener("change", function() {
		const emailDomainInput = document.getElementById("emailDomain");
		if (this.value === "self") {
			emailDomainInput.readOnly = false;
			emailDomainInput.value = "";
			emailDomainInput.focus();
		} else {
			emailDomainInput.readOnly = true;
			emailDomainInput.value = this.value;
		}
		updateHiddenEmail();
		checkFormValidity();
	});

	// 이메일/전화번호 입력
	document.getElementById("emailId").addEventListener("input", () => {
		updateHiddenEmail();
		checkFormValidity();
	});

	document.getElementById("emailDomain").addEventListener("input", () => {
		const emailDomainInput = document.getElementById("emailDomain");
		if (!emailDomainInput.readOnly) {
			// 영문 소문자 + 점(.)만 허용
			emailDomainInput.value = emailDomainInput.value.replace(/[^a-z.]/g, "");
		}
		updateHiddenEmail();
		checkFormValidity();
	});
	
	phone1.addEventListener("input", () => {
				phone1.value = phone1.value.replace(/[^0-9]/g, "");
				if (phone1.value.length === 3) phone2.focus();
				updateHiddenPhone();
				checkFormValidity();
			});
			
	phone2.addEventListener("input", () => {
		phone2.value = phone2.value.replace(/[^0-9]/g, "");
		if (phone2.value.length === 4) phone3.focus();
		updateHiddenPhone();
		checkFormValidity();
	});

	phone3.addEventListener("input", () => {
		phone3.value = phone3.value.replace(/[^0-9]/g, "");
		updateHiddenPhone();
		checkFormValidity();
	});

	// 폼 제출: 더 이상 preventDefault 하지 않음
	form.addEventListener("submit", () => {
		// 기본 전송됨
		alert("회원가입 완료!"); // 선택사항
	});
});

// 이메일 주소 자동 조합
function updateHiddenEmail() {
	const emailId = document.getElementById("emailId").value.trim();
	const emailDomain = document.getElementById("emailDomain").value.trim();
	const hiddenEmail = document.getElementById("email");
	if (hiddenEmail) {
		hiddenEmail.value = emailId && emailDomain ? `${emailId}@${emailDomain}` : "";
	}
}

// 전화번호 자동 조합
function updateHiddenPhone() {
	const phone1 = document.getElementById("phone1").value.trim();
	const phone2 = document.getElementById("phone2").value.trim();
	const phone3 = document.getElementById("phone3").value.trim();
	const hiddenPhone = document.getElementById("phone_num");
	if (hiddenPhone) {
		hiddenPhone.value = phone1 && phone2 && phone3 ? `${phone1}${phone2}${phone3}` : "";
	}
}

// 아이디 중복 확인 (가상)
function checkDuplicateId() {
	const id = document.getElementById("userid").value.trim();
	//const rule = /^[A-Z][A-Za-z\d@$!%*?&]{6,}$/; //맨앞 대문자 조건
	const idRule = /^[A-Za-z0-9_]{7,}$/;

	if (!idRule.test(id)) {
		alert("아이디는 7자리 이상이며, 영문자와 밑줄(_)만 사용할 수 있습니다.");
		isIdChecked = false;
	} else {
		alert("사용 가능한 아이디입니다.");
		isIdChecked = true;
	}
	checkFormValidity();
}

// 비밀번호 유효성 체크
function validatePassword(pw) {
	const rule = /^[A-Za-z\d@$!%*?&]{7,}$/;
	const hasSpecial = /[@$!%*?&]/;
	return rule.test(pw) && hasSpecial.test(pw);
}

// 전체 입력 유효성 검사
function checkFormValidity() {
	const id = document.getElementById("userid").value.trim();
	const pw = document.getElementById("password").value.trim();
	const pw2 = document.getElementById("password2").value.trim();
	const phone1 = document.getElementById("phone1").value.trim();
	const phone2 = document.getElementById("phone2").value.trim();
	const phone3 = document.getElementById("phone3").value.trim();
	const name = document.getElementById("name").value.trim();

	const idValid = /^[A-Za-z0-9_]{7,}$/.test(id);
	const pwValid = validatePassword(pw);
	const pwMatch = pwValid && pw === pw2;
	const phoneValid = phone1.length === 3 && phone2.length === 4 && phone3.length === 4;
	const nameValid = name.length >= 2;

	const submitBtn = document.querySelector(".submit-btn");
	submitBtn.disabled = !(isIdChecked && idValid && pwMatch && phoneValid && nameValid);
}
