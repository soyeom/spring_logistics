package org.logistics.domain;

import java.util.Date;
import lombok.Data;

@Data
public class StockAnalysisRequestDTO {
    private Long buId; // 사업단위
    private Long warehouseId; // 창고 상세 ID (warehouse_detail.warehouse_id)
    private Long warehouseMasterId; // 창고 마스터 ID (warehouse_master.warehouse_master_id)
    private Long itemId; // 품목 ID
    private String itemBigCategory; // 품목 대분류
    private String itemMidCategory; // 품목 중분류
    private String itemSmallCategory; // 품목 소분류
    private String itemStatus; // 품목 상태
    private String itemInternalCode; // 품목 내부 코드
    private String spec; // 규격
    private String itemName; // 품명
    private String baseUnit; // 기본 단위 (item_master.base_unit)
    private String currencyCode; // 통화 코드 (currency_rate.currency_code)
    private String importanceLevel; // 중요도
    private int analysisPeriod; // 예: 3개월, 6개월 등
    private int analysisCount; // 예: 4회 분석 등
    private String analysisItem; // 예: '수량', '금액' 등
    private String stockStandard; // 예: 수량 / 금액
    private String itemAssetClass; // 예: 제품 / 원자재 등 (asset_class)
    private Date startDate; // 시작일 (기간 조회)
    private Date endDate; // 종료일 (기간 조회)
}
