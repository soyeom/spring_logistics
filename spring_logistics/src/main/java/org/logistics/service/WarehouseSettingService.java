package org.logistics.service;

import java.util.List;
import java.util.Map;

import org.logistics.domain.WarehouseVO;

public interface WarehouseSettingService {

	// 목록 가져오기(リスト取得)
	List<WarehouseVO> getWarehouses();

    //업데이트 기능（アップデート機能）
	void updateWarehouseFlags(WarehouseVO warehouse);
}
