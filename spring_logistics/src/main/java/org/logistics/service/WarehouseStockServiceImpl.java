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
	public List<WarehouseStockVO> getBusinessUnits() {
		return mapper.getBusinessUnits();
	}

	@Override
	public List<WarehouseStockVO> getStockBases() {
		return mapper.getStockBases();
	}

	@Override
	public List<WarehouseStockVO> getAssetClasses() {
		return mapper.getAssetClasses();
	}
	
	@Override
	public List<WarehouseStockVO> getImportanceLevels() {
		return mapper.getImportanceLevels();
	}


	@Override
	public List<WarehouseStockVO> getSpecs() {
		return mapper.getSpecs();
	}
}
