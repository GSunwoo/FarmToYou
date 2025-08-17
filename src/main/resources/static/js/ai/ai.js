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
					    // 결과 메시지 분기
					    let aiText;
					    if (item.aiResult === "서버와의 연결이 끊겼습니다.") {
					        aiText = item.aiResult;
					    } else if (item.aiResult.includes("빨강")) {
					        aiText = "수확 가능!";
					    } else {
					        aiText = "아직 성장중이에요";
					    }

					    // file_path에서 파일명 추출
					    let fileName = item.file_path ? item.file_path.split("/").pop() : item.fileName;

					    // 날짜/시간 변환 (fileName 기반)
					    let baseName = fileName.replace(".jpg", "");
					    let datePart = baseName.split("_")[0];  
					    let timePart = baseName.split("_")[1];  

					    let year = datePart.substring(0,4);
					    let month = datePart.substring(4,6);
					    let day = datePart.substring(6,8);
					    let hour = timePart.substring(0,2);
					    let minute = timePart.substring(2,4);
					    let second = timePart.substring(4,6);

					    let formatted = `${year}년 ${month}월 ${day}일 ${hour}시 ${minute}분 ${second}초`;

					    $("#imageResult").append(
					        `<div>
					            <img src="${item.file_path}" width="200"/>
					            <p>${formatted} 상태 : ${aiText}</p>
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
