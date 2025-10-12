package org.logistics.controller;

import java.util.List;

import org.logistics.domain.WarehouseFlagVO;
import org.logistics.service.WarehouseSettingService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/warehouse")
public class WarehouseSettingController {

	private final WarehouseSettingService service;

	//재고 조회 기능(在庫照会機能）
	@GetMapping("/setting")
	public String listWarehouses(Model model) {
		List<WarehouseFlagVO> list = service.getWarehouses();
		model.addAttribute("warehouseList", list);
		return "zaikou/warehouseSetting";
	}

	//업데이트 기능（アップデート機能）
	@PostMapping("/update")
	@ResponseBody
	public String updateWarehouses(@RequestBody List<WarehouseFlagVO> warehouses) {

		for (WarehouseFlagVO wh : warehouses) {

			// 체크박스가 선택되지 않으면(null) 기본값을 "N"으로 설정 (チェックボックスが選択されない場合(null)、デフォルトを"N"に設定)
			if (wh.getAssetStockFlag() == null)
				wh.setAssetStockFlag("N");
			if (wh.getAvailableStockFlag() == null)
				wh.setAvailableStockFlag("N");
			if (wh.getActualStockFlag() == null)
				wh.setActualStockFlag("N");

			service.updateWarehouseFlags(wh);
		}
		return "success";
	}
}
