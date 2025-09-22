package org.logistics.service;

import java.util.List;

import org.logistics.domain.CommonVO;
import org.logistics.domain.InvFlowConfigVO;
import org.logistics.domain.OutBoundMasterVO;
import org.logistics.domain.PopupItemVO;
import org.logistics.domain.WareHouseContactListVO;
import org.logistics.domain.WareHouseItemListVO;

public interface InvFlowConfigService {

	public List<InvFlowConfigVO> getList();
	public List<InvFlowConfigVO> getList2(String bu_Id, String wareHouse_Master_Id);
	public List<WareHouseItemListVO> getWareHouseItemList(String bu_Id, String wareHouse_Id);
	public List<WareHouseContactListVO> getWareHouseContactList(String bu_Id, String wareHouse_Id);
	
	// 출고처리 VO
	public List<OutBoundMasterVO> getOutBoundMaster();
	public List<OutBoundMasterVO> getOutBoundDetail1(String bu_Id, String out_Id);
	public List<OutBoundMasterVO> getOutBoundDetail2(String bu_Id, String out_Id);
	public void outBoundMasterSave(OutBoundMasterVO obm);
	
	// 공통
	public List<CommonVO> business_UnitList();
	public List<CommonVO> wareHouse_MasterList();
	public List<PopupItemVO> popupItemList();
	
	//창고
}
