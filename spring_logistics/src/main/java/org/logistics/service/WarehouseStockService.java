package org.logistics.service;

import java.util.List;
import java.util.Map;

import org.logistics.domain.WarehouseStockVO;

public interface WarehouseStockService {
	List<WarehouseStockVO> getWarehouseStocks(Map<String, Object> params);
	List<WarehouseStockVO> search(Map<String, Object> params);
	
	List<WarehouseStockVO> getBusinessUnits();     
	List<WarehouseStockVO> getStockBases();  
	List<WarehouseStockVO> getAssetClasses();
	List<WarehouseStockVO> getImportanceLevels();
	List<WarehouseStockVO> getSpecs();

}
