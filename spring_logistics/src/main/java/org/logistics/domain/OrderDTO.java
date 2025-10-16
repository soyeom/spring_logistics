package org.logistics.domain;

import java.util.List;

import lombok.Data;

@Data
public class OrderDTO {

    /** ================== 基本情報 (기본 정보) ================== */

    private String orderId;          // ✅ 受注ID / 수주 ID (inbound_id)
    private String buId;             // ✅ 事業部ID / 사업단위
    private String inboundDate;      // ✅ 納期日 / 납기일 (dueDate → inbound_date)
    private String localFlag;        // ✅ ローカル区分 / 내수·수출 구분
    private String inboundType;      // ✅ 入庫タイプ / 수주 구분 (orderType → inbound_type)
    private String inboundComplete;  // ✅ 入庫完了状態(Y/N) / 입고 완료 상태(Y/N)
    private String createdAt;        // ✅ 登録日 / 생성일자

    /** ================== 外部キー (외래키 관련) ================== */

    private String partyId;          // ✅ 取引先ID / 거래처 ID (外部キー)
    private String contactId;        // ✅ 担当者ID / 담당자 ID (外部キー)

    /** ================== ビュー専用フィールド (뷰 전용 필드) ================== */
    private String partyName;        // ✅ 取引先名 / 거래처명
    private String contactName;      // ✅ 担当者名 / 담당자명
    private String department;       // ✅ 部署名 / 부서명

    /** ================== 通貨・為替情報 (환율 정보) ================== */
    private String currencyCode;     // ✅ 通貨コード (currency_rate.currency_code)
    private String exchangeRate;     // ✅ 為替レート / 환율 (例: 1 USD = 1300.0)

    /** ================== 明細情報 (상세 정보) ================== */
    private List<OrderDetailDTO> details; // ✅ 受注明細リスト / 수주 상세 리스트
}
