package org.logistics.model;

import lombok.Data;

@Data
public class OrderDetailDTO {

    private String inboundDetailId;   // ✅ 入庫明細ID / 입고상세 ID (inbound_detail_id)
    private String inboundId;         // ✅ 入庫ID / 입고 ID (inbound_id)
    private String buId;              // ✅ 事業部ID / 사업단위
    private String itemId;            // ✅ 品目ID / 품목 ID

    private String qty;               // ✅ 数量 / 수량
    private String surtaxYn;          // ✅ 消費税含む (Y/N) / 부가세 포함 여부 (Y/N)
    private String unitPrice;         // ✅ 単価 / 판매 단가
    private String amount;            // ✅ 金額 / 판매 금액
    private String note;              // ✅ 特記事項 / 특이사항
    private String warehouseId;       // ✅ 倉庫ID / 창고 ID

    private String itemName;          // ✅ 品名 / 품명
    private String spec;              // ✅ 規格 / 규격
    private String baseUnit;          // ✅ 販売単位 / 판매 단위
    private String warehouseName;     // ✅ 倉庫名 / 창고명

  
    private String vat;               // ✅ 消費税 / 부가세
    private String krwAmount;         // ✅ KRW販売金額 / 원화 판매금액
    private String krwVat;            // ✅ KRW消費税 / 원화 부가세
    private String partyName;         // ✅ 納品先名 / 납품 거래처명
    private String inboundDate;       // ✅ 納期日 / 납기일
    private String extraOutType;      // ✅ その他出庫区分 / 기타 출고 구분
    private String inboundComplete;   // ✅ 入庫完了状態 / 입고 완료 여부
}
