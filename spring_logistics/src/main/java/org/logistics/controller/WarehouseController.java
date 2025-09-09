package org.logistics.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class WarehouseController {

	// ✅ 창고 목록 + 재고 조회 (체크박스 기준 반영)
	@GetMapping("/list")
	public String listWarehouses(@RequestParam(required = false) String chkAsset,
			@RequestParam(required = false) String chkAvailable, @RequestParam(required = false) String chkActual,
			Model model) {

		// 체크박스 선택 여부 → Boolean Map
		Map<String, Boolean> criteria = new HashMap<>();
		criteria.put("asset", "Y".equals(chkAsset));
		criteria.put("available", "Y".equals(chkAvailable));
		criteria.put("actual", "Y".equals(chkActual));

		// ⭐ 서비스 대신 더미데이터 생성
		List<Map<String, Object>> list = new ArrayList<>();

		Map<String, Object> wh1 = new HashMap<>();
		wh1.put("warehouseId", 1);
		wh1.put("warehouseName", "서울 중앙창고");
		wh1.put("qty", 120);
		list.add(wh1);

		Map<String, Object> wh2 = new HashMap<>();
		wh2.put("warehouseId", 2);
		wh2.put("warehouseName", "부산 항만창고");
		wh2.put("qty", 85);
		list.add(wh2);

		// JSP에 전달
		model.addAttribute("warehouseList", list);
		model.addAttribute("chkAsset", criteria.get("asset"));
		model.addAttribute("chkAvailable", criteria.get("available"));
		model.addAttribute("chkActual", criteria.get("actual"));

		return "list"; // /WEB-INF/views/list.jsp
	}
}
