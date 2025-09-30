package org.logistics.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.logistics.domain.CommonVO;
import org.logistics.domain.InvFlowConfigVO;
import org.logistics.domain.OutBoundMasterVO;
import org.logistics.domain.PopupItemVO;
import org.logistics.domain.PopupVO;
import org.logistics.domain.WareHouseContactListVO;
import org.logistics.domain.WareHouseItemListVO;

public interface PopupMapper {

	public List<PopupVO> item_List(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> contact_List(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> category_List_Big(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> category_List_Mid(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> category_List_Small(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> itemname_List(@Param ("gubun") String gubun, @Param ("text") String text);
    public List<PopupVO> businessunit_List(@Param("gubun") String gubun, @Param("text") String text);
    public List<PopupVO> warehousecode_List(@Param("gubun") String gubun, @Param("text") String text);
    public List<PopupVO> warehousename_List(@Param("gubun") String gubun, @Param("text") String text);
    public List<PopupVO> assetclass_List(@Param("gubun") String gubun, @Param("text") String text);
	// ✅ 수주번호 (inbound_master) 조회 진형
    public List<PopupVO> inboundMaster_List(@Param("gubun") String gubun, @Param("text") String text);
}
