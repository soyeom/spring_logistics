package org.logistics.service;

import java.util.List;

import org.logistics.domain.Warehouse;
import org.logistics.mapper.WarehouseMapper;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WarehouseService {

    private final WarehouseMapper warehouseMapper;

    // ✅ 창고구분별 재고 플래그 조회
    public List<Warehouse> getWarehouses() {
        return warehouseMapper.getWarehouseList();
    }
    
    public void updateWarehouseFlags(Warehouse warehouse) {
    	warehouseMapper.updateWarehouseFlags(warehouse);
    }
}
