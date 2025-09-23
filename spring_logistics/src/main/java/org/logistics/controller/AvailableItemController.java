package org.logistics.controller;

import java.util.List;
import java.util.Map;

import org.logistics.domain.AvailableItemVO;
import org.logistics.service.AvailableItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/availableItems")
public class AvailableItemController {

	@Autowired
	private AvailableItemService service;

	@GetMapping
	public String view(Model model) {
		model.addAttribute("items", service.getAvailableItems());
		model.addAttribute("buList", service.getBusinessUnits()); //
		model.addAttribute("warehouseCodeList", service.getWarehouseCodes());
		model.addAttribute("warehouseNameList", service.getWarehouseNames());
		model.addAttribute("assetClassList", service.getAssetClasses());
		model.addAttribute("bigCategoryList", service.getBigCategorys());
		model.addAttribute("midCategoryList", service.getMidCategorys());
		model.addAttribute("smallCategoryList", service.getSmallCategorys());
		return "availableItems";
	}

	@GetMapping("/list")
	@ResponseBody
	public List<AvailableItemVO> search(@RequestParam Map<String, Object> params) {

		String buId = (String) params.get("buId");
		String warehouseName = (String) params.get("warehouseName");
		String assetClass = (String) params.get("assetClass");
		String bigCategory = (String) params.get("bigCategory");
		String midCategory = (String) params.get("midCategory");
		String smallCategory = (String) params.get("smallCategory");
		String itemName = (String) params.get("itemName");
		String itemId = (String) params.get("itemId");

		if ((buId == null || buId.isEmpty()) && (warehouseName == null || warehouseName.isEmpty())
				&& (assetClass == null || assetClass.isEmpty()) && (bigCategory == null || bigCategory.isEmpty())
				&& (midCategory == null || midCategory.isEmpty()) && (smallCategory == null || smallCategory.isEmpty())
				&& (itemName == null || itemName.isEmpty()) && (itemId == null || itemId.isEmpty())) {
			return service.getAvailableItems();
		} else {
			return service.search(params);
		}
	}

	@GetMapping("/warehouseSearch")
	public String warehouseSearch(Model model) {
		// DB에서 창고 목록 가져오기
		List<Map<String, Object>> warehouses = service.getWarehouseNames();
		model.addAttribute("warehouseNameList", warehouses);
		return "popup/warehousePopup"; // /WEB-INF/views/popup/warehouseSearch.jsp
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

	@GetMapping("/itemNameSearch")
	public String itemNameSearch(Model model) {
		List<Map<String, Object>> itemNames = service.getItemNames();
		model.addAttribute("itemNameList", itemNames);
		return "popup/itemNamePopup";
	}
}
