package org.logistics.model;

import lombok.Data;

@Data
public class OrderDetailDTO {
    private String inboundDetailId;   // inbound_detail_id
    private String inboundId;         // inbound_id
    private String buId;              // 사업단위
    private String itemId;            // 품목ID

    private String qty;               // 수량
    private String surtaxYn;          // 부가세포함 (Y/N)
    private String unitPrice;         // 판매단가
    private String amount;            // 판매금액
    private String note;              // 특이사항
    private String warehouseId;       // 창고ID

    // JOIN 전용
    private String itemName;          // 품명
    private String spec;              // 규격
    private String baseUnit;          // 판매단위
    private String warehouseName;     // 창고명
    private String warehouseCode;

    // ✅ Handsontable 전용 필드 추가
    private String vat;               // 부가세
    private String krwAmount;         // 원화판매금액
    private String krwVat;            // 원화부가세
    private String partyName;         // 납품거래처명
    private String inboundDate;       // 납기일
    private String extraOutType;      // 기타출고구분
    private String inboundComplete;   // 입고완료 여부
}
