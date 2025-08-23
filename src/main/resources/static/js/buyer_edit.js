document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("editForm");
    const pwInput = document.getElementById("password");
    const pwCheckInput = document.getElementById("password2");
    const phone1 = document.getElementById("phone1");
    const phone2 = document.getElementById("phone2");
    const phone3 = document.getElementById("phone3");
    const submitBtn = document.querySelector(".edit-submit-btn");

    // --- 비밀번호 불일치 메시지 ---
    const pwMismatchMsg = document.createElement("p");
    pwMismatchMsg.id = "pwMismatchMsg";
    pwMismatchMsg.className = "warning-text";
    pwMismatchMsg.style.display = "none";
    pwMismatchMsg.innerText = "비밀번호가 일치하지 않습니다.";
    pwCheckInput.parentNode.appendChild(pwMismatchMsg);

    // --- 비밀번호 형식 오류 메시지 ---
    const pwFormatMsg = document.createElement("p");
    pwFormatMsg.id = "pwFormatMsg";
    pwFormatMsg.className = "warning-text";
    pwFormatMsg.style.display = "none";
    pwFormatMsg.innerText = "특수기호 포함, 7자 이상이어야 합니다.";
    pwInput.parentNode.appendChild(pwFormatMsg);

    // --- 비밀번호 유효성 검사 ---
    pwInput.addEventListener("input", () => {
        if (!validatePassword(pwInput.value)) {
            pwFormatMsg.style.display = "block";
        } else {
            pwFormatMsg.style.display = "none";
        }
        checkFormValidity();
    });

    // --- 비밀번호 재확인 ---
    pwCheckInput.addEventListener("input", () => {
        const match = pwInput.value === pwCheckInput.value;
        pwMismatchMsg.style.display = match ? "none" : "block";
        checkFormValidity();
    });

    // --- 전화번호 입력 ---
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

    // --- 폼 제출 직전 hidden 값 보장 ---
    form.addEventListener("submit", () => {
        updateHiddenPhone();
    });

    // 초기 세팅 (기존 값 반영)
    updateHiddenPhone();
    checkFormValidity();
});

// --- 비밀번호 조건 체크 ---
function validatePassword(pw) {
    const rule = /^[A-Za-z\d@$!%*?&]{7,}$/;  // 7자리 이상
    const hasSpecial = /[@$!%*?&]/; 
    return rule.test(pw) && hasSpecial.test(pw);
}

// --- 전화번호 자동 조합 ---
function updateHiddenPhone() {
    const phone1 = document.getElementById("phone1").value.trim();
    const phone2 = document.getElementById("phone2").value.trim();
    const phone3 = document.getElementById("phone3").value.trim();
    const hiddenPhone = document.getElementById("phone_num");

    if (hiddenPhone) {
        hiddenPhone.value = `${phone1}${phone2}${phone3}`;
    }
}

// --- 전체 유효성 검사 ---
function checkFormValidity() {
    const pw = document.getElementById("password").value.trim();
    const pw2 = document.getElementById("password2").value.trim();
    const phone1 = document.getElementById("phone1").value.trim();
    const phone2 = document.getElementById("phone2").value.trim();
    const phone3 = document.getElementById("phone3").value.trim();

    const pwValid = validatePassword(pw);
    const pwMatch = pwValid && pw === pw2;
    const phoneValid = phone1.length === 3 && phone2.length === 4 && phone3.length === 4;

    const submitBtn = document.querySelector(".edit-submit-btn");
    submitBtn.disabled = !(pwMatch && phoneValid);
}
