package org.logistics.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.logistics.domain.InvFlowConfigVO;
import org.logistics.domain.OutBoundMasterVO;
import org.logistics.domain.WareHouseContactListVO;
import org.logistics.domain.WareHouseItemListVO;

public interface InvFlowConfigMapper {

	public List<InvFlowConfigVO> getList();
	public List<WareHouseItemListVO> getWareHouseItemList(String wareHouse_Id);
	public List<WareHouseContactListVO> getWareHouseContactList(String wareHouse_Id);
	
	// 출고처리 
	public List<OutBoundMasterVO> getOutBoundMaster();
	public List<OutBoundMasterVO> getOutBoundDetail1(@Param ("bu_Id") String bu_Id, @Param ("out_Id") String out_Id);
	public List<OutBoundMasterVO> getOutBoundDetail2(@Param ("bu_Id") String bu_Id, @Param ("out_Id") String out_Id);
}
