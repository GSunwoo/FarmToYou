const mainIdxInput = document.getElementById("main_idx");

// 기존 DB 이미지와 새 파일을 함께 렌더링
function renderPreview(newFiles = [], existingImages = []) {
  const previewContainer = document.getElementById("previewContainer");
  previewContainer.innerHTML = "";

  // 모든 이미지에 대해 고유 idx 관리
  const allImages = [...existingImages];
  newFiles.forEach((file, i) => {
    // 새 파일의 임시 idx: 기존 DB 이미지 수 + i
    allImages.push({ idx: existingImages.length + i, file: file, isNew: true, main_idx: 0 });
  });

  allImages.forEach((img, index) => {
    const wrapper = document.createElement("div");
    wrapper.className = "preview-wrap";

    const image = document.createElement("img");
    image.className = "preview-img";
    if (img.isNew) {
      image.src = URL.createObjectURL(img.file);
    } else {
      image.src = `${pageContext.request.contextPath}/uploads/prodimg/${img.prod_id}/${img.filename}`;
    }

    // 라디오 버튼 생성
    const radio = document.createElement("input");
    radio.type = "radio";
    radio.name = "main_image";
    radio.value = img.idx;
    if (img.main_idx === 1) {
      radio.checked = true;
      mainIdxInput.value = 1; // 체크된 이미지는 1
    }

    radio.addEventListener("change", () => {
      // 체크 시 main_idx 1, 나머지 0
      allImages.forEach(other => {
        other.main_idx = (other.idx === img.idx) ? 1 : 0;
      });
      mainIdxInput.value = 1; // 폼 전송 시 체크된 이미지는 1
    });

    wrapper.appendChild(image);
    wrapper.appendChild(radio);
    previewContainer.appendChild(wrapper);
  });
}

// 파일 input 이벤트
imageInput.addEventListener("change", (e) => {
  const files = Array.from(e.target.files);
  renderPreview(files, existingImagesFromDB); // 서버에서 가져온 기존 이미지 배열
});
