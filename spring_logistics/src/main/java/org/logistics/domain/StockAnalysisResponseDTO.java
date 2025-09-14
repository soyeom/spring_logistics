package org.logistics.domain;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;

@Data
public class StockAnalysisResponseDTO {

    // 품목 및 창고/사업단위 마스터 정보 (테이블의 고정된 왼쪽 컬럼)
    private String buName; // 사업단위 이름
    private String warehouseName; // 창고 이름
    private String itemName; // 품명
    private String spec; // 규격
    private String baseUnit; // 단위
    private String itemBigCategory; // 품목 대분류
    private String itemMidCategory; // 품목 중분류
    private String itemSmallCategory; // 품목 소분류
    private String itemAssetClass; // 품목 자산분류

    // 기간별 분석 결과를 담는 리스트
    private List<PeriodData> periodDataList;

    // PeriodData: 각 기간의 재고 분석 데이터를 담는 내부 클래스
    @Data
    public static class PeriodData {
        private String period; // "1회차 비교", "2024년 1월" 등
        private BigDecimal beginningStock;
        private BigDecimal endingStock;
        private BigDecimal inboundQty;
        private BigDecimal outQty;
        private BigDecimal beginningAmount;
        private BigDecimal endingAmount;
        private BigDecimal inboundAmount;
        private BigDecimal outAmount;
    }
}