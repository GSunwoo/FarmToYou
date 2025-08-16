document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("productForm");
  const imageInput = document.getElementById("imageInput");
  const previewContainer = document.getElementById("previewContainer");
  const mainIdxInput = document.getElementById("main_idx");
  const cancelBtn = document.getElementById("cancelBtn");

  // 기존 이미지 + 새 이미지 렌더링
  let allImages = [...existingImagesFromDB]; // 기존 DB 이미지
  renderPreview();

  // 새 이미지 선택 시
  imageInput.addEventListener("change", (e) => {
    // 기존 최대 idx 가져오기
    let maxIdx = allImages.reduce((max, img) => img.idx > max ? img.idx : max, 0);

    const newFiles = Array.from(e.target.files).map((file, i) => ({
      idx: maxIdx + i + 1, // 기존 이미지 최대 idx + 1
      file: file,
      isNew: true,
      main_idx: 0
    }));

    allImages = [...allImages.filter(img => !img.isNew), ...newFiles];
    renderPreview();
  });

  function renderPreview() {
    previewContainer.innerHTML = "";
    allImages.forEach((img) => {
      const wrapper = document.createElement("div");
      wrapper.className = "preview-wrap";

      const imageEl = document.createElement("img");
      imageEl.className = "preview-img";
      if (img.isNew) {
        imageEl.src = URL.createObjectURL(img.file);
      } else {
        imageEl.src = `/uploads/prodimg/prod_id/${img.prod_id}/${img.filename}`;
      }

      const radio = document.createElement("input");
      radio.type = "radio";
      radio.name = "main_image";
      radio.value = img.idx;
      if (img.main_idx === 1) {
        radio.checked = true;
        mainIdxInput.value = img.idx;
      }

      radio.addEventListener("change", () => {
        allImages.forEach(i => i.main_idx = (i.idx === img.idx ? 1 : 0));
        mainIdxInput.value = img.idx;
      });

      // 삭제 버튼
      const delBtn = document.createElement("button");
      delBtn.type = "button";
      delBtn.textContent = "삭제";
      delBtn.addEventListener("click", () => {
        if (img.isNew) {
          // 새로 추가된 파일은 그냥 배열에서 제거
          allImages = allImages.filter(i => i !== img);
          renderPreview();
        } else {
          // 기존 파일은 서버에 삭제 요청
          deleteImage(img.prod_id, img.idx);
        }
      });

      wrapper.appendChild(imageEl);
      wrapper.appendChild(radio);
      wrapper.appendChild(delBtn);
      previewContainer.appendChild(wrapper);
    });
  }

  // 폼 제출
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    if(!mainIdxInput.value){
      alert("메인 이미지를 선택해주세요.");
      return;
    }

    const fd = new FormData(form);

    // 새로 추가된 파일만 전송
    allImages.filter(img => img.isNew).forEach((img) => {
      fd.append("image", img.file);
    });

    // 마지막 idx 전송 (새 파일이 들어갈 때 idx 계산용)
    const lastIdx = allImages.reduce((max, img) => img.idx > max ? img.idx : max, 0);
	
    fd.append("last_idx", lastIdx);

    fetch(form.action, { method: "POST", body: fd })
      .then(res => {
        if(!res.ok) throw new Error("서버 오류");
        return res.text();
      })
      .then(data => {
        alert("상품 수정 완료!");
        location.href = "/seller/mylist.do"; // 수정 후 페이지 새로고침
      })
      .catch(err => console.error(err));
  });

  cancelBtn.addEventListener("click", () => {
    form.reset();
    previewContainer.innerHTML = "";
    mainIdxInput.value = "";
  });
});

// 기존 이미지 삭제 함수
function deleteImage(prod_id, idx) {
  if(!confirm("정말 삭제하시겠습니까?")) return;
  
  fetch("/seller/deleteImg.do", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `prod_id=${prod_id}&idx=${idx}`
  })
  .then(res => res.text())
  .then(result => {
    if(result === "success") {
      alert("삭제 완료!");
      location.reload(); // 새로고침
    } else {
      alert("삭제 실패!");
    }
  })
  .catch(err => console.error(err));
}
