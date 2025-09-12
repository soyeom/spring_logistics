package org.logistics.domain;

import lombok.Data;

@Data
public class AvailableItemVO {
	private String warehouseName;
	private int warehouseId;
	private String assetClass;
	private String itemName;
	private String spec;
	private int itemId;
	private String baseUnit;
	
    private Integer totalQty;                
    private Integer requestQty;    
    private Integer orderQty;       
    private Integer transferQty;     
    private Integer inboundQty;  
    private Integer expectedQty;      
}
