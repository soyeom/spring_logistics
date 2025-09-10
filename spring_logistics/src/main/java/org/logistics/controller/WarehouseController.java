package org.logistics.controller;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

import org.logistics.domain.Warehouse;
import org.logistics.domain.WarehouseListForm;
import org.logistics.service.WarehouseService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/")
public class WarehouseController {

	private final WarehouseService warehouseService;

	// ✅ 창고구분별 재고 조회
	@GetMapping("/list")
	public String listWarehouses(Model model) {
		List<Warehouse> list = warehouseService.getWarehouses();
		model.addAttribute("warehouseList", list);
		return "list";
	}

	@PostMapping("/update")
	public String updateWarehouses(WarehouseListForm form, RedirectAttributes redirectAttributes) {
	    for (Warehouse wh : form.getWarehouses()) {
	        if (wh.getAssetStockFlag() == null) wh.setAssetStockFlag("N");
	        if (wh.getAvailableStockFlag() == null) wh.setAvailableStockFlag("N");
	        if (wh.getActualStockFlag() == null) wh.setActualStockFlag("N");
	        
	        // ✅ 디버깅 로그
	        System.out.println(">>> warehouseInternalCode=" + wh.getWarehouseInternalCode()
	                + ", asset=" + wh.getAssetStockFlag()
	                + ", available=" + wh.getAvailableStockFlag()
	                + ", actual=" + wh.getActualStockFlag());


	        warehouseService.updateWarehouseFlags(wh);
	    }

	    // ✅ Flash Attribute (리다이렉트 시 1회성 데이터)
	    redirectAttributes.addFlashAttribute("message", "저장되었습니다!");

	    return "redirect:/list";
	}

}
