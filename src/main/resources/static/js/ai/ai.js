$(document).ready(function() {
    let intervalId;

    // 모니터링 시작
    $("#startBtn").on("click", function() {
        $("#startBtn").hide();
        $("#stopBtn").show();
        $("#status").text("모니터링 중입니다...");

        intervalId = setInterval(function() {
            $.getJSON(contextPath + "/seller/monitor-images.do", function(res) {
                if(res.result === "success") {
                    $("#imageResult").empty();
                    res.data.forEach(item => {
                        let aiText = item.aiResult.includes("빨강") ? "수확 가능!" : "아직 성장중이에요";
                        $("#imageResult").append(
                            `<div>
                                <img src="${item.file_path}" width="200"/>
                                <p>${item.fileName} → ${aiText}</p>
                            </div>`
                        );
                    });
                } else {
                    $("#status").text("에러: " + res.error);
                }
            });
        }, 10000); // 10초마다 갱신
    });

    // 모니터링 중단
    $("#stopBtn").on("click", function() {
        clearInterval(intervalId);
        $("#stopBtn").hide();
        $("#startBtn").show();
        $("#status").text("대기중...");
    });
});
