package org.logistics.service;

import java.util.List;

import org.logistics.domain.PopupVO;

public interface PopupService {

	public List<PopupVO> item_List(String gubun, String text);
	public List<PopupVO> contact_List(String gubun, String text);
	public List<PopupVO> warehouse_List(String gubun, String text);
	public List<PopupVO> itemSmallcategory_List(String gubun, String text);
	
}
