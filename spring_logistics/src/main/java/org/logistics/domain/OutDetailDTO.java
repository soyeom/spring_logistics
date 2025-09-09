package org.logistics.domain;

import java.math.BigDecimal; // BigDecimal 임포트
import java.util.Date;

import lombok.Data;

@Data
public class OutDetailDTO {

	private Long outDetailId;			//출고 마스터 fk
	private Long outId;			//출고 마스터 fk
	private Long buId;			//출고 마스터 fk
	private Long itemId;		//품목 fk
	private Long partyId;		//거래처 fk
	private Long warehouseId;	//창고 fk
	private BigDecimal qty;		//출고 수량
	private BigDecimal unitPrice;	//단가
	private BigDecimal amount;	//금액
	private String specialNote;	//특이사항
	private String lotNo;	//로트 번호
	private String otherOutCode;	//기타 출고 코드
	private char isChargeSupply;	//비용 청구 여부
	private String assetClass;		//자산 분류
	private String assetProcType;	//자산 처리 유형
	private Date createdAt;		//생성일
	private String currencyCode;
    private BigDecimal exchangeRate;
}