let isIdChecked = false;

document.addEventListener("DOMContentLoaded", () => {
  const pwInput = document.getElementById("password");
  const pwCheckInput = document.getElementById("password2");
  const pwMismatchMsg = document.getElementById("pwMismatchMsg");

  const form = document.getElementById("registerForm");
  const phone2 = document.getElementById("phone2");
  const phone3 = document.getElementById("phone3");
  const submitBtn = document.getElementById("submitBtn");

  // 비밀번호 재확인 체크
  pwCheckInput.addEventListener("input", () => {
    if (pwInput.value !== pwCheckInput.value) {
      pwMismatchMsg.style.display = "block";
    } else {
      pwMismatchMsg.style.display = "none";
    }
    checkFormValidity();
  });

  //사업자번호
  const managerName = document.getElementById("managerName");
  const accountNumber = document.getElementById("accountNumber");

  managerName.addEventListener("input", () => {
    // if (managerName.value.length >= 3) {
    //   accountNumber.focus();
    // }
  });

  let isComposing = false;

  // 조합 중 여부 설정
  managerName.addEventListener("compositionstart", () => {
    isComposing = true;
  });
  managerName.addEventListener("compositionend", () => {
    isComposing = false;
  });

  // input 이벤트는 그대로 유지
  // managerName.addEventListener("input", () => {
  //   if (!isComposing && managerName.value.trim().length >= 3) {
  //     accountNumber.focus();
  //   }
  // });

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
    "address", "detailAddress",
    "managerName", "accountNumber" //추가
  ];

  fieldsToWatch.forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      el.addEventListener("input", checkFormValidity);
    }
  });

  //form.addEventListener("submit", (e) => {
  //  e.preventDefault();
  //  alert("회원가입 완료!");
  //});

  document.getElementById("emailId").addEventListener("input", () => {
    updateHiddenEmail();
    checkFormValidity();
  });

  document.getElementById("emailDomain").addEventListener("input", () => {
    updateHiddenEmail();
    checkFormValidity();
  });

  document.getElementById("phone2").addEventListener("input", () => {
    updateHiddenPhone();
  });
  
  document.getElementById("phone3").addEventListener("input", () => {
    updateHiddenPhone();
  });

});

function checkDuplicateId() {
  const id = document.getElementById("userid").value.trim();
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
  updateHiddenEmail(); // 추가
  checkFormValidity();
}

//이메일 주소 자동 조합 함수 추가
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
  const managerName = document.getElementById("managerName").value.trim();
  const accountNumber = document.getElementById("accountNumber").value.trim();
  const bank = document.getElementById("bankSelect").value.trim();
  const submitBtn = document.getElementById("submitBtn");

  const pwMatch = pw !== "" && pw === pw2;
  const phoneValid = phone2.length === 4 && phone3.length === 4;
  const addressValid = address !== "" && detailAddress !== "";
  const managerValid = managerName !== "";
  const accountValid = accountNumber !== "";
  const bankValid = bank !== "";  // 은행이 선택되었는지 확인

  const isValid = isIdChecked && pwMatch && phoneValid && addressValid && managerValid && accountValid && bankValid;


  submitBtn.disabled = !isValid;

}

// 사업자등록번호 인증 함수
function verifyBizNum() {
  const bizNum = document.getElementById("bizNum").value.trim();

  if (bizNum === "1234567890") {
    document.getElementById("ceoName").value = "홍길동";
    document.getElementById("companyName").value = "길동상회";
    document.getElementById("zipcode").value = "12345";
    document.getElementById("address").value = "서울시 종로구 종로1가";
    document.getElementById("detailAddress").value = "101호";

    ["ceoName", "companyName", "zipcode", "address", "detailAddress"].forEach(id => {
      document.getElementById(id).readOnly = true;
    });

    document.getElementById("managerName").focus();
  } else {
    alert("사업자등록번호가 유효하지 않습니다.");
  }
}

// const managerName = document.getElementById("managerName");
// const accountNumber = document.getElementById("accountNumber");

// let isComposing = false;

// // 조합 중 여부 설정
// managerName.addEventListener("compositionstart", () => {
//   isComposing = true;
// });
// managerName.addEventListener("compositionend", () => {
//   isComposing = false;
// });

// // input 이벤트는 그대로 유지
// managerName.addEventListener("input", () => {
//   if (!isComposing && managerName.value.trim().length >= 3) {
//     accountNumber.focus();
//   }
// });

