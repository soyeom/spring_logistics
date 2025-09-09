package org.logistics.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OutRequestDTO {

	private Long outId; 	//출고pk
	private Long buId;		//사업단위 fk
	private Date outDate;	//출고일
	private String localFlag;	//로컬 구분
	private Long partyId;	//거래처 fk
	private Long contactId;	//담당자 fk
	private String department;	//부서
	private String outType;		//출고 유형
	private String consignmentGubun;	//위탁 구분
	private char outComplete; 	//출고 완료 여부
	private Date createdAt; 	//생성일
	//outMaster 테이블
	
	private List<OutDetailDTO> details;
	//outDetail 테이블
}
