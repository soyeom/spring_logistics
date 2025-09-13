package org.logistics.service;

import java.util.List;

import org.logistics.domain.InvFlowConfigVO;
import org.logistics.domain.OutBoundMasterVO;
import org.logistics.domain.PopupItemVO;
import org.logistics.domain.WareHouseContactListVO;
import org.logistics.domain.WareHouseItemListVO;
import org.logistics.mapper.InvFlowConfigMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class InvFlowConfigServiceImpl implements InvFlowConfigService {

	@Setter(onMethod_= @Autowired)
	private InvFlowConfigMapper invFlowConfigMapper;
	
	@Override
	public List<InvFlowConfigVO> getList() {
		
		return invFlowConfigMapper.getList();
	}

	@Override
	public List<WareHouseItemListVO> getWareHouseItemList(String wareHouse_Id) {
	
		return invFlowConfigMapper.getWareHouseItemList(wareHouse_Id);
	}

	@Override
	public List<WareHouseContactListVO> getWareHouseContactList(String wareHouse_Id) {

		return invFlowConfigMapper.getWareHouseContactList(wareHouse_Id);
	}

	@Override
	public List<OutBoundMasterVO> getOutBoundMaster() {
		// TODO Auto-generated method stub
		return invFlowConfigMapper.getOutBoundMaster();
	}

	@Override
	public List<OutBoundMasterVO> getOutBoundDetail1(String bu_Id, String out_Id) {
		// TODO Auto-generated method stub
		return invFlowConfigMapper.getOutBoundDetail1(bu_Id, out_Id);
	}

	@Override
	public List<OutBoundMasterVO> getOutBoundDetail2(String bu_Id, String out_Id) {
		// TODO Auto-generated method stub
		return invFlowConfigMapper.getOutBoundDetail2(bu_Id, out_Id);
	}

	@Override
	public List<PopupItemVO> popupItemList() {
		// TODO Auto-generated method stub
		return invFlowConfigMapper.popupItemList();
	}
}
