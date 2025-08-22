
document.addEventListener("DOMContentLoaded", function() {
    const cartBody = document.getElementById("cart-body");
    const totalAmountEl = document.getElementById("total-amount");
    const payBtn = document.getElementById("wishlist");
    const selectAll = document.getElementById("select-all");

    // ✅ 수량 가져오기/단가 가져오기
    function getRowQty(row) {
        return parseInt(row.querySelector(".qty-input").value, 10) || 0;
    }
    function getRowUnitPrice(row) {
        return parseInt(row.querySelector(".price").dataset.price, 10) || 0;
    }

    // ✅ 숫자 포맷
    function formatNumber(n) { return n.toLocaleString("ko-KR"); }

    // ✅ 선택된 항목 합계 계산
    function computeSelectedTotal() {
        let sum = 0, anyChecked = false;
        cartBody.querySelectorAll("tr").forEach(row => {
            const cb = row.querySelector(".select-item");
            if (cb && cb.checked) {
                anyChecked = true;
                sum += getRowUnitPrice(row) * getRowQty(row);
            }
        });
        totalAmountEl.textContent = formatNumber(sum);
        if (payBtn) payBtn.disabled = !anyChecked;
    }

    // ✅ 수량 변경 후 가격 갱신
    function recalcRowPrice(row) {
        const unit = getRowUnitPrice(row);
        const qty = getRowQty(row);
        row.querySelector(".price").textContent = formatNumber(unit * qty) + "원";
    }

    // ✅ 이벤트: 수량 변경
    cartBody.addEventListener("click", function(e) {
        if (!e.target.classList.contains("qty-btn")) return;

        const row = e.target.closest("tr");
        const wishId = row.dataset.wishId;
        const prodId = row.dataset.prodId;
        const qtyInput = row.querySelector(".qty-input");
        let qty = parseInt(qtyInput.value, 10);
        const delta = parseInt(e.target.dataset.delta, 10);

        if (delta === -1 && qty <= 1) return;
        const newQty = qty + delta;

        fetch(`/wishlist/updateQty.do`, {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: `prod_qty=${newQty}&wish_id=${wishId}`
        })
        .then(res => res.text())
        .then(result => {
            if (result === "success") {
                qtyInput.value = newQty;
                recalcRowPrice(row);
                computeSelectedTotal();
            } else if (result === "login") {
                alert("로그인이 필요합니다.");
            } else {
                alert("수량 변경 실패");
            }
        })
        .catch(err => console.error("AJAX 오류:", err));
    });

    // ✅ 이벤트: 삭제
    cartBody.addEventListener("click", function(e) {
        if (!e.target.classList.contains("delete-btn")) return;
        if (!confirm("정말 삭제하시겠습니까?")) return;

        const row = e.target.closest("tr");
        const wishId = row.dataset.wishId;
        const prodId = row.dataset.prodId;

        fetch(`/wishlist/delete.do`, {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: `prod_id=${prodId}&wish_id=${wishId}`
        })
        .then(res => res.text())
        .then(result => {
            if (result === "success") {
                row.remove();
                alert("삭제되었습니다.");
                computeSelectedTotal();

                if (!document.querySelector("#cart-body tr")) {
                    document.querySelector(".cart-container").innerHTML =
                      "<div style='text-align:center;padding:20px;'>장바구니에 상품이 없습니다.</div>";
                }
            } else if (result === "login") {
                alert("로그인이 필요합니다.");
            } else {
                alert("삭제 실패");
            }
        })
        .catch(err => console.error("AJAX 오류:", err));
    });

    // ✅ 이벤트: 체크박스 선택
    cartBody.addEventListener("change", function(e) {
        if (e.target.classList.contains("select-item")) {
            computeSelectedTotal();
            // 부분선택 시 전체선택 상태 갱신
            const items = cartBody.querySelectorAll(".select-item");
            selectAll.checked = [...items].every(cb => cb.checked);
        }
    });

    // ✅ 이벤트: 전체선택
    if (selectAll) {
        selectAll.addEventListener("change", () => {
            const checked = selectAll.checked;
            cartBody.querySelectorAll(".select-item").forEach(cb => cb.checked = checked);
            computeSelectedTotal();
        });
    }

    // ✅ 결제하기 버튼 클릭
    if (payBtn) {
        payBtn.addEventListener("click", () => {
            const selectedRows = [...cartBody.querySelectorAll("tr")].filter(r => {
                const cb = r.querySelector(".select-item");
                return cb && cb.checked;
            });
            if (selectedRows.length === 0) {
                alert("결제할 상품을 선택해주세요.");
                return;
            }

            const qs = new URLSearchParams();
            selectedRows.forEach(row => {
                const wishId = row.dataset.wishId;
                qs.append("wishlist", wishId);
            });

            window.location.href = ctx + "/buyer/purchase/wishlist.do?" + qs.toString();
        });
    }

    // ✅ 초기 상태
    totalAmountEl.textContent = "0";
    if (payBtn) payBtn.disabled = true;
});
