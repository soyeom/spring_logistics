package org.logistics.controller;

import java.util.List;
import org.logistics.domain.InvFlowConfigVO;
import org.logistics.domain.OutBoundMasterVO;
import org.logistics.domain.PopupItemVO;
import org.logistics.domain.WareHouseContactListVO;
import org.logistics.domain.WareHouseItemListVO;
import org.logistics.service.InvFlowConfigService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	public void invFlowConfig(Model model) { 	
		model.addAttribute("bu_Id", invFlowConfigService.business_UnitList());
		model.addAttribute("wareHouse_Master_Id", invFlowConfigService.wareHouse_MasterList());
		
		model.addAttribute("list", invFlowConfigService.getList());	// 마스터 조회
	}
	
	@GetMapping("/list")
	@ResponseBody
	public List<InvFlowConfigVO> list(@RequestParam(required = false) String bu_Id, @RequestParam(required = false) String wareHouse_Master_Id) {
		return invFlowConfigService.getList2(bu_Id, wareHouse_Master_Id);
	}
	
	@GetMapping("/item_list")
	@ResponseBody
	public List<WareHouseItemListVO> item_List(@RequestParam(required = false) String bu_Id, @RequestParam(required = false) String wareHouse_Id) {
		return invFlowConfigService.getWareHouseItemList(bu_Id, wareHouse_Id);
	}
	
	@GetMapping("/contact_list")
	@ResponseBody
	public List<WareHouseContactListVO> contact_List(@RequestParam(required = false) String bu_Id, @RequestParam(required = false) String wareHouse_Id) {
		return invFlowConfigService.getWareHouseContactList(bu_Id, wareHouse_Id);
	}
	
	@PostMapping("save")
	@ResponseBody
	public void save(InvFlowConfigVO vo) {
		invFlowConfigService.save(vo);
	}
	
	@PostMapping("save_detail1")
	@ResponseBody
	public String save_Detail1(@RequestBody List<List<String>> allData) {
		
		if (allData != null && !allData.isEmpty()) {
	        // 첫 번째 row
	        List<String> firstRow = allData.get(0);

	        String bu_Id = firstRow.get(0);
	        String wareHouse_Master_Id = firstRow.get(1);
	        String wareHouse_Id = firstRow.get(2);

	        // 조건 삭제
	        invFlowConfigService.delete_Detail1(bu_Id, wareHouse_Master_Id, wareHouse_Id);
	    }
		
		for (List<String> row: allData) {
			WareHouseItemListVO vo = new WareHouseItemListVO();
			vo.setBu_Id(row.get(0));
			vo.setWareHouse_Master_Id(row.get(1));
			vo.setWareHouse_Id(row.get(2));
			vo.setItem_Id(row.get(3));
			
			invFlowConfigService.save_Detail1(vo);
		}
		
		return "success";
	}
	
	@PostMapping("save_detail2")
	@ResponseBody
	public String save_Detail2(@RequestBody List<List<String>> allData) {
		
		if (allData != null && !allData.isEmpty()) {
	        // 첫 번째 row
	        List<String> firstRow = allData.get(0);

	        String bu_Id = firstRow.get(0);
	        String wareHouse_Master_Id = firstRow.get(1);
	        String wareHouse_Id = firstRow.get(2);

	        // 조건 삭제
	        invFlowConfigService.delete_Detail2(bu_Id, wareHouse_Master_Id, wareHouse_Id);
	    }
		
		for (List<String> row: allData) {
			WareHouseContactListVO vo = new WareHouseContactListVO();
			vo.setBu_Id(row.get(0));
			vo.setWareHouse_Master_Id(row.get(1));
			vo.setWareHouse_Id(row.get(2));
			vo.setContact_Id(row.get(3));
			
			invFlowConfigService.save_Detail2(vo);
		}
		
		return "success";
	}
	
	// 출고 처리하기
	@GetMapping("/outbound")
	public void outBound(Model model) {
		model.addAttribute("bu_Id", invFlowConfigService.business_UnitList());
	}	
	
	@GetMapping("/out_detail_list")
	@ResponseBody
	public List<OutBoundMasterVO> outBoundDetailSearch1(@RequestParam("bu_Id") String bu_Id, @RequestParam("out_Id") String out_Id) {
		
		return invFlowConfigService.getOutBoundDetail2(bu_Id, out_Id);
	}

	@PostMapping("/outbound_save")
	@ResponseBody
	public String ountBound_Save(@ModelAttribute OutBoundMasterVO obm) {
		
		String out_Id = obm.getOut_Id();
		String new_Out_Id = "";
		
		if ("자동생성".equals(out_Id)) {
			
			new_Out_Id = invFlowConfigService.new_Out_Id(obm.getBu_Id());
			
			Long newOutId = Long.valueOf(new_Out_Id); 
			obm.setLong_Out_Id(newOutId);
			
			Long newBuId = Long.valueOf(obm.getBu_Id());
			obm.setLong_Bu_Id(newBuId);
			
			Long newPartyId = Long.valueOf(obm.getParty_Id());
			obm.setLong_Party_Id(newPartyId);
			
			Long newContactId = Long.valueOf(obm.getContact_Id());
			obm.setLong_Contact_Id(newContactId);

			invFlowConfigService.newOutBoundMasterSave(obm);
		} else {
			new_Out_Id = obm.getOut_Id();
			Long newOutId = Long.valueOf(obm.getOut_Id()); 
			obm.setLong_Out_Id(newOutId);
			
			Long newBuId = Long.valueOf(obm.getBu_Id());
			obm.setLong_Bu_Id(newBuId);
			
			Long newPartyId = Long.valueOf(obm.getParty_Id());
			obm.setLong_Party_Id(newPartyId);
			
			Long newContactId = Long.valueOf(obm.getContact_Id());
			obm.setLong_Contact_Id(newContactId);
			
			invFlowConfigService.updateOutBoundMasterSave(obm);
		}
		
		return new_Out_Id;
	}
	
	@PostMapping("outbound_save_detail")
	@ResponseBody
	public String outBound_Save_Detail1(@RequestBody List<List<String>> allData) {
		
		if (allData != null && !allData.isEmpty()) {
	        // 첫 번째 row
	        List<String> firstRow = allData.get(0);

	        String bu_Id = firstRow.get(1);
	        String Out_Id = firstRow.get(2);

	        // 조건 삭제
	        invFlowConfigService.outBound_Delete_Detail(bu_Id, Out_Id);
	    }
		
		for (List<String> row: allData) {
			OutBoundMasterVO vo = new OutBoundMasterVO();
			
			vo.setParty_Id(row.get(0));
			vo.setBu_Id(row.get(1));
			vo.setOut_Id(row.get(2));
			vo.setItem_Id(row.get(3));
			vo.setWareHouse_Id(row.get(18));
			vo.setQty(row.get(8));
			vo.setUnit_Price(row.get(10));
			vo.setSurtax_Yn(row.get(11));
			
			invFlowConfigService.outBound_Save_Detail(vo);
		}
		
		return "success";
	}
	
	@GetMapping("outBound_delete")
	@ResponseBody
	public String out_Delete(@RequestParam("bu_Id") String bu_Id, @RequestParam("out_Id") String out_Id) {
		invFlowConfigService.outBound_Delete_Detail(bu_Id, out_Id);
		
		invFlowConfigService.outBound_Delete_Master(bu_Id, out_Id);
		
		return "success";
	}
	
	@PostMapping("outBound_update")
	@ResponseBody
	public String outBound_Update(@RequestParam("bu_Id") String bu_Id, @RequestParam("out_Id") String out_Id) {
		invFlowConfigService.outBound_Update(bu_Id, out_Id);
		
		return "success";
	}
}
