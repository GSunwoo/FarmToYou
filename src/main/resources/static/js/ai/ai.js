$(document).ready(function() {
    let intervalId;

    // 상태 점 색상 변경 함수
    function updateStatusDot(status) {
        const $dot = $("#statusDot");
        $dot.removeClass("idle live stopped");
        if(status === "live") $dot.addClass("live");
        else if(status === "stopped") $dot.addClass("stopped");
        else $dot.addClass("idle");
    }

    // 이미지 카드 렌더링 함수
    function renderImages(data) {
        const $container = $("#imageResult");
        $container.empty();

        data.forEach(item => {
            // AI 결과 분기
            let aiText;
            if (item.aiResult === "서버와의 연결이 끊겼습니다.") {
                aiText = item.aiResult;
            } else if (item.aiResult.includes("빨강")) {
                aiText = "수확 가능!";
            } else {
                aiText = "아직 성장중이에요";
            }

            // 파일명 안전 처리
            let fileName = item.file_path ? item.file_path.split("/").pop() : (item.fileName || "unknown.jpg");
            


            // 카드 HTML
            const cardHtml = `
                <div class="image-card">
                    <img src="${item.file_path}" alt="crop-image"/>
                    <span class="badge ${aiText === "수확 가능!" ? "ok" : "ng"}">${aiText}</span>
                    <div class="image-info">${fileName}</div>
                </div>
            `;
            $container.append(cardHtml);
        });
    }

    // 모니터링 시작
    $(document).on("click", "#startBtn", function() {
        $("#startBtn").hide();
        $("#stopBtn").show();
        $("#status").text("모니터링 중입니다...");
        updateStatusDot("live");

        // 즉시 한번 호출
        fetchData();

        // 10초마다 갱신
        intervalId = setInterval(fetchData, 10000);
    });

    // 모니터링 중단
    $(document).on("click", "#stopBtn", function() {
        clearInterval(intervalId);
        $("#stopBtn").hide();
        $("#startBtn").show();
        $("#status").text("대기중...");
        updateStatusDot("stopped");
    });

    // 서버에서 데이터 가져오기
    function fetchData() {
        $.getJSON(contextPath + "/seller/monitor-images.do", function(res) {
            if(res.result === "success") {
                renderImages(res.data);
                $("#update-time").show().text("최종 갱신: " + new Date().toLocaleTimeString());
            } else {
                $("#status").text("에러: " + res.error);
                updateStatusDot("stopped");
            }
        });
    }
});
