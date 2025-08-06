let isIdChecked = false;

document.addEventListener("DOMContentLoaded", () => {
  const pwInput = document.getElementById("password");
  const pwCheckInput = document.getElementById("password2");
  const pwMismatchMsg = document.getElementById("pwMismatchMsg");

  const form = document.getElementById("registerForm");
  const phone2 = document.getElementById("phone2");
  const phone3 = document.getElementById("phone3");
  const submitBtn = document.getElementById("submitBtn");
  const emailId = document.getElementById("emailId");
  const emailDomain = document.getElementById("emailDomain");

  // 비밀번호 재확인 체크
  pwCheckInput.addEventListener("input", () => {
    if (pwInput.value !== pwCheckInput.value) {
      pwMismatchMsg.style.display = "block";
    } else {
      pwMismatchMsg.style.display = "none";
    }
    checkFormValidity();
  });

  // 전화번호 숫자만 허용 및 자동 포커스
  phone2.addEventListener("input", () => {
    phone2.value = phone2.value.replace(/[^0-9]/g, "");
    if (phone2.value.length === 4) phone3.focus();
    checkFormValidity();
  });

  phone3.addEventListener("input", () => {
    phone3.value = phone3.value.replace(/[^0-9]/g, "");
    checkFormValidity();
  });

  const fieldsToWatch = [
    "password", "password2",
    "phone2", "phone3",
    "address", "detailAddress"
  ];

  fieldsToWatch.forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      el.addEventListener("input", checkFormValidity);
    }
  });

  form.addEventListener("submit", (e) => {
    //e.preventDefault();
    alert("회원가입 완료!");
  });
  // 이메일 합치기
  emailId.addEventListener("input", () => {
    updateHiddenEmail();      // ✅ 추가
    checkFormValidity();
  });
  //이메일 도메인 합치기
  emailDomain.addEventListener("input", () => {
    updateHiddenEmail();      // ✅ 추가
    checkFormValidity();
  });
  //전화번호 합치기1
  phone2.addEventListener("input", () => {
    phone2.value = phone2.value.replace(/[^0-9]/g, "");
    if (phone2.value.length === 4) phone3.focus();
    updateHiddenPhone();     // ✅ 추가
    checkFormValidity();
  });
  //전화번호 합치기2
  phone3.addEventListener("input", () => {
    phone3.value = phone3.value.replace(/[^0-9]/g, "");
    updateHiddenPhone();     // ✅ 추가
    checkFormValidity();
  });
});

function checkDuplicateId() {
  const id = document.getElementById("user_id").value.trim();
  if (id.length < 7) {
    alert("아이디는 7자리 이상이어야 합니다.");
    isIdChecked = false;
  } else {
    alert("사용 가능한 아이디입니다.");
    isIdChecked = true;
  }
  checkFormValidity();
}

function handleDomainSelect(select) {
  const domainInput = document.getElementById("emailDomain");
  if (select.value === "self") {
    domainInput.value = "";
    domainInput.readOnly = false;
    domainInput.focus();
  } else {
    domainInput.value = select.value;
    domainInput.readOnly = true;
  }
  updateHiddenEmail(); // 도메인 바뀔 때도 히든 값 갱신
  checkFormValidity();
}
//이메일 아이디@도메인 합치기
function updateHiddenEmail() {
  const emailId = document.getElementById("emailId").value.trim();
  const emailDomain = document.getElementById("emailDomain").value.trim();
  const hiddenEmail = document.getElementById("email");

  if (emailId && emailDomain) {
    hiddenEmail.value = `${emailId}@${emailDomain}`;
  } else {
    hiddenEmail.value = "";
  }
}
//전화번호 010 + 전화번호4 + 전화번호4 +
function updateHiddenPhone() {
  const phone2 = document.getElementById("phone2").value.trim();
  const phone3 = document.getElementById("phone3").value.trim();
  const hiddenPhone = document.getElementById("phone_num");

  if (phone2 && phone3) {
    hiddenPhone.value = `010-${phone2}-${phone3}`;
  } else {
    hiddenPhone.value = "";
  }
}


function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function (data) {
      document.getElementById("zipcode").value = data.zonecode; 
      document.getElementById("address").value = data.address;
      checkFormValidity();
    }
  }).open();
}

function checkFormValidity() {
  const pw = document.getElementById("password").value.trim();
  const pw2 = document.getElementById("password2").value.trim();
  const phone2 = document.getElementById("phone2").value.trim();
  const phone3 = document.getElementById("phone3").value.trim();
  const address = document.getElementById("address").value.trim();
  const detailAddress = document.getElementById("detailAddress").value.trim();
  const submitBtn = document.getElementById("submitBtn");

  const pwMatch = pw !== "" && pw === pw2;
  const phoneValid = phone2.length === 4 && phone3.length === 4;
  const addressValid = address !== "" && detailAddress !== "";

  const isValid = isIdChecked && pwMatch && phoneValid && addressValid;

  submitBtn.disabled = !isValid;

}


// let isIdChecked = false;

// document.addEventListener("DOMContentLoaded", () => {
//   //2. 필요한 변수들
//   const pwInput = document.getElementById("password");
//   const pwCheckInput = document.getElementById("password2");
//   const pwMismatchMsg = document.getElementById("pwMismatchMsg");
//   const form = document.getElementById("registerForm");
//   const phone2 = document.getElementById("phone2");
//   const phone3 = document.getElementById("phone3");

//   //3. 비밀번호 확인 메시지
//   pwCheckInput.addEventListener("input", () => {
//     if (pwInput.value !== pwCheckInput.value) {
//       pwMismatchMsg.style.display = "block";
//     } else {
//       pwMismatchMsg.style.display = "none";
//     }
//     checkFormValidity(); // 실시간 검사
//   });

//   // 4. 전화번호 자동 포커스 및 숫자만
//   phone2.addEventListener("input", () => {
//     phone2.value = phone2.value.replace(/[^0-9]/g, "");
//     if (phone2.value.length === 4) phone3.focus();
//   });

//   phone3.addEventListener("input", () => {
//     phone3.value = phone3.value.replace(/[^0-9]/g, "");
//   });


//   // 5. 실시간 유효성 검사 연결

//   const fieldsToWatch = [
//     "userid", "password", "password2",
//     "emailId", "emailDomain",
//     "phone2", "phone3",
//     "address", "detailAddress"
//   ];

//   fieldsToWatch.forEach(id => {
//     const el = document.getElementById(id);
//     if (el) {
//       el.addEventListener("input", checkFormValidity);
//     }
//   });

//   form.addEventListener("submit", (e) => {
//     e.preventDefault();

//     const id = form.userid.value.trim();
//     const pw = form.password.value.trim();
//     const pw2 = form.password2.value.trim();
//     const emailId = document.getElementById("emailId").value.trim();
//     const emailDomain = document.getElementById("emailDomain").value.trim();
//     const address = document.getElementById("address").value.trim();
//     // 추가 내용
//     const detailAddress = document.getElementById("detailAddress").value.trim();
//     if (!id || !pw || !pw2 || !emailId || !emailDomain || !phone2.value || !phone3.value || !address || !detailAddress) {
//       alert("공란입니다");
//       return;
//     }

//     if (id.length < 7) {
//       alert("아이디는 7자리 이상이어야 합니다.");
//       return;
//     }

//     const pwRegex = /^[A-Z](?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{6,}$/;
//     if (!pwRegex.test(pw)) {
//       alert("비밀번호는 맨 앞 대문자, 특수문자 포함, 7자리 이상이어야 합니다.");
//       return;
//     }

//     if (pw !== pw2) {
//       alert("비밀번호가 일치하지 않습니다.");
//       return;
//     }

//     const fullEmail = `${emailId}@${emailDomain}`;
//     if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(fullEmail)) {
//       alert("이메일 형식이 올바르지 않습니다.");
//       return;
//     }

//     alert("회원가입 완료!");
//   });
// });

// function checkDuplicateId() {
//   const id = document.getElementById("userid").value.trim();
//   if (id.length < 7) {
//     alert("아이디는 7자리 이상이어야 합니다.");
//   } else {
//     alert("사용 가능한 아이디입니다."); // 실제 중복 확인은 서버 연동 필요
//   }
// }

// function handleDomainSelect(select) {
//   const domainInput = document.getElementById("emailDomain");
//   if (select.value === "self") {
//     domainInput.value = "";
//     domainInput.readOnly = false;
//     domainInput.focus();
//   } else {
//     domainInput.value = select.value;
//     domainInput.readOnly = true;
//   }
//   checkFormValidity();
// }

// function execDaumPostcode() {
//   new daum.Postcode({
//     oncomplete: function (data) {
//       document.getElementById("address").value = data.address;
//     }
//   }).open();
// }
