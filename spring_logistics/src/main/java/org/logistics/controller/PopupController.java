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

	// 品目ポップアップ (品目コード)
	@GetMapping("/item_popup")
	public void item_Popup(Model model, @RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.item_List(gubun, text)); // マスタ照会
	}

	// 品目リスト照会 (AJAX)
	@GetMapping("/item_list")
	@ResponseBody
	public List<PopupVO> item_list(@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		return popupService.item_List(gubun, text);
	}

	// 担当者ポップアップ
	@GetMapping("/contact_popup")
	public void contact_Popup(Model model, @RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.contact_List(gubun, text)); // マスタ照会
	}

	@GetMapping("/contact_list")
	@ResponseBody
	public List<PopupVO> contact_list(@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		return popupService.contact_List(gubun, text);
	}

	// 取引先ポップアップ
	@GetMapping("/party_popup")
	public void party_Popup(Model model, @RequestParam(required = false) String gubun, @RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.party_List(gubun, text));	// マスタ照会
	}

	@GetMapping("/party_list")
	@ResponseBody
	public List<PopupVO> party_list(@RequestParam(required = false) String gubun, @RequestParam(required = false) String text) {
		return popupService.party_List(gubun, text);
	}

	// 出庫マスタポップアップ
	@GetMapping("/out_id_popup")
	public void out_Id_Popup(Model model, @RequestParam(required = false) String gubun, @RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.out_Id_List(gubun, text));	// マスタ照会
	}

	@GetMapping("/out_id_list")
	@ResponseBody
	public List<PopupVO> out_Id_list(@RequestParam(required = false) String gubun, @RequestParam(required = false) String text) {
		return popupService.out_Id_List(gubun, text);
	}

	// 品目大分類ポップアップ
	@GetMapping("/category_popup_big")
	public void category_Popup_Big(Model model, @RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.category_List_Big(gubun, text)); // マスタ照会
	}

	@GetMapping("/category_list_big")
	@ResponseBody
	public List<PopupVO> category_list_big(@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		return popupService.category_List_Big(gubun, text);
	}

	// 品目中分類ポップアップ
	@GetMapping("/category_popup_mid")
	public void category_Popup_Mid(Model model, @RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.category_List_Mid(gubun, text)); // マスタ照会
	}

	@GetMapping("/category_list_mid")
	@ResponseBody
	public List<PopupVO> category_list_mid(@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		return popupService.category_List_Mid(gubun, text);
	}

	// 品目小分類ポップアップ
	@GetMapping("/itemSmallcategory_popup")
	public void itemSmallcategory_Popup(Model model,
			@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {

		model.addAttribute("list", popupService.itemSmallcategory_List(gubun, text)); // マスタ照会
	}
	
	@GetMapping("/itemSmallcategory_list")
	@ResponseBody
	public List<PopupVO> itemSmallcategory_list(
			@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		return popupService.itemSmallcategory_List(gubun, text);
	}
	
	// 品目小分類ポップアップ (category_popup_small)
	@GetMapping("/category_popup_small")
	public void category_Popup_small(Model model, @RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.category_List_Small(gubun, text)); // マスタ照会
	}

	@GetMapping("/category_list_small")
	@ResponseBody
	public List<PopupVO> category_list_small(@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		return popupService.category_List_Small(gubun, text);
	}

	// 品名ポップアップ
	@GetMapping("/item_name_popup")
	public void item_name_Popup(Model model, @RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.itemname_List(gubun, text)); // マスタ照会
	}

	@GetMapping("/item_name_list")
	@ResponseBody
	public List<PopupVO> item_name_list(@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		return popupService.itemname_List(gubun, text);
	}


	// 倉庫コードポップアップ
	@GetMapping("/warehouse_code_popup")
	public void warehouse_code_Popup(Model model, @RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.warehousecode_List(gubun, text));
	}

	@GetMapping("/warehouse_code_list")
	@ResponseBody
	public List<PopupVO> warehouse_code_list(@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		return popupService.warehousecode_List(gubun, text);
	}
    
	@GetMapping("/warehouse_popup")
	public void warehousePopup(Model model, @RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.warehouse_List(gubun, text));
	}

	@GetMapping("/warehouse_popup/list")
	@ResponseBody
	public List<PopupVO> warehouse_name_list(@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		return popupService.warehouse_List(gubun, text);
	}
    
	// 受注マスタポップアップ
	@GetMapping("/inbound_popup")
	public void inbound_Popup(Model model, @RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.inboundMaster_List(gubun, text));
	}

	@GetMapping("/inbound_list")
	@ResponseBody
	public List<PopupVO> inbound_list(@RequestParam(required = false) String gubun,
			@RequestParam(required = false) String text) {
		return popupService.inboundMaster_List(gubun, text);
	}
}