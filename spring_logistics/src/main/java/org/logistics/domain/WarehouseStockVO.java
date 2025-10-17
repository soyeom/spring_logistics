package org.logistics.domain;

import lombok.Data;

@Data
public class WarehouseStockVO {
	
	private String assetClass;
	private Integer itemId;
	private String itemName;
	private String spec;
	private String baseUnit;
	private String bigCategory;
	private String midCategory;
	private String smallCategory;
	private String importanceLevel;
	private String warehouseName;
	private int warehouseId;
	
	private String buId;
	private String buName;
	private Integer stockQty;
}
