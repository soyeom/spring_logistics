package org.logistics.domain;

import java.util.Date;

import lombok.Data;

@Data
public class StockAnalysisRequestDTO {
    private Long buId; // 사업단위
    private Long warehouseId; // 창고
    private Long itemId; // 품목 ID
    private String itemBigCategory; // 품목 대분류
    private String itemMidCategory; // 품목 중분류
    private String itemSmallCategory; // 품목 소분류
    private String itemStatus; // 품목 상태
    private String itemInternalCode; // 품목 내부 코드
    private String spec; // 규격
    private String itemName; // 품명
    private String unit; // 단위
    private Date startDate; // 시작일 (기간 조회)
    private Date endDate; // 종료일 (기간 조회)
    private String currency; // 통화
    private String importanceLevel; // 중요도
    private int analysisPeriod; // 예: 3개월, 6개월 등
    private int analysisCount; // 예: 4회 분석 등
    private String analysisItem; // 예: '수량', '금액' 등
}