package org.logistics.controller;

import java.util.List;
import java.util.Map;

import org.logistics.domain.WarehouseStockVO;
import org.logistics.service.WarehouseStockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/warehouse")
public class WarehouseStockController {
	
	@Autowired
	private WarehouseStockService service;
	
	@GetMapping("/stock")
	public String view(@RequestParam(required = false) Map<String, Object> params, Model model) {
	    if (params.get("criteria") == null || "".equals(params.get("criteria"))) {
	        params.put("criteria", "actual"); // 기본 실재고
	    }

	    model.addAttribute("items", service.getWarehouseStocks(params));
	    model.addAttribute("criteria", String.valueOf(params.get("criteria")));


	    model.addAttribute("buList", service.getBusinessUnits());
	    model.addAttribute("assetClassList", service.getAssetClasses());
	    model.addAttribute("importanceLevelList", service.getImportanceLevels());
	    model.addAttribute("specList", service.getSpecs());

	    return "zaikou/warehouseStocks";
	}

	@GetMapping(value = "/stockList", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<WarehouseStockVO> search(@RequestParam Map<String, Object> params) {
	    if (params.get("criteria") == null || "".equals(params.get("criteria"))) {
	        params.put("criteria", "actual");
	    }
	    return service.search(params);
	}
}
