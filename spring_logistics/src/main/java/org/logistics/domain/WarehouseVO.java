package org.logistics.domain;

import lombok.Data;

@Data
public class WarehouseVO {
	private String warehouseInternalCode;
	private String assetStockFlag;
	private String availableStockFlag;
	private String actualStockFlag;
}
