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

	@Setter(onMethod_ = @Autowired)
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

	
	// 수주 진형
	@Override
	public List<PopupVO> inboundMaster_List(String gubun, String text) {
		return popupMapper.inboundMaster_List(gubun, text);
	}
}
