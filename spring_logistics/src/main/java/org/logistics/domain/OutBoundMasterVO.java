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
	private String item_Id;				// 품번
	private String item_Name;			// 품명
	private String spec;				// 규격
	private String wareHouse_Id;		// 창고번호
	private String qty;					// 수량
	private String sales_Unit;			// 판매단위
	private String unit_Price;			// 판매단가
	private String surtax_Yn;			// 부가세포함
	private String sales_Price;			// 판매금액
	private String surtax_Price;		// 부가세액
	private String sales_Price_Sum;		// 판매금액계
	private String base_Unit;			// 기준단위
	private String storage_Location;	// 보관창고
	private String special_Note;		// 특이사항
	private String is_Charge_Supply;	// 유상사급여부
	private String asset_Class;			// 품목자산분류
	private String asset_Proc_Type;		// 자산처리구분
	private String amount;				// ?
	private String lot_No;				// Lot No.
	private String other_Out_Code;		// 기타출고구분
	private String created_At;			// 생성일
	private String currency_Code;		// 통화단위
	private String exChange_Rate;		// 환율
}
