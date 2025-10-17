package org.logistics.domain;

import lombok.Data;

@Data
public class StockAnalysisResponseDTO {
    private String itemAssetClass;    // 品目資産分類
    private String itemBigCategory;   // 品目大分類
    private String itemMidCategory;   // 品目中分類
    private String itemSmallCategory; // 品目小分類
    private Long itemId;              // 品番
    private String itemName;          // 品名
    private String spec;              // 規格
    private String baseUnit;          // 単位
    private String importanceLevel;   // 重要度

    // 在庫関連
    private Integer beginningStock;   // 期首在庫
    private Integer inboundQty;       // 入庫数量
    private Integer outQty;           // 出庫数量
    private Integer endingStock;      // 期末在庫

    // 調整関連 (追加)
    private String adjustIn;          // 棚卸調整(入庫)
    private String adjustOut;         // 棚卸調整(出庫)
    
    // 計算値
    private int totalInbound;       // 総入庫量
    private int totalOutbound;      // 総出庫量


    public double getAverageStock() {
        // 平均在庫量 = (期首在庫 + 期末在庫) / 2
        // 期首在庫(beginningStock)は必要に応じてServiceでset
        int beginningStock = this.beginningStock;  // 個別に設定する値
        return (beginningStock + this.endingStock) / 2.0;
    }

    public double getTurnoverRatio() {
        double avg = getAverageStock();
        if (avg == 0) return 0;
        return (this.totalOutbound / avg) * 100.0;
    }

}