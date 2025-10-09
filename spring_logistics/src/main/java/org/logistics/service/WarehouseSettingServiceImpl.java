package org.logistics.service;

import java.util.List;
import org.logistics.domain.WarehouseVO;
import org.logistics.mapper.WarehouseSettingMapper;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WarehouseSettingServiceImpl implements WarehouseSettingService {

    private final WarehouseSettingMapper mapper;

    @Override
    public List<WarehouseVO> getWarehouses() {
        return mapper.getWarehouseList();
    }

    @Override
    public void updateWarehouseFlags(WarehouseVO warehouse) {
        mapper.updateWarehouseFlags(warehouse);
    }
}
