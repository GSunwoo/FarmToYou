document.addEventListener('DOMContentLoaded', () => {
  const track = document.querySelector('.slide-track');
  if (!track) return;

  const cards = Array.from(track.children);
  if (cards.length === 0) return;

  // 무한 루프: 트랙을 2배로
  track.append(...cards.map(c => c.cloneNode(true)));

  // 네 CSS는 .slide-track-left / .slide-track-right에만 애니메이션이 있으므로 하나 부여
  if (!track.classList.contains('slide-track-left') &&
      !track.classList.contains('slide-track-right')) {
    track.classList.add('slide-track-left'); // 오른쪽으로 가게 하려면 'slide-track-right'
  }

  // 호버 일시정지
  const slider = track.closest('.review-slider') || track.parentElement;
  if (slider) {
    slider.addEventListener('mouseenter', () => track.style.animationPlayState = 'paused');
    slider.addEventListener('mouseleave', () => track.style.animationPlayState = 'running');
  }
});
