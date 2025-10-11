package org.logistics.domain;

import lombok.Data;

@Data
public class AvailableItemVO {
	private String warehouseName;
	private int warehouseId;
	
	private String buId;
	private String buName;
	private String assetClass;
	private String itemName;
	private String spec;
	private int itemId;
	private String baseUnit;
	private Integer safetyQty;
	
    private Integer requestQty;    
    private Integer orderQty;       
    private Integer transferQty;     
    private Integer inboundQty;  
    private Integer expectedQty;
    
    private Integer receivedQty;
    private Integer deliveryQty;
    private Integer shipmentQty;
    private Integer otherQty;
    private Integer expectedOutQty;
}
