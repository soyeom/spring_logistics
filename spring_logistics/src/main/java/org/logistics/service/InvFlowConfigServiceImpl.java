package org.logistics.service;

import java.util.List;

import org.logistics.domain.CommonVO;
import org.logistics.domain.InvFlowConfigVO;
import org.logistics.domain.OutBoundMasterVO;
import org.logistics.domain.PopupItemVO;
import org.logistics.domain.WareHouseContactListVO;
import org.logistics.domain.WareHouseItemListVO;
import org.logistics.mapper.InvFlowConfigMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class InvFlowConfigServiceImpl implements InvFlowConfigService {

	@Setter(onMethod_= @Autowired)
	private InvFlowConfigMapper invFlowConfigMapper;
	
	@Override
	public List<InvFlowConfigVO> getList() {
		
		return invFlowConfigMapper.getList();
	}
	
	@Override
	public List<InvFlowConfigVO> getList2(String bu_Id, String wareHouse_Master_Id) {
		
		return invFlowConfigMapper.getList2(bu_Id, wareHouse_Master_Id);
	}

	@Override
	public List<WareHouseItemListVO> getWareHouseItemList(String bu_Id, String wareHouse_Id) {
	
		return invFlowConfigMapper.getWareHouseItemList(bu_Id, wareHouse_Id);
	}

	@Override
	public List<WareHouseContactListVO> getWareHouseContactList(String bu_Id, String wareHouse_Id) {

		return invFlowConfigMapper.getWareHouseContactList(bu_Id, wareHouse_Id);
	}
	
	@Override
	public void save(InvFlowConfigVO vo) {
		invFlowConfigMapper.save(vo);
	}
	
	@Override
	public void delete_Detail1(String bu_Id, String wareHouse_Master_Id, String wareHouse_Id) {
		invFlowConfigMapper.delete_Detail1(bu_Id, wareHouse_Master_Id, wareHouse_Id);
		
	}
	
	@Override
	public void save_Detail1(WareHouseItemListVO vo) {
		invFlowConfigMapper.save_Detail1(vo);
	}
	
	@Override
	public void delete_Detail2(String bu_Id, String wareHouse_Master_Id, String wareHouse_Id) {
		invFlowConfigMapper.delete_Detail2(bu_Id, wareHouse_Master_Id, wareHouse_Id);
	}

	@Override
	public void save_Detail2(WareHouseContactListVO vo) {
		invFlowConfigMapper.save_Detail2(vo);
	}

	// 출고처리
	// 출고 마스터 조회
	@Override
	public List<OutBoundMasterVO> getOutBoundDetail1(String bu_Id, String out_Id) {
		// TODO Auto-generated method stub
		return invFlowConfigMapper.getOutBoundDetail1(bu_Id, out_Id);
	}

	// 출고 디테일 조회
	@Override
	public List<OutBoundMasterVO> getOutBoundDetail2(String bu_Id, String out_Id) {
		// TODO Auto-generated method stub
		return invFlowConfigMapper.getOutBoundDetail2(bu_Id, out_Id);
	}
	
	// 출고 마스터 저장
	@Override
	public void newOutBoundMasterSave(OutBoundMasterVO obm) {
		invFlowConfigMapper.newOutBoundMasterSave(obm);
	}
	
	// 출고 마스터 저장
	@Override
	public void updateOutBoundMasterSave(OutBoundMasterVO obm) {
		invFlowConfigMapper.updateOutBoundMasterSave(obm);
	}
	
	// 조회조건 - 사업단위 조회
	@Override
	public List<CommonVO> business_UnitList() {
		return invFlowConfigMapper.business_UnitList();
	}
	
	// 조회조건 - 창고구분 조회
	@Override
	public List<CommonVO> wareHouse_MasterList() {
		// TODO Auto-generated method stub
		return invFlowConfigMapper.wareHouse_MasterList();
	}

	@Override
	public List<PopupItemVO> popupItemList() {
		// TODO Auto-generated method stub
		return invFlowConfigMapper.popupItemList();
	}

	@Override
	public String new_Out_Id(String bu_Id) {
		return invFlowConfigMapper.new_Out_Id(bu_Id);
	}

	@Override
	public void outBound_Delete_Detail(String bu_Id, String out_Id) {
		invFlowConfigMapper.outBound_Delete_Detail(bu_Id, out_Id);
	}

	@Override
	public void outBound_Save_Detail(OutBoundMasterVO vo) {
		invFlowConfigMapper.outBound_Save_Detail(vo);
	}
	
	@Override
	public void outBound_Delete_Master(String bu_Id, String out_Id) {
		invFlowConfigMapper.outBound_Delete_Master(bu_Id, out_Id);	
	}

	@Override
	public void outBound_Update(String bu_Id, String out_Id) {
		invFlowConfigMapper.outBound_Update(bu_Id, out_Id);
	}
}
