package org.logistics.mapper;

import java.util.List;
import java.util.Map;

import org.logistics.domain.WarehouseStockVO;

public interface WarehouseStockMapper {

	List<WarehouseStockVO> getWarehouseStocks(Map<String, Object> params);
	List<WarehouseStockVO> search(Map<String, Object> params);
	
    List<Map<String, String>> getBusinessUnits();     
    List<Map<String, String>> getStockBases();  
    List<Map<String, Object>> getWarehouseNames();
    List<Map<String, Object>> getAssetClasses();
    List<Map<String, Object>> getImportanceLevels();
    List<Map<String, Object>> getBigCategorys();
    List<Map<String, Object>> getMidCategorys();
    List<Map<String, Object>> getSmallCategorys();
    List<Map<String, Object>> getItemNames();
    List<Map<String, Object>> getSpecs();
}
