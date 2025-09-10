package org.logistics.mapper;

import java.util.List;
import org.logistics.domain.Warehouse;

public interface WarehouseMapper {
    List<Warehouse> getWarehouseList();
    int updateWarehouseFlags(Warehouse warehouse);
}
