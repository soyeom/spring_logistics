package org.logistics.domain;

import java.util.Date;
import lombok.Data;

@Data
public class StockAnalysisRequestDTO {
	// PK (Primary Key) 및 FK (Foreign Key)
	private Long buId; 
	private Long warehouseId; 
	private Long warehouseMasterId;
	private Long itemId;

	// item_master 테이블의 필터링 조건
	private String itemBigCategory;
	private String itemMidCategory; 
	private String itemSmallCategory; 
	private String itemStatus; 
	private String spec; 
	private String itemName;
	private String baseUnit; 
	private String importanceLevel;

	// currency_rate 테이블의 필터링 조건
	private String currencyCode;

	// stock_analysis 관련 조건 (테이블과 직접 관련 없음)
	private Integer analysisPeriod;
	private Integer analysisCount;
	private String analysisItem;
	private String stockStandard;
	private String itemAssetClass;

	// 기간 조회 조건
	private Date startDate;
	private Date endDate;
}