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
@RequestMapping("/warehouseStocks")
public class WarehouseStockController {
	
	@Autowired
	private WarehouseStockService service;
	
	/** 화면 진입 */
	@GetMapping
	public String view(@RequestParam(required = false) Map<String, Object> params, Model model) {
	    if (params.get("criteria") == null || "".equals(params.get("criteria"))) {
	        params.put("criteria", "actual"); // 기본 실재고
	    }

	    model.addAttribute("items", service.getWarehouseStocks(params));
	    model.addAttribute("criteria", String.valueOf(params.get("criteria")));

	    // 검색조건 목록들
	    model.addAttribute("buList", service.getBusinessUnits());
	    model.addAttribute("warehouseNameList", service.getWarehouseNames());
	    model.addAttribute("assetClassList", service.getAssetClasses());
	    model.addAttribute("importanceLevelList", service.getImportanceLevels());
	    model.addAttribute("bigCategoryList", service.getBigCategorys());
	    model.addAttribute("midCategoryList", service.getMidCategorys());
	    model.addAttribute("smallCategoryList", service.getSmallCategorys());
	    model.addAttribute("itemNameList", service.getItemNames());
	    model.addAttribute("specList", service.getSpecs());

	    return "warehouseStocks";
	}

	/** Ajax 검색 */
	@GetMapping(value = "/list", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<WarehouseStockVO> search(@RequestParam Map<String, Object> params) {
	    if (params.get("criteria") == null || "".equals(params.get("criteria"))) {
	        params.put("criteria", "actual");
	    }
	    return service.search(params);
	}



	@GetMapping("/warehouseSearch")
	public String warehouseSearch(Model model) {
		List<Map<String, Object>> warehouses = service.getWarehouseNames();
		model.addAttribute("warehouseNameList", warehouses);
		return "popup/warehousePopup"; 
	}
	
	@GetMapping("/bigCategorySearch")
	public String bigCategorySearch(Model model) {
		List<Map<String, Object>> bigCategorys = service.getBigCategorys();
		model.addAttribute("bigCategoryList", bigCategorys);
		return "popup/bigCategoryPopup";
	}

	@GetMapping("/midCategorySearch")
	public String midCategorySearch(Model model) {
		List<Map<String, Object>> midCategorys = service.getMidCategorys();
		model.addAttribute("midCategoryList", midCategorys);
		return "popup/midCategoryPopup";
	}

	@GetMapping("/smallCategorySearch")
	public String smallCategorySearch(Model model) {
		List<Map<String, Object>> smallCategorys = service.getSmallCategorys();
		model.addAttribute("smallCategoryList", smallCategorys);
		return "popup/smallCategoryPopup";
	}
}
