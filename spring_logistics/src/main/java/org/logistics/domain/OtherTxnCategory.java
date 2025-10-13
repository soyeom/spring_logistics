package org.logistics.model;

import java.util.Date;
import lombok.Data;

@Data
public class OtherTxnCategory {

    /** ================== 基本情報 (기본 정보) ================== */
    private String txnCode;          // ✅ 取引コード / 거래 코드
    private Integer buId;            // ✅ 事業部ID / 사업부 ID
    private String txnType;          // ✅ 取引タイプ (入庫/出庫/移動など) / 거래 유형 (입고/출고/이동 등)
    private String categoryName;     // ✅ 区分名 / 구분명
    private Integer sortOrder;       // ✅ 表示順序 / 표시 순서
    private String useYn;            // ✅ 使用可否(Y/N) / 사용 여부(Y/N)

    /** ================== 会計関連情報 (회계 관련 정보) ================== */
    private String accountSubject;   // ✅ 勘定科目 / 회계 계정과목
    private String costType;         // ✅ 原価タイプ / 원가 구분

    /** ================== 品目性質フラグ (품목 성격 관련 플래그) ================== */
    private String isFinishedProduct; // ✅ 製品フラグ / 완제품 여부
    private String isMaterial;        // ✅ 原材料フラグ / 원재료 여부
    private String isSalesUse;        // ✅ 販売用区分 / 판매용 여부
    private String adjustOut;         // ✅ 調整出庫フラグ / 조정출고 여부
    private String adjustIn;          // ✅ 調整入庫フラグ / 조정입고 여부

    /** ================== 税関連フラグ (세무 관련 플래그) ================== */
    private String isVatTarget;      // ✅ 課税対象 / 부가세 대상 여부
    private String vatProcessType;   // ✅ 消費税処理タイプ / 부가세 처리 유형
    private String isAs;             // ✅ A/S対象フラグ / A/S 대상 여부
    private String isItemJournal;    // ✅ 在庫仕訳対象 / 품목전표 생성 여부

    /** ================== 入庫関連フラグ (입고 관련 플래그) ================== */
    private String isByproductIn;    // ✅ 副産物入庫 / 부산물 입고 여부
    private String isReturnIn;       // ✅ 返品入庫 / 반품 입고 여부

    /** ================== 出庫関連フラグ (출고 관련 플래그) ================== */
    private String isMove;           // ✅ 移動出庫 / 이동 출고 여부
    private String isTransfer;       // ✅ 移送出庫 / 이전 출고 여부
    private String isAsOut;          // ✅ A/S出庫 / A/S 출고 여부
    private String isAsReturn;       // ✅ A/S返品出庫 / A/S 반품 출고 여부
    private String isFreeSupply;     // ✅ 無償支給 / 무상지급 여부
    private String isDispatchTarget; // ✅ 出荷対象 / 출하 대상 여부

    /** ================== 補足情報 (보충 정보) ================== */
    private String description;      // ✅ 備考 / 비고
    private Date createdAt;          // ✅ 登録日時 / 생성일자
}
