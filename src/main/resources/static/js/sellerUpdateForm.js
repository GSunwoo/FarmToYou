document.addEventListener("DOMContentLoaded", () => {
  const root = document.querySelector(".seller-update-section");
  if (!root) return;

  const formData = {
    bizNum: "", ceoName: "", companyName: "", zipcode: "",
    address: "", detailAddress: "", depositor: "",
    accountNumber: "", bank: ""
  };
  let isVerified = false;

  const form = root.querySelector("#sellerUpdateForm");
  const el = {
    bizNum: root.querySelector("#bizNum"),
    ceoName: root.querySelector("#ceoName"),
    companyName: root.querySelector("#companyName"),
    zipcode: root.querySelector("#zipcode"),
    address: root.querySelector("#address"),
    detailAddress: root.querySelector("#detailAddress"),
    depositor: root.querySelector("#depositor"),
    accountNumber: root.querySelector("#accountNumber"),
    bank: root.querySelector("#bank")
  };
  const btnVerify = root.querySelector("#btnVerify");
  const submitBtn = root.querySelector("#submitBtn");

  function render() {
    el.bizNum.value = formData.bizNum;
    el.ceoName.value = formData.ceoName;
    el.companyName.value = formData.companyName;
    el.zipcode.value = formData.zipcode;
    el.address.value = formData.address;
    el.detailAddress.value = formData.detailAddress;
    el.depositor.value = formData.depositor;
    el.accountNumber.value = formData.accountNumber;
    el.bank.value = formData.bank;
    updateValidity();
  }

  function updateValidity() {
    const valid =
      isVerified &&
      formData.ceoName !== "" &&
      formData.companyName !== "" &&
      formData.address !== "" &&
      formData.depositor !== "" &&
      formData.accountNumber !== "" &&
      formData.bank !== "";
    submitBtn.disabled = !valid;
  }

  function handleChange(e) {
    const { id, value } = e.target;
    formData[id] = value;
    render();
  }

  el.bizNum.addEventListener("input", (e) => {
    e.target.value = e.target.value.replace(/[^0-9]/g, "");
    formData.bizNum = e.target.value;
  });

  function execDaumPostcode() {
    if (window.daum && window.daum.Postcode) {
      new window.daum.Postcode({
        oncomplete: (data) => {
          formData.zipcode = data.zonecode || "";
          formData.address = data.address || "";
          render();
          el.detailAddress.focus();
        }
      }).open();
    } else {
      alert("다음 우편번호 API 없음. 더미 주소 입력");
      formData.zipcode = "04524";
      formData.address = "서울 중구 세종대로 110";
      render();
      el.detailAddress.focus();
    }
  }
  el.zipcode.addEventListener("click", execDaumPostcode);
  el.address.addEventListener("click", execDaumPostcode);

  ["detailAddress", "bank"].forEach((id) => {
    root.querySelector("#" + id).addEventListener("input", handleChange);
    root.querySelector("#" + id).addEventListener("change", handleChange);
  });

  btnVerify.addEventListener("click", () => {
    const biz = el.bizNum.value.trim();

    if (biz === "1234567890") {
      Object.assign(formData, {
        ceoName: "홍길동", companyName: "길동상회",
        zipcode: "12345", address: "서울시 종로구 종로1가",
        detailAddress: "101호", depositor: "홍길동",
        accountNumber: "110-123-456789"
      });
      isVerified = true; render(); return;
    }

    if (biz === "1234") {
      Object.assign(formData, {
        ceoName: "이몽룡", companyName: "남원상사",
        zipcode: "04524", address: "서울 중구 세종대로 110",
        detailAddress: "본관 3층", depositor: "이몽룡",
        accountNumber: "333-22-444555"
      });
      isVerified = true; render(); return;
    }

    alert("사업자등록번호가 유효하지 않습니다.");
    isVerified = false; render();
  });

/*  form.addEventListener("submit", (e) => {
    e.preventDefault();
    if (submitBtn.disabled) return;
    // 서버 전송 대신 콘솔로 확인 (백엔드 연동 시 fetch로 교체)
    const payload = {
      farm_id: formData.bizNum,
      owner_name: formData.ceoName,
      brand_name: formData.companyName,
      com_zip: formData.zipcode,
      com_addr1: formData.address,
      com_addr2: formData.detailAddress,
      entryman: formData.depositor,
      account: formData.accountNumber,
      bank: formData.bank
    };
    console.log("제출 데이터:", payload);
    alert("사업자 정보 등록 완료!");
  });*/

  render();
});


