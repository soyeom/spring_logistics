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
private Long itemId;				//品目id (Long으로 변경하는 것도 고려해 볼 수 있습니다)
private String currentMonth;		//現在の日付
private String prevYearMonth; // 日付計算用
private String analysisItem; // "averageStock", "turnoverRate", "totalIn", "totalOut"
    private Integer periodMonths;       // 期間間隔 (3개월)
    private Integer periodCount;        // 比較回数 (4회 비교)
}