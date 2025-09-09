package org.logistics.controller;

import java.util.List;

import org.logistics.domain.OtherOutCategory;
import org.logistics.domain.OutDetailDTO;
import org.logistics.service.OutService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/out") // 모든 출고 관련 요청은 /out으로 시작
@AllArgsConstructor
public class OutController {

	 @Autowired
	    private OutService outService; // 서비스를 주입

	    @GetMapping("/out/form")
	    public String showOutForm(Model model) {
	        // 1. 기타 출고 디테일 리스트 조회
	        List<OutDetailDTO> outDetails = outService.getOutDetails();
	        model.addAttribute("outDetails", outDetails);

	        // 2. 기타 출고 구분(카테고리) 리스트 조회
	        List<OtherOutCategory> otherOutCategories = outService.getOtherOutCategories();
	        model.addAttribute("otherOutCategories", otherOutCategories);

	        return "out-form";
	    }
	}