package org.logistics.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.logistics.domain.CommonVO;
import org.logistics.domain.InvFlowConfigVO;
import org.logistics.domain.OutBoundMasterVO;
import org.logistics.domain.PopupItemVO;
import org.logistics.domain.PopupVO;

public interface PopupService {

	public List<PopupVO> item_List(String gubun, String text);
	public List<PopupVO> contact_List(String gubun, String text);

	public List<PopupVO> warehouse_List(String gubun, String text);
	public List<PopupVO> itemSmallcategory_List(String gubun, String text);
	
	// jinhyung 브랜치에서 추가된 팝업 조회 메서드 통합
	public List<PopupVO> party_List(String gubun, String text);
	public List<PopupVO> out_Id_List(String gubun, String text);
	public List<PopupVO> category_List_Big(String gubun, String text);
	public List<PopupVO> category_List_Mid(String gubun, String text);
	public List<PopupVO> category_List_Small(String gubun, String text);
	public List<PopupVO> itemname_List(String gubun, String text);
    public List<PopupVO> warehousecode_List(String gubun, String text);
    public List<PopupVO> warehousename_List(String gubun, String text);
	 // ✅ 수주번호 (inbound_master) 진형
    public List<PopupVO> inboundMaster_List(String gubun, String text);
}