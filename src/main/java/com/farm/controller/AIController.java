package com.farm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.farm.service.AIService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class AIController {

    private final AIService aiService;

    @GetMapping("/seller/monitor-images.do")
    public Map<String, Object> monitorImages() {
        Map<String, Object> result = new HashMap<>();
        try {
            Map<String, Object> data = aiService.getNextFileResult();
            if (data != null) {
                result.put("result", "success");
                result.put("data", List.of(data));
            } else {
                result.put("result", "empty");
                result.put("data", List.of());
            }
        } catch (Exception e) {
            result.put("result", "fail");
            result.put("error", e.getMessage());
        }
        return result;
    }
}
