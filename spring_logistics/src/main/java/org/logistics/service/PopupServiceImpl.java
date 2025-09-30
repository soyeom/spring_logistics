package org.logistics.service;

import java.util.List;

import org.logistics.domain.PopupVO;
import org.logistics.mapper.InvFlowConfigMapper;
import org.logistics.mapper.PopupMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class PopupServiceImpl implements PopupService {

	@Setter(onMethod_= @Autowired)
	private PopupMapper popupMapper;
	
	@Override
	public List<PopupVO> item_List(String gubun, String text) {
		
		return popupMapper.item_List(gubun, text);
	}

	@Override
	public List<PopupVO> contact_List(String gubun, String text) {
		// TODO Auto-generated method stub
		return popupMapper.contact_List(gubun, text);
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
	public List<PopupVO> warehousename_List(String gubun, String text) {
		
		return popupMapper.warehousename_List(gubun, text);
	}
	
}
