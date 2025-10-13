package org.logistics.service;

import java.util.List;

import org.logistics.domain.PopupVO;
import org.logistics.mapper.PopupMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class PopupServiceImpl implements PopupService {

	@Setter(onMethod_ = @Autowired)
	private PopupMapper popupMapper;

	@Override
	public List<PopupVO> item_List(String gubun, String text) {
		return popupMapper.item_List(gubun, text);
	}

	@Override
	public List<PopupVO> contact_List(String gubun, String text) {
		return popupMapper.contact_List(gubun, text);
	}

	@Override
	public List<PopupVO> itemSmallcategory_List(String gubun, String text) {
		return popupMapper.itemSmallcategory_List(gubun, text);
	}
	
	@Override
	public List<PopupVO> party_List(String gubun, String text) {
		return popupMapper.party_List(gubun, text);
	}

	@Override
	public List<PopupVO> out_Id_List(String gubun, String text) {
		return popupMapper.out_Id_List(gubun, text);
	}
	
	@Override
	public List<PopupVO> category_List_Big(String gubun, String text) {
		return popupMapper.category_List_Big(gubun, text);
	}
	
	@Override
	public List<PopupVO> category_List_Mid(String gubun, String text) {
		return popupMapper.category_List_Mid(gubun, text);
	}
	
	@Override
	public List<PopupVO> category_List_Small(String gubun, String text) {
		return popupMapper.category_List_Small(gubun, text);
	}
	
	@Override
	public List<PopupVO> itemname_List(String gubun, String text) {
		return popupMapper.itemname_List(gubun, text);
	}
	
	@Override
	public List<PopupVO> warehousecode_List(String gubun, String text) {
		return popupMapper.warehousecode_List(gubun, text);
	}
	
	@Override
	public List<PopupVO> warehouse_List(String gubun, String text) {
		
		return popupMapper.warehouse_List(gubun, text);

	}

	@Override
	public List<PopupVO> inboundMaster_List(String gubun, String text) {
		return popupMapper.inboundMaster_List(gubun, text);
	}
}