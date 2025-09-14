
package org.logistics.domain;
import java.time.LocalDate;

public class StockAnalysisRequestDTO {

    // 첫 번째 컨테이너: 조회 조건
    private Long buId;
    private Long warehouseId;
    private String stockStandard; // 재고기준 (실재고, 자산재고)
    private String importanceLevel; // 중요도 (A등급, B등급...)
    private String itemAssetClass; // 품목자산분류
    private String itemSmallCategory; // 품목소분류 (코드)
    private String itemName; // 품명
    private String itemId; // 품번
    private String spec; // 규격

    // 두 번째 컨테이너: 비교대상 기간설정
    private LocalDate currentMonth; // 현재월
    private int analysisPeriod; // 기간간격 (개월)
    private int analysisCount; // 비교 횟수
    private String analysisItem; // 분석항목 (평균재고량, 재고회전율 등)

    // Getter 및 Setter (생략)

    // toString(), equals(), hashCode() 메서드 (생략)
}