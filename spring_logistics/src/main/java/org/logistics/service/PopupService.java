package org.logistics.service;

import java.util.List;

import org.logistics.domain.CommonVO;
import org.logistics.domain.InvFlowConfigVO;
import org.logistics.domain.OutBoundMasterVO;
import org.logistics.domain.PopupItemVO;
import org.logistics.domain.PopupVO;
import org.logistics.domain.WareHouseContactListVO;
import org.logistics.domain.WareHouseItemListVO;

public interface PopupService {

	public List<PopupVO> item_List(String gubun, String text);
	public List<PopupVO> contact_List(String gubun, String text);
	public List<PopupVO> warehouse_List(String gubun, String text);
}
