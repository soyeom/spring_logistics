package org.logistics.domain;

import java.math.BigDecimal;
import lombok.Data;

@Data
public class StockAnalysisResponseDTO {
    // business_unit 테이블
    private String buName;

    // warehouse_detail 테이블
    private String warehouseName;

    // item_master 테이블
    private String itemName;
    private String spec;
    private String baseUnit;
    private String itemBigCategory;
    private String itemMidCategory;
    private String itemSmallCategory;
    private String itemAssetClass;

    // 수량 및 금액 정보
    // (재고 분석 로직을 통해 계산되는 값)
    private BigDecimal beginningStock; // 기초 재고
    private BigDecimal inboundQty; // 입고 수량
    private BigDecimal outQty; // 출고 수량
    private BigDecimal endingStock; // 기말 재고
    private BigDecimal beginningAmount; // 기초 금액
    private BigDecimal inboundAmount; // 입고 금액
    private BigDecimal outAmount; // 출고 금액
    private BigDecimal endingAmount; // 기말 금액
}