package org.logistics.domain;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class StockLedgerResultDto {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date transactionDate; // 일자(거래 발생 일자) inbound_master.inbound_date out_master.out_date
	private String type; // 구분 | 이월재고, 기간계, 출고, 입고
	private String inOutboundType; // 입출고구분
	private String inOutboundCategory; // 입출고유형 inbound_master.inbound_type out_master.out_type | 거래명세표, 구매입고, 거래명세표, 구매입고, 거래명세표, 구매입고 등
	private String unit; // 단위 item_master.base_unit
	private BigDecimal inboundQty; // 입고수량 inbound_detail.qty
	private BigDecimal outboundQty; // 출고수량 out_detail.qty
	private BigDecimal stockQty; // 재고수량 입고와 출고를 쿼리로 만들어서 구함
	private String managementId;// 관리번호
	private String buName; // 사업단위 business_unit.bu_name
	private String inboundWarehouse; // 입고창고 inbound_detail.warehouse_id 를 기준으로 warehouse_detail.warehouse_name 조인
	private String outboundWarehouse; // 출고창고 inbound_detail.warehouse_id 를 기준으로 warehouse_detail.warehouse_name 조인
	private String partyName; // 거래처 out_master.party_id 를 기준으로 party.party_name 조인
	private String department; // 처리부서
	private String contactName; // 처리자
	private String transactionType; // 거래 타입 (입고/출고 구분)
	private Long transactionId; // 고유 ID (관리번호 생성용)
}