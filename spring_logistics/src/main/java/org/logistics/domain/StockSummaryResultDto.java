package org.logistics.domain;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class StockSummaryResultDto {

    private Long itemId; // 품번 - item_master item_id로 바꿔야함
    private String itemAssetClass; // 품목자산분류 - item_master asset_class
    private String itemBigCategory; // 품목대분류 - item_master big_category
    private String itemMidCategory; // 품목중분류 - item_master mid_category
    private String itemName; // 품명 - item_master item_name
    private BigDecimal inboundQty; // 총입고수량 - inbound_detail qty의 합계
    private String itemUnit; // 단위 - item_master base_unit
    private String itemStatus; // 품목상태 - item_master item_status
    private BigDecimal stockQty; // 재고수량 - stock_transaction 테이블의 stock_type 'INPUT'의 qty 에서 'OUTPUT'을 뺀 값
    private BigDecimal carriedOverQty; // 이월수량 - 이전 기간에서 이월된 수량입니다. 이는 periodStart 전날의 stock_transaction에서 집계된 값입니다.
    private BigDecimal outboundQty; // 총출고수량 - out_detail qty의 합계
    // inbound_master inbound_type 파생
    private BigDecimal productionInbound; // 입고(생산입고) - 생산을 통해 수령한 수량
    private BigDecimal outsourcingInbound; // 입고(외주입고) - 아웃소싱을 통해 수령한 수량
    private BigDecimal purchaseInbound; // 입고(구매입고) - 구매를 통해 수령한 수량
    private BigDecimal importInbound; // 입고(수입입고) - 수입을 통해 수령한 수량
    // out_master out_type 파생
    private BigDecimal deliverySlipOutbound; // 출고(거래명세표) - 배송전표를 통해 배송된 수량
    private BigDecimal otherOutbound; // 출고(기타출고) - 기타 아웃바운드 유형의 수량
    private BigDecimal salesConsignmentOutbound; // 출고(판매보관품출고) - 판매위탁수량
    private BigDecimal workPerformanceOutbound; // 출고(작업실적) - 업무 수행에 대한 양
    private BigDecimal outsourcingOutbound; // 출고(외주입고) - 아웃소싱 수량
	
}
