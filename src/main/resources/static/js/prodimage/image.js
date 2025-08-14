document.getElementById('imageInput').addEventListener('change', function (e) {
  const previewContainer = document.getElementById('previewContainer');
  previewContainer.innerHTML = ''; // 기존 미리보기 초기화
  const files = Array.from(e.target.files);

  files.forEach((file, index) => {
    const reader = new FileReader();
    reader.onload = function (event) {
      const wrapper = document.createElement('div');
      wrapper.style.display = 'inline-block';
      wrapper.style.margin = '10px';

      // 이미지 미리보기
      const img = document.createElement('img');
      img.src = event.target.result;
      img.style.width = '100px';
      img.style.height = '100px';
      img.style.objectFit = 'cover';
      wrapper.appendChild(img);

      // 메인 이미지 라디오 버튼
      const radio = document.createElement('input');
      radio.type = 'radio';
      radio.name = 'main_idx'; // 서버에서 단일 값으로 받음
      radio.value = index + 1; // insertImg의 i 값과 맞추기 위해 1부터 시작

      wrapper.appendChild(radio);
      previewContainer.appendChild(wrapper);
    };
    reader.readAsDataURL(file);
  });
});
