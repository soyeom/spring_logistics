package org.logistics.domain;

import lombok.Data;

@Data
public class OutBoundMasterVO {

	// 출고 사업단위
	private String bu_Id;
	private String bu_Name;
	private String out_Id;
	
	// 출고 마스터
	private String out_Date;
	private String local_Flag;
	private String party_Id;
	private String party_Name;
	private String contact_Id;
	private String contact_Name;
	private String department;
	private String out_Type;
	private String consignment_Gubun;
	private String out_Complete;
	
	// 출고 디테일
	private String item_Id;
	private String item_Name;
	private String spec;
	private String wareHouse_Id;
	private String qty;
	private String sales_Unit;
	private String unit_Price;
	private String surtax_Yn;
	private String sales_Price;
	private String surtax_Price;
	private String sales_Price_Sum;
	private String base_Unit;
	private String storage_Location;
	private String special_Note;
	private String is_Charge_Supply;
	private String asset_Class;
	private String asset_Proc_Type;
	private String amount;
	private String lot_No;
	private String other_Out_Code;
	private String created_At;
	private String currency_Code;
	private String exChange_Rate;
}
