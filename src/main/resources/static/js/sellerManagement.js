// sellerManagement.js (교체)
document.addEventListener("DOMContentLoaded", () => {
  const root = document; // 섹션 클래스가 없어도 동작하도록

  const statusItems = root.querySelectorAll('.status-item[data-code]');
  const countEl = {
    chk_order:    root.querySelector('#count-chk_order'),
    prepare_order:root.querySelector('#count-prepare_order'),
    deli_order:   root.querySelector('#count-deli_order'),
    cmpl_order:   root.querySelector('#count-cmpl_order'),
  };

  // tbody를 더 폭넓게 탐색 (DOM이 살짝 어긋나도 잡히게)
  const tbody =
    root.querySelector(".orders-table tbody") ||
    root.querySelector("table.buyer-table tbody") ||
    root.querySelector("#order-list");

  if (!tbody) return;

  const LABEL = {
    chk_order: "주문확인",
    prepare_order: "상품준비중",
    deli_order: "배송중",
    cmpl_order: "배송완료",
  };
  const FROM_KO = {
    "주문확인": "chk_order",
    "상품준비중": "prepare_order",
    "배송중": "deli_order",
    "배송완료": "cmpl_order",
  };
  const NEXT = {
    chk_order: "prepare_order",
    prepare_order: "deli_order",
    deli_order: "cmpl_order",
  };

  function initRowStatus(tr) {
    let code = tr.dataset.status;

    if (!code) {
      const badge = tr.querySelector(".badge");
      const cls = badge && Array.from(badge.classList).find(c => c.startsWith("badge-"));
      if (cls) code = cls.replace("badge-", "");
    }
    if (!code) {
      const statusCell = tr.querySelector("td:nth-child(4)");
      if (statusCell && FROM_KO[statusCell.textContent.trim()]) {
        code = FROM_KO[statusCell.textContent.trim()];
      }
    }
    if (!code) return;

    tr.dataset.status = code;

    // 배지 동기화
    let badge = tr.querySelector(".badge");
    if (!badge) {
      const cell = tr.querySelector("td:nth-child(4)");
      if (cell) {
        badge = document.createElement("span");
        badge.className = "badge";
        cell.innerHTML = "";
        cell.appendChild(badge);
      }
    }
    if (badge) {
      badge.className = Array.from(badge.classList).filter(c => !c.startsWith("badge-")).join(" ");
      badge.classList.add("badge", `badge-${code}`);
      badge.textContent = LABEL[code] || "";
    }

    const btn = tr.querySelector(".next-btn, .btn-next");
    if (btn) {
      btn.setAttribute("type", "button"); // 폼 submit 방지
      btn.disabled = (code === "cmpl_order");
      btn.textContent = btn.disabled ? "완료" : "다음";
    }
  }

  tbody.querySelectorAll("tr").forEach(initRowStatus);

  function recount() {
    const counts = { chk_order:0, prepare_order:0, deli_order:0, cmpl_order:0 };
    tbody.querySelectorAll("tr").forEach(tr => {
      const s = tr.dataset.status;
      if (s && s in counts) counts[s]++;
    });
    Object.entries(countEl).forEach(([k, el]) => el && (el.textContent = counts[k]));
  }
  recount();

  let selected = null;
  function clearActive(){ statusItems.forEach(i=>i.classList.remove("active")); }
  function filterTo(code){
    tbody.querySelectorAll("tr").forEach(tr=>{
      tr.style.display = (!code || tr.dataset.status === code) ? "" : "none";
    });
  }

  statusItems.forEach(item=>{
    item.addEventListener("click", ()=>{
      const code = item.dataset.code;
      if (selected === code){ selected=null; clearActive(); filterTo(null); return; }
      selected = code; clearActive(); item.classList.add("active"); filterTo(code);
    });
  });

  // 버튼 클릭(문서 전체 위임) — DOM이 약간 어긋나도 잡힘
  document.addEventListener("click", async (e)=>{
    const btn = e.target.closest(".btn-confirm, .btn-next");
    if (!btn) return;
    const tr = btn.closest("tr");
    if (!tr) return;

    const cur = tr.dataset.status;
    if (!cur || cur === "cmpl_order") return;

    const next = NEXT[cur];
    if (!next) return;

    tr.dataset.status = next;

    const badge = tr.querySelector(".badge");
    if (badge) {
      badge.className = Array.from(badge.classList).filter(c => !c.startsWith("badge-")).join(" ");
      badge.classList.add("badge", `badge-${next}`);
      badge.textContent = LABEL[next];
    } else {
      const cell = tr.querySelector("td:nth-child(4)");
      if (cell) cell.textContent = LABEL[next];
    }

    btn.disabled = (next === "cmpl_order");
    btn.textContent = btn.disabled ? "완료" : "다음";

    recount();
    filterTo(selected);
	
	const purc_id = btn.dataset.purcId;
	  try {
	    const res = await fetch(`/seller/nextstate.do?purc_id=${purc_id}&next=${next}`, {
	      method: "POST",
	    });

	    if (!res.ok) {
	      throw new Error("서버 오류");
	    }
	  } catch (err) {
	    console.error("업데이트 실패:", err);
	    tr.dataset.status = cur;
	  }
  });
});
