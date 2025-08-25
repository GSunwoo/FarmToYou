// =================== 검색창 드롭다운 ===================
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

// =================== 판매 통계 ===================
let salesChart;

function renderChart(json) {
	const canvas = document.getElementById("salesRevenueChart");
	if (!canvas) return;

	if (salesChart) salesChart.destroy();

	const rows = json.date.map((d, idx) => ({
		date: d,
		sold: json.sold[idx] ?? 0,
		sales: json.sales[idx] ?? 0
	}));

	salesChart = new Chart(canvas, {
		type: "bar",
		data: {
			labels: rows.map(r => r.date),
			datasets: [
				{ label: "판매량", data: rows.map(r => r.sold), yAxisID: "ySales" },
				{ label: "매출(원)", data: rows.map(r => r.sales), yAxisID: "yRevenue" }
			]
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
				ySales: { type: "linear", position: "left", title: { display: true, text: "판매량" }, ticks: { precision: 0 } },
				yRevenue: {
					type: "linear", position: "right", title: { display: true, text: "매출(원)" }, grid: { drawOnChartArea: false },
					ticks: { callback: v => Number(v).toLocaleString() }
				},
				x: { title: { display: true, text: "날짜" } }
			}
		}
	});
}

function loadSoldData(memberId) {
	fetch(`/seller/api/sold-stats?memberId=${memberId}`)
		.then(res => res.json())
		.then(json => renderChart(json))
		.catch(err => {
			console.error('판매통계 불러오기 실패', err);
			renderChart({ date: [], sold: [], sales: [] });
		});
}

function attachResizeObserver() {
	const canvas = document.getElementById("salesRevenueChart");
	if (!canvas || !canvas.parentElement) return;
	const ro = new ResizeObserver(() => {
		if (!salesChart) return;
		const transformed = {
			date: salesChart.data.labels,
			sold: salesChart.data.datasets[0].data,
			sales: salesChart.data.datasets[1].data
		};
		renderChart(transformed);
	});
	ro.observe(canvas.parentElement);
}

// =================== 농작물 표시 ===================
function renderCrop(data) {
	const imgWrap = document.getElementById("cropImageWrap");   // 최근등록농작물 카드
	const resultWrap = document.getElementById("cropResultWrap"); // 스마트팜 카드
	const updateTime = document.getElementById("updateTime");     // 스마트팜 카드
	if (!resultWrap) return;

	const url = data?.imageUrl || "";
	const resultText = data?.result || "-";
	const isOk = String(resultText).includes("정상");
	const resultClass = "crop-result " + (isOk ? "result-ok" : "result-error");

	if (imgWrap) {
		imgWrap.innerHTML = url
			? `<img src="${url}" alt="" class="crop-image" onerror="this.replaceWith(Object.assign(document.createElement('div'),{className:'crop-image',textContent:'이미지 없음',style:'display:flex;align-items:center;justify-content:center;opacity:.5;' }))">`
			: `<div class="crop-image" style="display:flex;align-items:center;justify-content:center;opacity:.5;">이미지 없음</div>`;
	}

	resultWrap.innerHTML = `<div class="${resultClass}">판정 결과: ${resultText}</div>`;

	if (updateTime) {
		updateTime.style.display = "block";
		updateTime.textContent = "최근 업데이트: " + new Date().toLocaleTimeString();
	}
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

// =================== 농산물 가격 차트 ===================
let priceChart;


document.addEventListener("DOMContentLoaded", () => {
	const canvas = document.getElementById("chart-canvas");
	const buttons = document.querySelectorAll(".item-btn");
	const noDataMsg = document.getElementById("no-data-msg");
	const selectedName = document.getElementById("selected-name");
	document.querySelector(".item-btn")?.click();
	if (!canvas || !buttons) return;

	buttons.forEach(btn => {
		btn.addEventListener("click", () => {
			// 기존 선택된 버튼에서 active 제거
			buttons.forEach(b => b.classList.remove("active"));
			// 클릭된 버튼에 active 클래스 추가
			btn.classList.add("active");
			
			const itemName = btn.getAttribute("data-name");
			selectedName.textContent = itemName;
			fetch(`/price?name=${encodeURIComponent(itemName)}`)
				.then(res => res.json())
				.then(data => {
					const itemData = data[itemName];
					if (!itemData) {
						canvas.style.display = "none";
						noDataMsg.style.display = "block";
						noDataMsg.textContent = "아직 가격데이터가 없습니다.";
						return;
					}

					noDataMsg.style.display = "none";
					canvas.style.display = "block";

					const prices = itemData.prices;

					if (priceChart) priceChart.destroy();

					priceChart = new Chart(canvas.getContext("2d"), {
						type: "bar",
						data: {
							labels: ["평년", "1주일전", "오늘"],
							datasets: [{
								label: "가격(원)",
								data: [prices["평년"], prices["1주일전"], prices["오늘"]],
								backgroundColor: ["#a3d2ca","#5eaaa8","#056676"]
							}]
						},
						options: {
							plugins: { legend: { display: false } },
							scales: { y: { beginAtZero: true } }
						}
					});
				})
				.catch(err => {
					canvas.style.display = "none";
					noDataMsg.style.display = "block";
					noDataMsg.textContent = "데이터 로드 중 오류가 발생했습니다.";
					console.error(err);
				});
		});
	});
});

// =================== 초기 실행 ===================
document.addEventListener("DOMContentLoaded", () => {
	const memberId = window.LOGIN_MEMBER_ID || 1;
	loadSoldData(memberId);
	attachResizeObserver();
	fetchCropData();
	setInterval(fetchCropData, 10000);
});
