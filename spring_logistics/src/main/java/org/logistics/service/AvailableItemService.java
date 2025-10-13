package org.logistics.service;

import java.util.List;
import java.util.Map;

import org.logistics.domain.AvailableItemVO;

public interface AvailableItemService {
    List<AvailableItemVO> getAvailableItems();
    List<AvailableItemVO> search(Map<String, Object> params);

    List<AvailableItemVO> getBusinessUnits();
    List<AvailableItemVO> getAssetClasses();
}

