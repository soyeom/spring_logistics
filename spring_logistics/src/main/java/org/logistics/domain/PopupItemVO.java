package org.logistics.domain;

import lombok.Data;

@Data
public class PopupItemVO {
	public String item_Id;
	public String bu_Id;
	public String item_Name;
	public String spec;
	public String safety_Stock_Qty;
	public String storage_Location;
	public String asset_Class;
	public String asset_Name;
	public String big_Category;
	public String mid_Category;
	public String small_Category;
	public String sales_Unit;
	public String lot_Control_Flag;
	public String manufacturer;
	public String currency;
	public String english_Name;
	public String importance_Level;
	public String base_Unit;
}