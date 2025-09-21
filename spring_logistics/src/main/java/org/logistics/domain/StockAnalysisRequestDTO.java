package org.logistics.domain;

import lombok.Data;

@Data
public class StockAnalysisRequestDTO {
    private Long buId;
    private Long warehouseId;
    private String importanceLevel;
    private String itemAssetClass;
    private String itemSmallCategory;
    private String itemName;
    private String spec;
    private String baseUnit;
    private String stockStandard;
    private String itemId;
    private String currentMonth;   // 예: "2025-09"
    private String prevYearMonth; // 계산용, service에서 자동 채움
    private String analysisItem; // "averageStock", "turnoverRate", "totalIn", "totalOut"

}