package org.logistics.controller;

import java.util.List;

import org.logistics.domain.InvFlowConfigVO;
import org.logistics.domain.OutBoundMasterVO;
import org.logistics.domain.WareHouseContactListVO;
import org.logistics.domain.WareHouseItemListVO;
import org.logistics.service.InvFlowConfigService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/InvFlowConfig/*")
@AllArgsConstructor
public class InvFlowConfigController {

	private InvFlowConfigService invFlowConfigService;
		
	@GetMapping("/invflowconfig")
	public void invFlowConfig() {
	}
	
	@GetMapping("/item_popup")
	public void item_Popup() {
	}
	
	@GetMapping("/contact_popup")
	public void contact_Popup() {
	}
	
	@GetMapping("/list")
	@ResponseBody
	public List<InvFlowConfigVO> list() {
		return invFlowConfigService.getList();
	}
	
	@GetMapping("/item_list")
	@ResponseBody
	public List<WareHouseItemListVO> item_List(@RequestParam("wareHouse_Id") String wareHouse_Id) {
		return invFlowConfigService.getWareHouseItemList(wareHouse_Id);
	}
	
	@GetMapping("/contact_list")
	@ResponseBody
	public List<WareHouseContactListVO> contact_List(@RequestParam("wareHouse_Id") String wareHouse_Id) {
		return invFlowConfigService.getWareHouseContactList(wareHouse_Id);
	}
	
	
	
	// 출고 관련 method
	@GetMapping("/outbound")
	public void outBound() {
	}	
	
	@GetMapping("/outbound_master")
	@ResponseBody
	public List<OutBoundMasterVO> outBoundMasterSearch() {
		return invFlowConfigService.getOutBoundMaster();
	}
	
	@GetMapping("/outbound_detail1")
	@ResponseBody
	public List<OutBoundMasterVO> outBoundDetailSearch1(@RequestParam("bu_Id") String bu_Id, @RequestParam("out_Id") String out_Id) {

		return invFlowConfigService.getOutBoundDetail1(bu_Id, out_Id);
	}
	
	@GetMapping("/outbound_detail2")
	@ResponseBody
	public List<OutBoundMasterVO> outBoundDetailSearch2(@RequestParam("bu_Id") String bu_Id, @RequestParam("out_Id") String out_Id) {

		return invFlowConfigService.getOutBoundDetail2(bu_Id, out_Id);
	}
}
