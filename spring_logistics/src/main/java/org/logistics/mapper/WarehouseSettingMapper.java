package org.logistics.mapper;

import java.util.List;
import org.logistics.domain.WarehouseFlagVO;

public interface WarehouseSettingMapper {
    List<WarehouseFlagVO> getWarehouseList();
    int updateWarehouseFlags(WarehouseFlagVO warehouse);
}
