package org.logistics.service;

import java.util.List;
import org.logistics.domain.WarehouseFlagVO;
import org.logistics.mapper.WarehouseSettingMapper;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WarehouseSettingServiceImpl implements WarehouseSettingService {

    private final WarehouseSettingMapper mapper;

    @Override
    public List<WarehouseFlagVO> getWarehouses() {
        return mapper.getWarehouseList();
    }

    @Override
    public void updateWarehouseFlags(WarehouseFlagVO warehouse) {
        mapper.updateWarehouseFlags(warehouse);
    }
}
