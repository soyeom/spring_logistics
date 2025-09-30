package org.logistics.mapper;

import java.util.List;
import java.util.Map;

import org.logistics.domain.AvailableItemVO;

public interface AvailableItemMapper {
	List<AvailableItemVO> getAvailableItems();
	List<AvailableItemVO> searchAvailableItems(Map<String, Object> params);
	
    List<Map<String, String>> getBusinessUnits();
    List<Map<String, String>> getWarehouseCodes();
    List<Map<String, Object>> getWarehouseNames();
    List<Map<String,Object>> getAssetClasses();
    List<Map<String, Object>> getBigCategorys();
    List<Map<String, Object>> getMidCategorys();
    List<Map<String, Object>> getSmallCategorys();
    List<Map<String, Object>> getItemNames();
}
