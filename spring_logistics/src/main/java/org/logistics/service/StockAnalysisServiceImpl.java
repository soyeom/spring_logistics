package org.logistics.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;
import org.logistics.mapper.StockAnalysisMapper;
import org.springframework.stereotype.Service;

@Service
public class StockAnalysisServiceImpl implements StockAnalysisService {
    private final StockAnalysisMapper stockAnalysisMapper;

    public StockAnalysisServiceImpl(StockAnalysisMapper stockAnalysisMapper) {
        this.stockAnalysisMapper = stockAnalysisMapper;
    }

    @Override
    public List<Map<String, Object>> getStockAnalysisData(StockAnalysisRequestDTO requestDTO) {
        List<Map<String, Object>> resultList = new ArrayList<>();

        // ✅ currentMonth 기본값 세팅
        String currentMonth = requestDTO.getCurrentMonth();
        if (currentMonth == null || currentMonth.trim().isEmpty()) {
            LocalDate now = LocalDate.now();
            currentMonth = String.format("%04d-%02d", now.getYear(), now.getMonthValue());
            requestDTO.setCurrentMonth(currentMonth);
        }

        // ✅ analysisItem 기본값
        String analysisItem = requestDTO.getAnalysisItem();
        if (analysisItem == null || analysisItem.trim().isEmpty()) {
            analysisItem = "totalIn";
            requestDTO.setAnalysisItem(analysisItem);
        }

        // 1) 기준 아이템 리스트 조회
        List<StockAnalysisResponseDTO> items = stockAnalysisMapper.getBaseItemList(requestDTO);
        if (items == null || items.isEmpty()) {
            return resultList;
        }

        // 2) 조회기간 계산
        List<PeriodRange> periods = calculatePeriods(currentMonth);

        // 3) 아이템별 결과 조립
        for (StockAnalysisResponseDTO item : items) {
            Map<String, Object> row = new LinkedHashMap<>();

            // 고정 컬럼
            row.put("itemAssetClass", item.getItemAssetClass());
            row.put("itemBigCategory", item.getItemBigCategory());
            row.put("itemSmallCategory", item.getItemSmallCategory());
            row.put("itemId", item.getItemId());
            row.put("itemName", item.getItemName());
            row.put("spec", item.getSpec());
            row.put("itemMidCategory", item.getItemMidCategory());
            row.put("baseUnit", item.getBaseUnit());

            // 기간별 동적 값
            for (PeriodRange p : periods) {
                Double value = stockAnalysisMapper.getPeriodValue(
                    item.getItemId(),
                    requestDTO.getBuId(),
                    p.getStartParam(),
                    p.getEndParam(),
                    analysisItem
                );

                // SQL에서 이미 계산된 값이므로 그대로 사용 (null → 0 치환만)
                row.put(p.getEndKey(), value == null ? 0 : value);
            }

            resultList.add(row);
        }

        return resultList;
    }

    // 📌 기간 계산
    private List<PeriodRange> calculatePeriods(String currentMonth) {
        List<PeriodRange> result = new ArrayList<>();
        String[] ym = currentMonth.split("-");
        int year = Integer.parseInt(ym[0]);
        int month = Integer.parseInt(ym[1]);

        final int periodSize = 3; // 3개월 단위
        final int count = 4;      // 4회 반복

        for (int i = 0; i < count; i++) {
            int endMonth = month - (i * periodSize);
            int endYear = year;
            while (endMonth <= 0) {
                endMonth += 12;
                endYear--;
            }

            int startMonth = endMonth - (periodSize - 1);
            int startYear = endYear;
            while (startMonth <= 0) {
                startMonth += 12;
                startYear--;
            }

            String endKey = String.format("%04d-%02d", endYear, endMonth);   // JSON key
            String startParam = String.format("%04d%02d", startYear, startMonth); // SQL param
            String endParam = String.format("%04d%02d", endYear, endMonth);

            result.add(new PeriodRange(endKey, startParam, endParam));
        }

        return result;
    }

    // 내부 클래스: 기간 정보
    private static class PeriodRange {
        private final String endKey;     // ex) 2025-09 (표에 표시될 값)
        private final String startParam; // ex) 202506 (쿼리 파라미터)
        private final String endParam;   // ex) 202509 (쿼리 파라미터)

        public PeriodRange(String endKey, String startParam, String endParam) {
            this.endKey = endKey;
            this.startParam = startParam;
            this.endParam = endParam;
        }

        public String getEndKey() { return endKey; }
        public String getStartParam() { return startParam; }
        public String getEndParam() { return endParam; }
    }
}
