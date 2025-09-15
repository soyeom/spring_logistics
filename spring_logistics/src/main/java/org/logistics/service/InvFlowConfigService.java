package org.logistics.service;

import java.util.List;

import org.logistics.domain.InvFlowConfigVO;
import org.logistics.domain.OutBoundMasterVO;
import org.logistics.domain.PopupItemVO;
import org.logistics.domain.WareHouseContactListVO;
import org.logistics.domain.WareHouseItemListVO;

public interface InvFlowConfigService {

	public List<InvFlowConfigVO> getList();
	public List<WareHouseItemListVO> getWareHouseItemList(String wareHouse_Id);
	public List<WareHouseContactListVO> getWareHouseContactList(String wareHouse_Id);
	
	// 출고처리 VO
	public List<OutBoundMasterVO> getOutBoundMaster();
	public List<OutBoundMasterVO> getOutBoundDetail1(String bu_Id, String out_Id);
	public List<OutBoundMasterVO> getOutBoundDetail2(String bu_Id, String out_Id);
	
	// 공통팝업
	public List<PopupItemVO> popupItemList();
}
