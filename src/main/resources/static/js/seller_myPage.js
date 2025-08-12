// 검색창 드롭다운(없어도 안전하게 동작)
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

const initialChartData = [
  { date: "08-01", sales: 120, revenue: 240000 },
  { date: "08-02", sales: 95,  revenue: 190000 },
  { date: "08-03", sales: 140, revenue: 280000 },
  { date: "08-04", sales: 110, revenue: 220000 },
  { date: "08-05", sales: 160, revenue: 320000 },
];

let chart;

function renderChart(data) {
  const canvas = document.getElementById("salesRevenueChart");
  if (!canvas) return;

  // 부모 크기에 맞춰 canvas 크기 제어
  const wrap = canvas.parentElement;
  if (wrap) {
    const rect = wrap.getBoundingClientRect();
    canvas.width = rect.width;
    canvas.height = rect.height; // CSS에서 높이 지정(예: 320px)
  }

  if (chart) chart.destroy();

  chart = new Chart(canvas, {
    type: "bar",
    data: {
      labels: data.map(d => d.date),
      datasets: [
        { label: "판매량",  data: data.map(d => d.sales),   yAxisID: "ySales" },
        { label: "매출(원)", data: data.map(d => d.revenue), yAxisID: "yRevenue" },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false, // 부모 높이에 맞춤
      interaction: { mode: "nearest", axis: "x", intersect: true },
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
        ySales:    { type: "linear", position: "left",  title: { display: true, text: "판매량" }, ticks: { precision: 0 } },
        yRevenue:  { type: "linear", position: "right", title: { display: true, text: "매출(원)" }, grid: { drawOnChartArea: false },
                     ticks: { callback: v => Number(v).toLocaleString() } },
        x:         { title: { display: true, text: "날짜" } },
      }
    },
  });
}

// 부모 크기 변하면 차트 재렌더
function attachResizeObserver() {
  const canvas = document.getElementById("salesRevenueChart");
  if (!canvas || !canvas.parentElement) return;
  const ro = new ResizeObserver(() => {
    if (!chart) return;
    // 데이터 유지한 채 리사이즈만
    renderChart(chart.data.labels.map((_, i) => ({
      date: chart.data.labels[i],
      sales: chart.data.datasets[0].data[i],
      revenue: chart.data.datasets[1].data[i]
    })));
  });
  ro.observe(canvas.parentElement);
}

function renderCrop(data) {
  const container = document.getElementById("cropContainer");
  const updateTime = document.getElementById("updateTime");
  if (!container) return;

  const isOk = String(data.result || "").includes("정상");
  const resultClass = "crop-result " + (isOk ? "result-ok" : "result-error");

  container.innerHTML = `
    <img src="${data.imageUrl || ""}" alt="농작물" class="crop-image" />
    <div class="${resultClass}">판정 결과: ${data.result || "-"}</div>
  `;

  if (updateTime) {
    updateTime.style.display = "block";
    updateTime.textContent = "최근 업데이트: " + new Date().toLocaleTimeString();
  }
}

function loadLast5(memberId){
  fetch(`/api/dashboard/last5?memberId=${memberId}`)
    .then(res => res.json())
    .then(list => {
      if (!Array.isArray(list) || list.length === 0) return;
      renderChart(list);
    })
    .catch(err => {
      console.error('판매통계 불러오기 실패', err);
      renderChart([
        { date: "—", sales: 0, revenue: 0 },
        { date: "—", sales: 0, revenue: 0 },
        { date: "—", sales: 0, revenue: 0 },
        { date: "—", sales: 0, revenue: 0 },
        { date: "—", sales: 0, revenue: 0 }
      ]);
    });
}

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

document.addEventListener("DOMContentLoaded", () => {
  renderChart(initialChartData);      // 더미 데이터 먼저
  attachResizeObserver();             // 레이아웃에 맞춰 반응형
  const memberId = window.LOGIN_MEMBER_ID || 1;
  loadLast5(memberId);                // 실데이터 들어오면 교체
  fetchCropData();                    // 최근 농작물
  setInterval(fetchCropData, 10000);  // 10초마다 갱신
});
