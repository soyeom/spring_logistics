package org.logistics.domain;

import lombok.Data;

@Data
public class InvFlowConfigVO {

	private String bu_Id;
	private String bu_Name;
	private String wareHouse_Master_Id;
	private String wareHouse_Internal_Code;
	private String wareHouse_Id;
	private String wareHouse_Name;
	private String site_Department;				// 현장부서
	private String outSourcing_Party_Id;		// 외주거래처
	private String consignment_Party_Id;		// 위탁거래처
	private String manager_Party_Id;			// 담당자
	private String bu_Dependent_Flag;			// 사업단위종속여부
	private String allow_Stock_Shortage;		// 재구부족허용
	private String manager_Control_Flag;		// 창고담당자통제
	private String Address;						// 주소
	private String exclude_From_Available;		// 가용재고미포함
	private String available_Control_Flag;		// 가용재고통제
	private String use_Yn;						// 사용여부	
}
