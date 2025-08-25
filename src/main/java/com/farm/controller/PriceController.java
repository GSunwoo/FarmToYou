package com.farm.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@RestController
public class PriceController {

    private final String API_KEY = "f42c857e-d5bc-47e7-a59e-5d2de8725e9a";
    private final String API_ID = "dudns5552";
    private final String BASE_URL = "https://www.kamis.or.kr/service/price/xml.do?action=dailyPriceByCategoryList";

    private final ObjectMapper mapper = new ObjectMapper();

    // ➕ 품목별 최소 가격 조건을 Map으로 정의 (과일/채소 구분 없이 관리)
    private final Map<String, List<String>> REQUIRED_FIELDS = Map.of(
            "양파", List.of("dpr3", "dpr7"),
            "마늘", List.of("dpr3", "dpr7"),
            "파", List.of("dpr3", "dpr7"),
            "깻잎", List.of("dpr3", "dpr7"),
            "딸기", List.of("dpr1"),
            "복숭아", List.of("dpr1")
    );

    private final Map<String, Map<String, String>> ITEMS = Map.ofEntries(
            Map.entry("양파", Map.of("category", "200", "code", "245")),
            Map.entry("마늘", Map.of("category", "200", "code", "248")),
            Map.entry("파", Map.of("category", "200", "code", "246")),
            Map.entry("깻잎", Map.of("category", "200", "code", "253")),
            Map.entry("딸기", Map.of("category", "200", "code", "226")),
            Map.entry("배추", Map.of("category", "200", "code", "211")),
            Map.entry("상추", Map.of("category", "200", "code", "214")),
            Map.entry("수박", Map.of("category", "200", "code", "221")),
            Map.entry("참외", Map.of("category", "200", "code", "222")),
            Map.entry("토마토", Map.of("category", "200", "code", "225")),
            Map.entry("멜론", Map.of("category", "200", "code", "257")),
            Map.entry("방울토마토", Map.of("category", "200", "code", "422")),
            Map.entry("사과", Map.of("category", "400", "code", "411")),
            Map.entry("배", Map.of("category", "400", "code", "412")),
            Map.entry("포도", Map.of("category", "400", "code", "414")),
            Map.entry("감귤", Map.of("category", "400", "code", "415")),
            Map.entry("복숭아", Map.of("category", "400", "code", "413"))
    );

    @GetMapping("/price")
    public Map<String, Object> price(@RequestParam("name") String name) {
        Map<String, Object> results = new LinkedHashMap<>();

        if (!ITEMS.containsKey(name)) {
            results.put(name, null);
            return results;
        }

        Map<String, String> info = ITEMS.get(name);
        String today = java.time.LocalDate.now().toString();
        RestTemplate restTemplate = new RestTemplate();

        try {
            String url = BASE_URL
                    + "&p_cert_key=" + API_KEY
                    + "&p_cert_id=" + API_ID
                    + "&p_returntype=json"
                    + "&p_product_cls_code=01"
                    + "&p_item_category_code=" + info.get("category")
                    + "&p_country_code=1101"
                    + "&p_regday=" + today
                    + "&p_convert_kg_yn=N";

            HttpHeaders headers = new HttpHeaders();
            headers.setAccept(List.of(MediaType.APPLICATION_JSON));
            HttpEntity<Void> entity = new HttpEntity<>(headers);

            String body = restTemplate.exchange(url, HttpMethod.GET, entity, String.class).getBody();
            if (body == null) {
                results.put(name, null);
                return results;
            }

            Map<String, Object> response = mapper.readValue(body, new TypeReference<>() {});
            List<Map<String, Object>> items = normalizeToListOfMap(((Map<String, Object>) response.get("data")).get("item"));

            boolean found = false;
            for (Map<String, Object> item : items) {
                String itemCode = String.valueOf(item.get("item_code"));
                String rank = String.valueOf(item.get("rank"));

                if (info.get("code").equals(itemCode) && "상품".equals(rank)) {
                    Double priceToday = toDouble(item.get("dpr1"));
                    Double priceYesterday = toDouble(item.get("dpr2"));
                    Double priceWeek = toDouble(item.get("dpr3"));
                    Double priceNormal = toDouble(item.get("dpr7"));
                    Double actualPrice = (priceToday != null) ? priceToday : priceYesterday;

                    // ➕ 필수 데이터 체크
                    boolean missingRequired = REQUIRED_FIELDS.getOrDefault(name, List.of()).stream()
                            .anyMatch(f -> toDouble(item.get(f)) == null);

                    if (missingRequired) {
                        results.put(name, null);
                    } else {
                        Map<String, Object> res = new LinkedHashMap<>();
                        res.put("prices", Map.of(
                                "평년", priceNormal,
                                "1주일전", priceWeek,
                                "오늘", actualPrice
                        ));
                        res.put("percent", Map.of(
                                "평년", round1((actualPrice - priceNormal) / priceNormal * 100),
                                "1주일전", round1((actualPrice - priceWeek) / priceWeek * 100)
                        ));
                        results.put(name, res);
                    }

                    found = true;
                    break;
                }
            }

            if (!found) {
                results.put(name, null);
            }

        } catch (Exception e) {
            results.put(name, null);
        }

        return results;
    }

    // ===== 유틸 =====
    private static List<Map<String, Object>> normalizeToListOfMap(Object obj) {
        if (obj instanceof List) return (List<Map<String, Object>>) obj;
        if (obj instanceof Map) return List.of((Map<String, Object>) obj);
        return Collections.emptyList();
    }

    private static Double toDouble(Object val) {
        if (val == null) return null;
        String s = val.toString().replace(",", "").trim();
        if (s.isEmpty() || "-".equals(s)) return null;
        try { return Double.valueOf(s); } catch (NumberFormatException e) { return null; }
    }

    private static double round1(double v) {
        return Math.round(v * 10.0) / 10.0;
    }
}
