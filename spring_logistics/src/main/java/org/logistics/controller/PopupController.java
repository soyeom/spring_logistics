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
	
	@GetMapping("/item_popup")
	public void item_Popup(Model model, @RequestParam(required = false) String gubun, @RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.item_List(gubun, text));	// 마스터 조회
	}
	
	@GetMapping("/item_list")
	@ResponseBody
	public List<PopupVO> item_list(@RequestParam(required = false) String gubun, @RequestParam(required = false) String text) {
		return popupService.item_List(gubun, text);
	}

	// 창고
	@GetMapping("/warehouse_popup")
	public void warehouse_List(Model model, @RequestParam(required = false) String gubun, @RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.warehouse_List(gubun, text));	// 마스터 조회
	}
	
	@GetMapping("/warehouse_List")
	@ResponseBody
	public List<PopupVO> warehouse_List(@RequestParam(required = false) String gubun, @RequestParam(required = false) String text) {
		return popupService.warehouse_List(gubun, text);
	}
	
	
	@GetMapping("/contact_popup")
	public void contact_Popup(Model model, @RequestParam(required = false) String gubun, @RequestParam(required = false) String text) {
		model.addAttribute("list", popupService.contact_List(gubun, text));	// 마스터 조회
	}
	
	@GetMapping("/contact_list")
	@ResponseBody
	public List<PopupVO> contact_list(@RequestParam(required = false) String gubun, @RequestParam(required = false) String text) {
		return popupService.contact_List(gubun, text);
	}
}
