package org.logistics.domain;

import lombok.Data;

@Data
public class WareHouseVO {
	
	private Long warehouseId;				//倉庫コード
	private String warehouseName;			//倉庫名
	private String buName;					//事業単位名
	private String warehouseInternalCode;	//倉庫区分
	private Long buId;						//事業単位コード
	private Long warehouseMasterId;			//倉庫区分コード
	private String gubun;                   // 検索区分 (20, 10)
    private String text;                    // 検索のキーワード
}
