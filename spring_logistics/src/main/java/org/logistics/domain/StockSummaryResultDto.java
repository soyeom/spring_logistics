package org.logistics.domain;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class StockSummaryResultDto {

    private Long itemId; // 品番 - item_master item_id
    private String itemAssetClass; // 品目資産分類 - item_master asset_class
    private String itemBigCategory; // 品目大分類 - item_master big_category
    private String itemMidCategory; // 品目中分類 - item_master mid_category
    private String itemName; // 品名 - item_master item_name
    private BigDecimal inboundQty; // 総入庫数量 - inbound_detail qty の合計
    private String itemUnit; // 単位 - item_master base_unit
    private String itemStatus; // 品目ステータス - item_master item_status
    private BigDecimal stockQty; // 在庫数量 - stock_transaction テーブルの stock_type 'INPUT' から 'OUTPUT' を引いた値
    private BigDecimal carriedOverQty; // 繰越数量 - 前期間から繰り越された数量。periodStart の前日までの stock_transaction から集計されます。
    private BigDecimal outboundQty; // 総出庫数量 - out_detail qty の合計
    // inbound_master inbound_type から派生
    private BigDecimal productionInbound; // 入庫（生産入庫）- 生産によって受領した数量
    private BigDecimal outsourcingInbound; // 入庫（外注入庫）- アウトソーシングを通じて受領した数量
    private BigDecimal purchaseInbound; // 入庫（購入入庫）- 購入によって受領した数量
    private BigDecimal importInbound; // 入庫（輸入入庫）- 輸入によって受領した数量
    // out_master out_type から派生
    private BigDecimal deliverySlipOutbound; // 出庫（取引明細書）- 配送伝票を通じて出荷された数量
    private BigDecimal otherOutbound; // 出庫（その他出庫）- その他アウトバウンドタイプの数量
    private BigDecimal salesConsignmentOutbound; // 出庫（販売委託品出庫）- 販売委託数量
    private BigDecimal workPerformanceOutbound; // 出庫（作業実績）- 業務遂行のための数量
    private BigDecimal outsourcingOutbound; // 出庫（外注出庫）- 外注数量
	
}
