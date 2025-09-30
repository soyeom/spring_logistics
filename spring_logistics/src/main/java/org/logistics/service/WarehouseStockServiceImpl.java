package org.logistics.service;

import java.util.List;
import java.util.Map;

import org.logistics.domain.WarehouseStockVO;
import org.logistics.mapper.WarehouseStockMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WarehouseStockServiceImpl implements WarehouseStockService {
	
	@Autowired
	private WarehouseStockMapper mapper;

	@Override
	public List<WarehouseStockVO> getWarehouseStocks(Map<String,Object> params) {
	    return mapper.getWarehouseStocks(params);
	}


	@Override
	public List<WarehouseStockVO> search(Map<String, Object> params) {
		return mapper.search(params);
	}

	@Override
	public List<Map<String, String>> getBusinessUnits() {
		return mapper.getBusinessUnits();
	}

	@Override
	public List<Map<String, String>> getStockBases() {
		return mapper.getStockBases();
	}

	@Override
	public List<Map<String, Object>> getWarehouseNames() {
		return mapper.getWarehouseNames();
	}

	@Override
	public List<Map<String, Object>> getAssetClasses() {
		return mapper.getAssetClasses();
	}
	
	@Override
	public List<Map<String, Object>> getImportanceLevels() {
		return mapper.getImportanceLevels();
	}

	@Override
	public List<Map<String, Object>> getBigCategorys() {
		return mapper.getBigCategorys();
	}

	@Override
	public List<Map<String, Object>> getMidCategorys() {
		return mapper.getMidCategorys();
	}

	@Override
	public List<Map<String, Object>> getSmallCategorys() {
		return mapper.getSmallCategorys();
	}

	@Override
	public List<Map<String, Object>> getItemNames() {
		return mapper.getItemNames();
	}

	@Override
	public List<Map<String, Object>> getSpecs() {
		return mapper.getSpecs();
	}
}
