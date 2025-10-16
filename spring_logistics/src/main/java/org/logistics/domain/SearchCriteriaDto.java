package org.logistics.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;


@Data
public class SearchCriteriaDto {

    private String businessBuName; // 事業単位 - business_unit bu_name
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date searchPeriodStart; //  照会期間 開始日
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date searchPeriodEnd; // 照会期間 終了日
    private String stockStandard; // 在庫基準
    private String itemAssetClass; // 品目資産分類 - item_master asset_class
    private String itemBigCategory; // 品目大分類 - item_master big_category
    private String itemMidCategory; // 品目中分類 - item_master mid_category
    private String itemSmallCategory; // 品目小分類 - item_master small_category
    private String itemName; // 品名 - item_master item_name
    private Long itemId; // 品番 - item_master item_id
    private String itemSpec; // 規格 - item_master spec
    private String itemStatus; // 品目ステータス - item_master item_status
    private String unitStandard; // 単位照会基準
    private boolean includeZeroQty; // ゼロ数量 照会有無
    
}
