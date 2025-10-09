package org.logistics.service;

import java.util.List;
import java.util.Map;

import org.logistics.domain.AvailableItemVO;

public interface AvailableItemService {
	List<AvailableItemVO> getAvailableItems(); // 전체 목록 조회
	List<AvailableItemVO> search(Map<String, Object> params); // 검색기능

	// 셀렉트 박스로 조회할 조건은 따로 받아오기 (セレクトボックスで照会する条件は別に受け取る)
	List<AvailableItemVO> getBusinessUnits();
	List<AvailableItemVO> getAssetClasses();
}
