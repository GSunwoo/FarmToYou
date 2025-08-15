document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("productForm");

  const el = {
    prod_name: form.elements["prod_name"],
    prod_content: form.elements["prod_content"],
    prod_stock: form.elements["prod_stock"],
    prod_price: form.elements["prod_price"],
    prod_cate: form.elements["prod_cate"],
  };

  const imageInput = document.getElementById("imageInput");
  const previewWrap = document.getElementById("previewWrap");
  const previewImg = document.getElementById("previewImg");
  const errorMsg = document.getElementById("errorMsg");
  const cancelBtn = document.getElementById("cancelBtn");

  // 숫자 입력 제한
  const blockNonNumericKeys = (e) => {
    if (["-", ".", "e", "E", "+"].includes(e.key)) {
      e.preventDefault();
    }
  };
  const stripNonDigits = (inputEl) => {
    inputEl.value = inputEl.value.replace(/[^0-9]/g, "");
  };

  el.prod_stock.addEventListener("keydown", blockNonNumericKeys);
  el.prod_price.addEventListener("keydown", blockNonNumericKeys);
  el.prod_stock.addEventListener("input", () => stripNonDigits(el.prod_stock));
  el.prod_price.addEventListener("input", () => stripNonDigits(el.prod_price));

  // 이미지 미리보기
  imageInput.addEventListener("change", (e) => {
    const file = e.target.files && e.target.files[0];
    if (!file) {
      previewWrap.style.display = "none";
      previewImg.removeAttribute("src");
      return;
    }
    const url = URL.createObjectURL(file);
    previewImg.src = url;
    previewWrap.style.display = "";
  });

  // 제출
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    hideError();

    const required = [
      el.prod_name.value.trim(),
      el.prod_content.value.trim(),
      el.prod_stock.value.trim(),
      el.prod_price.value.trim(),
      el.prod_cate.value.trim(),
    ];

    if (required.some((v) => v === "")) {
      showError("모든 항목을 입력해주세요.");
      return;
    }

    const fd = new FormData();
    fd.append("prod_name", el.prod_name.value.trim());
    fd.append("prod_content", el.prod_content.value.trim());
    fd.append("prod_stock", el.prod_stock.value.trim());
    fd.append("prod_price", el.prod_price.value.trim());
    fd.append("prod_cate", el.prod_cate.value.trim());

    console.log(
      "등록된 상품:",
      Object.fromEntries(Array.from(fd.entries()))
    );

    alert("상품이 등록되었습니다!");

    form.reset();
    previewWrap.style.display = "none";
    previewImg.removeAttribute("src");
    hideError();
  });

  // 취소
  cancelBtn.addEventListener("click", () => {
    form.reset();
    previewWrap.style.display = "none";
    previewImg.removeAttribute("src");
    hideError();
  });

  function showError(msg) {
    errorMsg.textContent = msg;
    errorMsg.style.display = "";
  }
  function hideError() {
    errorMsg.textContent = "";
    errorMsg.style.display = "none";
  }
});
