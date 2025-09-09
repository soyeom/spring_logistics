package org.logistics.controller;

import org.logistics.domain.OutRequestDTO;
import org.logistics.service.OutService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/out") // 모든 출고 관련 요청은 /out으로 시작
@AllArgsConstructor
public class OutController {

	private OutService outService;

	@GetMapping("/form") // 출고 입력 폼 화면
	public String showOutForm(Model model) {
		model.addAttribute("outRequestDTO", new OutRequestDTO());
		return "out-form"; // JSP 파일 이름과 일치
	}

	@PostMapping("/create") // 출고 정보를 저장하는 요청
	public String createOut(@ModelAttribute OutRequestDTO request, Model model) {
		outService.createOut(request);
		model.addAttribute("message", "출고 정보가 저장되었습니다.");
		return "out-success"; // JSP 파일 이름과 일치
	}
}