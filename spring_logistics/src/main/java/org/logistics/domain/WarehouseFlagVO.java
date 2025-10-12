package org.logistics.domain;

import lombok.Data;

@Data
public class WarehouseFlagVO {
	private String warehouseInternalCode;
	private String assetStockFlag;
	private String availableStockFlag;
	private String actualStockFlag;
}
