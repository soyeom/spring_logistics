package org.logistics.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.logistics.domain.PopupVO;

public interface PopupMapper {

	// 기존 메서드 (충돌 마커 전후에 모두 존재했음)
	public List<PopupVO> item_List(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> contact_List(@Param ("gubun") String gubun, @Param ("text") String text);
	
	// HEAD 영역에 있던 메서드
	public List<PopupVO> itemSmallcategory_List(@Param ("gubun") String gubun, @Param ("text") String text);

	// jinhyung 영역에 있던 메서드
	public List<PopupVO> party_List(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> out_Id_List(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> category_List_Big(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> category_List_Mid(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> category_List_Small(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> itemname_List(@Param ("gubun") String gubun, @Param ("text") String text);
    public List<PopupVO> businessunit_List(@Param("gubun") String gubun, @Param("text") String text);
    public List<PopupVO> warehousecode_List(@Param("gubun") String gubun, @Param("text") String text);
    public List<PopupVO> warehouse_List(@Param("gubun") String gubun, @Param("text") String text);
    public List<PopupVO> assetclass_List(@Param("gubun") String gubun, @Param("text") String text);
	public List<PopupVO> inboundMaster_List(@Param("gubun") String gubun, @Param("text") String text); // ✅ 수주번호 (inbound_master) 조회 진형
}