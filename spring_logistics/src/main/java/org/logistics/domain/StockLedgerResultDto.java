package org.logistics.domain;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class StockLedgerResultDto {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date transactionDate; // 日付（取引発生日） inbound_master.inbound_date または out_master.out_date
	private String type; // 区分 | 繰越在庫、期間計、出庫、入庫
	private String inOutboundType; // 入出庫区分
	private String inOutboundCategory; // 入出庫タイプ inbound_master.inbound_type または out_master.out_type | 例：取引明細書、購入入庫など
	private String unit; // 単位 item_master.base_unit
	private BigDecimal inboundQty; // 入庫数量 inbound_detail.qty
	private BigDecimal outboundQty; // 出庫数量 out_detail.qty
	private BigDecimal stockQty; // 在庫数量（入庫と出庫をクエリで計算して求める）
	private String managementId; // 管理番号
	private String buName; // 事業単位 business_unit.bu_name
	private String inboundWarehouse; // 入庫倉庫 inbound_detail.warehouse_id を基に warehouse_detail.warehouse_name と結合
	private String outboundWarehouse; // 出庫倉庫 outbound_detail.warehouse_id を基に warehouse_detail.warehouse_name と結合
	private String partyName; // 取引先 out_master.party_id を基に party.party_name と結合
	private String department; // 処理部署
	private String contactName; // 処理担当者
	private String transactionType; // 取引タイプ（入庫/出庫の区分）
	private Long transactionId; // 固有ID（管理番号生成用）
}
