package com.farm.service;

import java.io.File;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class AIService {

    private final String folderPath = "C:/Users/kosmo/git/FarmToYou/bin/main/static/uploads/monitoring/";
    private final String flaskUrl = "http://127.0.0.1:8587/getDecodeImage.fk";

    private int currentIndex = 0;
    private File[] files;

    private void initFiles() {
        File folder = new File(folderPath);
        if (!folder.exists() || !folder.isDirectory()) {
            files = new File[0];
            return;
        }
        files = folder.listFiles((dir, name) -> {
            String lower = name.toLowerCase();
            return lower.endsWith(".jpg") || lower.endsWith(".png");
        });
        if (files == null) files = new File[0];
    }

    public Map<String, Object> getNextFileResult() {
        if (files == null || files.length == 0) {
            initFiles();
        }

        if (files.length == 0) return null;

        File file = files[currentIndex];
        currentIndex = (currentIndex + 1) % files.length;

        Map<String, Object> item = new HashMap<>();
        try {
            byte[] bytes = Files.readAllBytes(file.toPath());
            String base64 = java.util.Base64.getEncoder().encodeToString(bytes);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.TEXT_PLAIN);

            HttpEntity<String> entity = new HttpEntity<>(base64, headers);
            String urlWithParam = flaskUrl + "?imageName=" + file.getName();

            RestTemplate restTemplate = new RestTemplate();
            String response = restTemplate.postForObject(urlWithParam, entity, String.class);

            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> responseMap = mapper.readValue(response, new TypeReference<Map<String,Object>>() {});
            Map<String, Object> predMap = (Map<String, Object>) responseMap.get("pred");
            String aiLabel = predMap != null ? predMap.get("label").toString() : "Unknown";

            // ➕ Flask에서 반환한 URL 그대로 사용
            String flaskFilePath = (String) responseMap.get("file_path");
            String urlPath = flaskFilePath.replace("\\", "/")
                                          .replace("C:/Users/kosmo/git/FarmToYou/bin/main/static", "");

            item.put("fileName", file.getName());
            item.put("file_path", urlPath);  // ➕ 여기서 URL 전달
            item.put("aiResult", aiLabel);

        } catch (Exception e) {
            item.put("fileName", file.getName());
            item.put("file_path", ""); 

            if (e instanceof java.net.ConnectException || e.getCause() instanceof java.net.ConnectException) {
                item.put("aiResult", "서버와의 연결이 끊겼습니다.");
            } else {
                item.put("aiResult", "ERROR: " + e.getMessage());
            }
        }
        return item;
    }
}
