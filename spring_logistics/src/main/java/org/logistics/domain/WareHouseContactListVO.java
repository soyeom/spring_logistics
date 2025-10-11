package org.logistics.domain;

import lombok.Data;

@Data
public class WareHouseContactListVO {
	
	private String bu_Id;
	private String wareHouse_Master_Id;
	private String wareHouse_Id;
	private String contact_Id;
	private String contact_Name;
	private String wareHouse_Name;
	private String department;
}
