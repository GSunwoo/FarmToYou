/* ReviewManagement.js
 * - 텍스트 별점(★/☆) 적용
 * - 페이지네이션/모달/도움이 됐어요 유지
 */

(() => {
  const API_LIST = '/guest/review/api/list'; // GET ?pageNum=&pageSize=
  const PAGE_SIZE = 15;

  // DOM refs
  const gridEl = document.getElementById('reviewGrid');
  const pageListEl = document.getElementById('pageNumbers');
  const firstBtn = document.querySelector('.rm-page__first'); // "<< 6"
  const prevBtn = document.querySelector('.rm-page__prev');  // "‹" (옵션)
  const nextBtn = document.querySelector('.rm-page__next');  // "›"

  const modalEl = document.getElementById('reviewModal');
  const modalImg = document.getElementById('rmModalImage');
  const modalTitle = document.getElementById('rmModalTitle');
  const modalAuthor = document.getElementById('rmModalAuthor');
  const modalDate = document.getElementById('rmModalDate');
  const modalRating = modalEl.querySelector('.rm-modal__rating');
  const modalContent = document.getElementById('rmModalContent');
  // 교체
  const modalProdLink = document.getElementById('rmModalProductLink');
  const helpBtn = document.getElementById('rmHelpBtn');
  const helpCount = document.getElementById('rmHelpCount');

  // State
  let currentPage = 1;
  let totalPages = 1;
  const cacheByPage = new Map(); // page -> items[]
  const itemById = new Map();    // review_id -> item

  // Utils
  const qs = (sel, parent = document) => parent.querySelector(sel);
  const ce = (tag, cls) => { const el = document.createElement(tag); if (cls) el.className = cls; return el; };
  const fmtDate = (iso) => iso;

  // ★ 텍스트 별점 렌더러 (정수 0~5)
  function setStars(container, n) {
    const score = Math.max(0, Math.min(5, Number(n) || 0));
    container.classList.add('rm-rating--text');
    container.setAttribute('aria-label', `별점 ${score}점/5점`);
    container.innerHTML =
      `<span class="filled">${'★'.repeat(score)}</span>` +
      `<span class="empty">${'☆'.repeat(5 - score)}</span>`;
  }

  function buildCard(item) {
    const li = ce('li', 'rm-card');
    li.dataset.reviewId = item.review_id;
    li.dataset.prodId = item.prod_id ?? '';

    const a = ce('a', 'rm-card__link');
    a.href = '#';
    a.setAttribute('aria-label', '리뷰 자세히 보기');

    const thumb = ce('div', 'rm-card__thumb');
    const img = ce('img', 'rm-card__img');
    img.loading = 'lazy';
    img.alt = '리뷰 이미지';
    img.src = item.image || '';
    thumb.appendChild(img);

    const body = ce('div', 'rm-card__body');

    const title = ce('h4', 'rm-card__title');
    title.textContent = item.title ?? '';

    const rating = ce('div', 'rm-card__rating');
    setStars(rating, item.star); // ← 텍스트 별점 적용

    const meta = ce('div', 'rm-card__meta');
    const author = ce('span', 'rm-card__author');
    author.textContent = item.author ?? '';
    const time = ce('time', 'rm-card__date');
    time.dateTime = item.postdate ?? '';
    time.textContent = fmtDate(item.postdate ?? '');
    meta.append(author, time);

    const product = ce('div', 'rm-card__product');
    const prodLink = ce('a', 'rm-card__product-link');
    prodLink.href = '#'; // 자리만
    prodLink.textContent = item.productName ?? '';
    product.appendChild(prodLink);

    body.append(title, rating, meta, product);
    a.append(thumb, body);
    li.appendChild(a);
    return li;
  }

  function renderGrid(items) {
    gridEl.innerHTML = '';
    const frag = document.createDocumentFragment();
    items.forEach(it => frag.appendChild(buildCard(it)));
    gridEl.appendChild(frag);
  }

function renderPagination(){
  pageListEl.innerHTML = '';

  // 현재 페이지가 속한 5개 묶음
  const blockStart = Math.floor((currentPage - 1) / 5) * 5 + 1;
  const blockEnd   = Math.min(blockStart + 4, totalPages);

  // 번호 버튼 (blockStart ~ blockEnd)
  for (let n = blockStart; n <= blockEnd; n++) {
    const li = document.createElement('li');
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'rm-page__num' + (n === currentPage ? ' is-active' : '');
    btn.dataset.page = String(n);
    btn.textContent = String(n);
    li.appendChild(btn);
    pageListEl.appendChild(li);
  }

  // << 1 : 첫 블록이 아니면 노출 (1페이지로 점프)
  if (firstBtn) {
    if (blockStart > 1) {
      firstBtn.textContent = '<< 1';
      firstBtn.hidden = false;
      firstBtn.classList.remove('is-hidden');
    } else {
      firstBtn.hidden = true;
      firstBtn.classList.add('is-hidden');
    }
  }

  // ‹ / › : 한 페이지 이동
  if (prevBtn) {
    prevBtn.classList.remove('is-hidden');
    prevBtn.hidden = false;
    prevBtn.disabled = (currentPage <= 1);
  }
  nextBtn.classList.remove('is-hidden');
  nextBtn.hidden = false;
  nextBtn.disabled = (currentPage >= totalPages);
}


  async function fetchPage(pageNum) {
    const url = `${API_LIST}?pageNum=${pageNum}&pageSize=${PAGE_SIZE}`;
    const res = await fetch(url, { headers: { 'Accept': 'application/json' } });
    if (!res.ok) throw new Error('목록 조회 실패');
    const data = await res.json();

    totalPages = Number(data.totalPages ?? 1);
    currentPage = Number(data.pageNum ?? pageNum);
    const items = Array.isArray(data.items) ? data.items : [];

    cacheByPage.set(currentPage, items);
    items.forEach(it => itemById.set(it.review_id, it));
    return items;
  }

  async function goPage(n) {
    if (n < 1 || n > totalPages) return;
    let items = cacheByPage.get(n);
    try {
      gridEl.setAttribute('aria-busy', 'true');
      if (!items) items = await fetchPage(n);
      renderGrid(items);
      currentPage = n;
      renderPagination();
    } catch (err) {
      console.error(err);
      gridEl.innerHTML = `<li class="rm-card is-error">목록을 불러오지 못했습니다.</li>`;
    } finally {
      gridEl.setAttribute('aria-busy', 'false');
    }
  }

  function bindEvents() {
    pageListEl.addEventListener('click', (e) => {
      const btn = e.target.closest('.rm-page__num');
      if (!btn) return;
      const n = Number(btn.dataset.page);
      if (n && n !== currentPage) goPage(n);
    });

    prevBtn?.addEventListener('click', () => {
      if (currentPage > 1) goPage(currentPage - 1);
    });

    nextBtn.addEventListener('click', () => {
      if (currentPage < totalPages) goPage(currentPage + 1);
    });

    firstBtn.addEventListener('click', () => goPage(1));

    gridEl.addEventListener('click', (e) => {
      const link = e.target.closest('.rm-card__link');
      if (!link) return;
      e.preventDefault();

      const card = link.closest('.rm-card');
      const id = Number(card?.dataset.reviewId);
      const item = itemById.get(id);
      if (!item) return;

      openModal(item);
    });

    modalEl.addEventListener('click', (e) => {
      if (e.target.matches('[data-close]')) closeModal();
    });
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && !modalEl.hasAttribute('hidden')) closeModal();
    });

    helpBtn.addEventListener('click', onHelpClick);
  }

  function openModal(item) {
    modalImg.src = item.image || '';
    modalTitle.textContent = item.title ?? '';
    modalAuthor.textContent = item.author ?? '';
    if (item.postdate) {
      modalDate.dateTime = item.postdate;
      modalDate.textContent = fmtDate(item.postdate);
    }
    setStars(modalRating, item.star); // ← 텍스트 별점 적용
    modalContent.textContent = item.content ?? '';

    modalProdLink.textContent = item.productName ?? '';
    modalProdLink.href = '#';
    helpBtn.dataset.reviewId = String(item.review_id);
    helpCount.textContent = String(item.review_like ?? 0);

    modalEl.removeAttribute('hidden');
    qs('.rm-modal__close', modalEl)?.focus();
    document.body.style.overflow = 'hidden';
  }

  function closeModal() {
    modalEl.setAttribute('hidden', '');
    document.body.style.overflow = '';
  }

  async function onHelpClick() {
    const reviewId = this.dataset.reviewId;
    const base = this.dataset.likeUrlBase || '/guest/review/api';
    if (!reviewId) return;

    // 1) 즉시 +1 (낙관적)
    const prev = Number(helpCount.textContent || 0);
    helpCount.textContent = String(prev + 1);

    try {
      // 2) 서버에 반영 요청 → 서버가 DB 갱신 후 "최신 카운트"를 JSON으로 반환한다고 가정
      const res = await fetch(`${base}/${reviewId}/like`, {
        method: 'POST',
        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
        // CSRF 사용 시 토큰 헤더 추가
      });
      if (!res.ok) throw new Error('도움이 됐어요 실패');

      const data = await res.json();
      // 3) 서버(DB)에서 갱신된 "진짜 값"으로 덮어씀 ⇒ 화면/DB 동기화 보장
      const newCnt = Number(data.review_like ?? (prev + 1));
      helpCount.textContent = String(newCnt);

      const item = itemById.get(Number(reviewId));
      if (item) { item.review_like = newCnt; itemById.set(item.review_id, item); }
    } catch (err) {
      console.error(err);
      // 실패 시 롤백
      helpCount.textContent = String(prev);
      alert('잠시 후 다시 시도해주세요.');
    }
  }

  async function init() {
    bindEvents();
    try {
      const items = await fetchPage(1);
      renderGrid(items);
      renderPagination();
    } catch (err) {
      console.error(err);
      gridEl.innerHTML = `<li class="rm-card is-error">데이터를 불러오지 못했습니다.</li>`;
    }
  }

  document.addEventListener('DOMContentLoaded', init);
})();
