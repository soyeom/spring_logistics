package org.logistics.service;

import java.util.List;
import java.util.Map;

import org.logistics.domain.AvailableItemVO;
import org.logistics.mapper.AvailableItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AvailableItemServiceImpl implements AvailableItemService {

	@Autowired
	private AvailableItemMapper mapper;

	@Override
	public List<AvailableItemVO> getAvailableItems() {
		return mapper.getAvailableItems();
	}

	@Override
	public List<AvailableItemVO> search(Map<String, Object> params) {
		return mapper.searchAvailableItems(params);
	}

	@Override
	public List<Map<String, String>> getBusinessUnits() {
		return mapper.getBusinessUnits();
	}

	@Override
	public List<Map<String, String>> getWarehouseCodes() {
		return mapper.getWarehouseCodes();
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
}