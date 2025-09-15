package org.logistics.domain;

import lombok.Data;

@Data
public class StockAnalysisResponseDTO {
    private String itemAssetClass;    // 품목자산분류
    private String itemBigCategory;   // 품목대분류
    private String itemMidCategory;   // 품목중분류
    private String itemSmallCategory; // 품목소분류
    private Long itemId;              // 품번
    private String itemName;          // 품명
    private String spec;              // 규격
    private String baseUnit;          // 단위
    private String importanceLevel;   // 중요도

    // 재고 관련
    private Integer beginningStock;   // 기초재고
    private Integer inboundQty;       // 입고수량
    private Integer outQty;           // 출고수량
    private Integer endingStock;      // 기말재고

    // 조정 관련 (추가)
    private String adjustIn;          // 재고실사조정(입고)
    private String adjustOut;         // 재고실사조정(출고)
}
