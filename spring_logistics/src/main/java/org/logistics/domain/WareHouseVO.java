package org.logistics.domain;

import lombok.Data;

@Data
public class WareHouseVO {
	
	private Long warehouseId;				//창고코드
	private String warehouseName;			//창고명
	private String buName;					//사업단위명
	private String warehouseInternalCode;	//창고구분
	private Long buId;						//사업단위코드
	private Long warehouseMasterId;			//창고구분코드
}
