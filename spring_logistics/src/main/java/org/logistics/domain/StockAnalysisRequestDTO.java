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
}