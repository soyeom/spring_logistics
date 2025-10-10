package org.logistics.controller;

import java.util.List;

import org.logistics.domain.PopupVO;
import org.logistics.service.PopupService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/popup/*")
@AllArgsConstructor
public class PopupController {
	
	private PopupService popupService;
	
	// 品目のポップアップ
	@GetMapping("/item_popup")
	public void item_Popup(Model model, 
            @RequestParam(required = false) String gubun, 
            @RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.item_List(gubun, text));	// 마스터 조회
	}
	
	// 品目のリスト照会 (AJAX)
	@GetMapping("/item_list")
	@ResponseBody
	public List<PopupVO> item_list(
            @RequestParam(required = false) String gubun, 
            @RequestParam(required = false) String text) {
		return popupService.item_List(gubun, text);
	}

	// 倉庫ポップアップ 
	@GetMapping("/warehouse_popup")
	public void warehouse_Popup(Model model, 
            @RequestParam(required = false) String gubun, 
            @RequestParam(required = false) String text) {
        
		model.addAttribute("list", popupService.warehouse_List(gubun, text));	// マスター照会
	}
    
	// 倉庫 目録照会 (AJAX)
	// URL: /popup/warehouse_list
	@GetMapping("/warehouse_list") 
	@ResponseBody
	public List<PopupVO> warehouse_list(
            @RequestParam(required = false) String gubun, 
            @RequestParam(required = false) String text) {
		log.info("Warehouse Search AJAX Request: gubun=" + gubun + ", text=" + text);
		return popupService.warehouse_List(gubun, text);
	}
	
	// 品目小分類ポップアップ
	@GetMapping("/itemSmallcategory_popup")
	public void itemSmallcategory_Popup(Model model, 
            @RequestParam(required = false) String gubun, 
            @RequestParam(required = false) String text) {
        
		model.addAttribute("list", popupService.itemSmallcategory_List(gubun, text));	// マスター照会
	}
	
	// 品目小分類のリストを呼び出すコントローラー (AJAX)
	@GetMapping("/itemSmallcategory_list") 
	@ResponseBody
	public List<PopupVO> itemSmallcategory_list(
            @RequestParam(required = false) String gubun, 
            @RequestParam(required = false) String text) {
		return popupService.itemSmallcategory_List(gubun, text);
	}
}