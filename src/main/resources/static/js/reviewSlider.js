document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.review-section .slide-track').forEach(track => {
    if (track.dataset.cloned === 'true') return;

    const cards = Array.from(track.children);
    if (!cards.length) return;

    track.append(...cards.map(c => c.cloneNode(true)));

    // 2) 루프 길이 계산: 총폭의 절반
    requestAnimationFrame(() => {
      const loopPx = Math.round(track.scrollWidth / 2);
      track.style.setProperty('--loop', loopPx + 'px');

      // 3) 애니메이션 적용
      track.classList.add('animate');

      // 4) 애니 리셋(복제 직후 튐 방지)
      const prev = getComputedStyle(track).animation;
      track.style.animation = 'none';
      void track.offsetHeight; // reflow 강제
      track.style.animation = prev || '';
    });

    // 호버 일시정지
    const slider = track.closest('.review-slider');
    if (slider) {
      slider.addEventListener('mouseenter', () => track.style.animationPlayState = 'paused');
      slider.addEventListener('mouseleave', () => track.style.animationPlayState = 'running');
    }

    track.dataset.cloned = 'true';
  });
});
