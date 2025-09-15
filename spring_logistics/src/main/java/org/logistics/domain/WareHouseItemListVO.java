package org.logistics.domain;

import lombok.Data;

@Data
public class WareHouseItemListVO {

	private String item_Id;
	private String item_Name;
	private String spec;
	private String safety_Stock_Qty;
	private String storage_Location;
}