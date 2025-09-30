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
	public List<AvailableItemVO> getBusinessUnits() {
		return mapper.getBusinessUnits();
	}
	
	@Override
	public List<AvailableItemVO> getAssetClasses() {
		return mapper.getAssetClasses();
	}
}