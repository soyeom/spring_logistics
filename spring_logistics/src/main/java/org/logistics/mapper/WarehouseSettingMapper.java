package org.logistics.mapper;

import java.util.List;
import org.logistics.domain.WarehouseVO;

public interface WarehouseSettingMapper {
    List<WarehouseVO> getWarehouseList();
    int updateWarehouseFlags(WarehouseVO warehouse);
}
