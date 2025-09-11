package org.logistics.domain;

import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class StockAnalysisResponseDTO {
    // 사업단위 및 창고명
    private String buName;
    private String warehouseName;

    // 품목 정보
    private String itemName;
    private String spec;
    private String baseUnit;
    private String itemInternalCode;
    private String itemBigCategory;
    private String itemMidCategory;
    private String itemSmallCategory;
    private String itemAssetClass; // asset_class 필드와 매칭

    // 수량 정보
    private BigDecimal beginningStock;
    private BigDecimal inboundQty;
    private BigDecimal outQty;
    private BigDecimal endingStock;

    // 금액 정보 (확장용)
    private BigDecimal beginningAmount;
    private BigDecimal inboundAmount;
    private BigDecimal outAmount;
    private BigDecimal endingAmount;

    // 기타
    private Date createdDate; // Date 타입으로 변경
    private String lotNo;

    // 🔍 분석 결과
    private String analysisLabel;      // 예: 평균재고량
    private BigDecimal analysisValue;  // 예: 105.23
    private BigDecimal resultValue;
    private String label;
}
