package org.logistics.service;

import java.util.List;
import java.util.Map;

import org.logistics.domain.AvailableItemVO;

public interface AvailableItemService {
    List<AvailableItemVO> getAvailableItems();
    List<AvailableItemVO> search(Map<String, Object> params);
    
    List<Map<String, String>> getBusinessUnits();      // bu_id, bu_name
    List<Map<String, String>> getWarehouseCodes();     // warehouse_internal_code
    List<Map<String, Object>> getWarehouseNames();
    List<Map<String, Object>> getAssetClasses();
    List<Map<String, Object>> getBigCategorys();
    List<Map<String, Object>> getMidCategorys();
    List<Map<String, Object>> getSmallCategorys();
    List<Map<String, Object>> getItemNames();

}

