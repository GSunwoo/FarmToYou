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
  const previewContainer = document.getElementById("previewContainer");
  const mainIdxInput = document.getElementById("main_idx"); // hidden input
  const errorMsg = document.getElementById("errorMsg");
  const cancelBtn = document.getElementById("cancelBtn");

  // 숫자 입력 제한
  const blockNonNumericKeys = (e) => {
    if (["-", ".", "e", "E", "+"].includes(e.key)) e.preventDefault();
  };
  const stripNonDigits = (inputEl) => {
    inputEl.value = inputEl.value.replace(/[^0-9]/g, "");
  };
  el.prod_stock.addEventListener("keydown", blockNonNumericKeys);
  el.prod_price.addEventListener("keydown", blockNonNumericKeys);
  el.prod_stock.addEventListener("input", () => stripNonDigits(el.prod_stock));
  el.prod_price.addEventListener("input", () => stripNonDigits(el.prod_price));

  // 이미지 미리보기 + 메인 선택
  imageInput.addEventListener("change", (e) => {
    previewContainer.innerHTML = ''; 
    const files = Array.from(e.target.files);

    files.forEach((file, index) => {
      const reader = new FileReader();
      reader.onload = function(event) {
        const wrapper = document.createElement('div');
        wrapper.style.display = 'inline-block';
        wrapper.style.margin = '10px';
        wrapper.style.textAlign = 'center';

        // 미리보기 이미지
        const img = document.createElement('img');
        img.src = event.target.result;
        img.style.width = '100px';
        img.style.height = '100px';
        img.style.objectFit = 'cover';
        img.style.display = 'block';
        img.style.marginBottom = '5px';
        wrapper.appendChild(img);

        // 메인 이미지 라디오 버튼
        const radio = document.createElement('input');
        radio.type = 'radio';
        radio.name = 'main_radio';
        radio.value = index + 1;
        radio.addEventListener('change', () => {
          mainIdxInput.value = radio.value; 
        });

        const label = document.createElement('label');
        label.style.display = 'block';
        label.style.fontSize = '12px';
        label.textContent = '메인 이미지';
        label.prepend(radio);

        wrapper.appendChild(label);
        previewContainer.appendChild(wrapper);
      };
      reader.readAsDataURL(file);
    });

    if(mainIdxInput) mainIdxInput.value = '';
  });

  // 폼 제출
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    hideError();

    // 필수 값 체크
    const required = [
      el.prod_name.value.trim(),
      el.prod_content.value.trim(),
      el.prod_stock.value.trim(),
      el.prod_price.value.trim(),
      el.prod_cate.value.trim(),
    ];
    if(required.some(v => v === '')){
      showError("모든 항목을 입력해주세요.");
      return;
    }

    if(!mainIdxInput.value){
      showError("메인 이미지를 선택해주세요.");
      return;
    }

    // FormData → 컨트롤러에 맞게 수정
    const fd = new FormData();
    fd.append("prod_name", el.prod_name.value.trim());
    fd.append("prod_content", el.prod_content.value.trim());
    fd.append("prod_stock", el.prod_stock.value.trim());
    fd.append("prod_price", el.prod_price.value.trim());
    fd.append("prod_cate", el.prod_cate.value.trim());
    fd.append("main_idx", mainIdxInput.value); // ✅ 컨트롤러 변수명과 동일

    const files = imageInput.files;
    for(let i=0; i<files.length; i++){
      fd.append("image", files[i]); // ✅ 컨트롤러 변수명과 동일
    }

    fetch(form.action, {
      method: 'POST',
      body: fd
    })
    .then(res => {
      if(!res.ok) throw new Error("서버 오류");
      return res.text(); // redirect라 JSON 아님
    })
    .then(() => {
      alert("상품이 등록되었습니다!");
      form.reset();
      previewContainer.innerHTML = '';
      if(mainIdxInput) mainIdxInput.value = '';
      hideError();
    })
    .catch(err => {
      showError("등록 중 오류가 발생했습니다.");
      console.error(err);
    });
  });

  cancelBtn.addEventListener("click", () => {
    form.reset();
    previewContainer.innerHTML = '';
    if(mainIdxInput) mainIdxInput.value = '';
    hideError();
  });

  function showError(msg){
    if(errorMsg){
      errorMsg.textContent = msg;
      errorMsg.style.display = '';
    }
  }
  function hideError(){
    if(errorMsg){
      errorMsg.textContent = '';
      errorMsg.style.display = 'none';
    }
  }
});
