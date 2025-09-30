package org.logistics.mapper;

import java.util.List;
import java.util.Map;

import org.logistics.domain.AvailableItemVO;

public interface AvailableItemMapper {
	List<AvailableItemVO> getAvailableItems();
	List<AvailableItemVO> searchAvailableItems(Map<String, Object> params);

	List<AvailableItemVO> getBusinessUnits();
	List<AvailableItemVO> getAssetClasses();

}
