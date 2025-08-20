// 검색창 드롭다운
document.addEventListener('DOMContentLoaded', function SAFE_SEARCH_BIND() {
  try {
    const searchInput = document.querySelector('.search-box input');
    const dropdown = document.getElementById('search-dropdown');
    if (searchInput && dropdown) {
      searchInput.addEventListener('focus', () => { dropdown.style.display = 'block'; });
      searchInput.addEventListener('blur', () => { setTimeout(() => { dropdown.style.display = 'none'; }, 200); });
    }
  } catch (e) { console.warn('search box bind skipped', e); }
});

// === 판매 통계: soldData [{date, sold, sales}] 사용 ===
let chart;

function renderChart(rows) {
  const canvas = document.getElementById("salesRevenueChart");
  if (!canvas) return;

  // 부모 크기에 맞추기
  const wrap = canvas.parentElement;
  if (wrap) {
    const rect = wrap.getBoundingClientRect();
    canvas.width = rect.width;
    canvas.height = rect.height;
  }

  if (chart) chart.destroy();

  chart = new Chart(canvas, {
    type: "bar",
    data: {
      labels: rows.map(r => r.date),
      datasets: [
        { label: "판매량",  data: rows.map(r => r.sold ?? 0),  yAxisID: "ySales" },
        { label: "매출(원)", data: rows.map(r => r.sales ?? 0), yAxisID: "yRevenue" }
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: true },
        tooltip: {
          callbacks: {
            label: (ctx) => {
              const v = ctx.raw ?? 0;
              return `${ctx.dataset.label}: ${ctx.dataset.yAxisID === 'yRevenue' ? v.toLocaleString() + '원' : v}`;
            }
          }
        }
      },
      scales: {
        ySales:   { type: "linear", position: "left",  title: { display: true, text: "판매량" }, ticks: { precision: 0 } },
        yRevenue: { type: "linear", position: "right", title: { display: true, text: "매출(원)" }, grid: { drawOnChartArea: false },
                    ticks: { callback: v => Number(v).toLocaleString() } },
        x:        { title: { display: true, text: "날짜" } },
      }
    },
  });
}

// API에서 판매 통계 로드
function loadSoldData(memberId) {
  fetch(`/seller/api/sold-stats?memberId=${memberId}`)
    .then(res => res.json())
    .then(soldData => {
      renderChart(Array.isArray(soldData) ? soldData : []);
    })
    .catch(err => {
      console.error('판매통계 불러오기 실패', err);
      renderChart([]);
    });
}

// 부모 크기 변하면 차트 재렌더
function attachResizeObserver() {
  const canvas = document.getElementById("salesRevenueChart");
  if (!canvas || !canvas.parentElement) return;
  const ro = new ResizeObserver(() => {
    if (!chart) return;
    renderChart(chart.data.labels.map((_, i) => ({
      date: chart.data.labels[i],
      sold: chart.data.datasets[0].data[i],
      sales: chart.data.datasets[1].data[i]
    })));
  });
  ro.observe(canvas.parentElement);
}

// 농작물 표시
function renderCrop(data) {
  const imgWrap = document.getElementById("cropImageWrap");   // 최근등록농작물 카드
  const resultWrap = document.getElementById("cropResultWrap"); // 스마트팜 카드
  const updateTime = document.getElementById("updateTime");     // 스마트팜 카드
  if (!resultWrap) return;

  const url = data?.imageUrl || "";
  const resultText = data?.result || "-";
  const isOk = String(resultText).includes("정상");
  const resultClass = "crop-result " + (isOk ? "result-ok" : "result-error");

  // 이미지: 없으면 placeholder 박스
  if (imgWrap) {
    imgWrap.innerHTML = url
      ? `<img src="${url}" alt="" class="crop-image" onerror="this.replaceWith(Object.assign(document.createElement('div'),{className:'crop-image',textContent:'이미지 없음',style:'display:flex;align-items:center;justify-content:center;opacity:.5;' }))">`
      : `<div class="crop-image" style="display:flex;align-items:center;justify-content:center;opacity:.5;">이미지 없음</div>`;
  }

  // 판정 결과 배지(스마트팜 카드)
  resultWrap.innerHTML = `<div class="${resultClass}">판정 결과: ${resultText}</div>`;

  if (updateTime) {
    updateTime.style.display = "block";
    updateTime.textContent = "최근 업데이트: " + new Date().toLocaleTimeString();
  }
}



// 농작물 API 호출
/*
function fetchCropData() {
  fetch("/api/crop-latest")
    .then(res => res.json())
    .then(data => renderCrop(data))
    .catch(err => {
      console.error("농작물 데이터 불러오기 실패", err);
      const container = document.getElementById("cropContainer");
      if (container) container.innerHTML = `<div class="loading-text">데이터를 가져오지 못했습니다.</div>`;
    });
}
*/
// 초기 실행
document.addEventListener("DOMContentLoaded", () => {
  attachResizeObserver();
  const memberId = window.LOGIN_MEMBER_ID || 1;
  loadSoldData(memberId);
  fetchCropData();
  setInterval(fetchCropData, 10000);
});
