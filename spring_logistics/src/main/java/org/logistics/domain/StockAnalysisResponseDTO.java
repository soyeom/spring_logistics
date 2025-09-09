package org.logistics.domain;

import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;

@Data
public class StockAnalysisResponseDTO {
    // 공통 정보 (품목 관련)
    private String buName; // 사업단위 이름
    private String warehouseName; // 창고 이름
    private String itemName; // 품명
    private String spec; // 규격
    private String baseUnit; // 단위
    private String itemInternalCode; // 품목 코드
    private String itemBigCategory; // 품목 대분류
    private String itemMidCategory; // 품목 중분류
    private String itemSmallCategory; // 품목 소분류
    private String assetClass; // 품목 자산 분류
    
    // 재고 수량 정보
    private BigDecimal beginningStock; // 기초 재고 (기간 시작 재고)
    private BigDecimal inboundQty; // 입고 수량 (기간 내)
    private BigDecimal outQty; // 출고 수량 (기간 내)
    private BigDecimal endingStock; // 기말 재고 (기간 종료 재고)
    
    // 재고 금액 정보
    private BigDecimal beginningAmount; // 기초 재고 금액
    private BigDecimal inboundAmount; // 입고 금액
    private BigDecimal outAmount; // 출고 금액
    private BigDecimal endingAmount; // 기말 재고 금액
    
    // 기타 정보
    private String createdDate; // 최종 변동일
    private String lotNo; // 로트번호
}