package org.logistics.domain;

import java.math.BigDecimal;
import lombok.Data;

@Data
public class StockAnalysisResponseDTO {
    // 사업단위 및 창고명
    private String buName;
    private String warehouseName;

    // 품목 정보
    private String itemName;
    private String spec;
    private String baseUnit;
    private String itemBigCategory;
    private String itemMidCategory;
    private String itemSmallCategory;
    private String assetClass;

    // 수량 정보
    private BigDecimal beginningStock;
    private BigDecimal inboundQty;
    private BigDecimal outQty;
    private BigDecimal endingStock;
}