package org.logistics.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;


@Data
public class SearchCriteriaDto {

    private String businessBuName; // 사업단위 - business_unit bu_name
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date searchPeriodStart; // 조회기간 시작일
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date searchPeriodEnd; // 조회기간 종료일
    private String stockStandard; // 재고기준
    private String itemAssetClass; // 품목자산분류 - item_master asset_class
    private String itemBigCategory; // 품목대분류 - item_master big_category
    private String itemMidCategory; // 품목중분류 - item_master mid_category
    private String itemSmallCategory; // 품목소분류 - item_master small_category
    private String itemName; // 품명 - item_master item_name
    private String itemInternalCode; // 품번 - item_master item_internal_code
    private String itemSpec; // 규격 - item_master spec
    private String itemStatus; // 품목상태 - item_master item_status
    private String unitStandard; // 단위조회기준
    private boolean includeZeroQty; // 0수량 조회여부
    
}
