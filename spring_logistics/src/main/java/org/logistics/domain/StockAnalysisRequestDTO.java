package org.logistics.domain;

import lombok.Data;

@Data
public class StockAnalysisRequestDTO {
    private Long buId;					//ビジネスid
    private Long warehouseId;			//倉庫名
    private String importanceLevel;		//重要度
    private String itemAssetClass;		//品目等級
    private String itemSmallCategory;	//品目小分類
    private String itemName;			//品目名
    private String spec;				//スペック
    private String baseUnit;			//ベースユニット
    private String stockStandard;		//在庫基準
    private String itemId;				//品目id
    private String currentMonth;   		//現在の日付
    private String prevYearMonth; // 日付計算用
    private String analysisItem; // "averageStock", "turnoverRate", "totalIn", "totalOut"

}