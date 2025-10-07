package org.logistics.controller;

import javax.servlet.http.HttpSession;

import org.logistics.domain.ContactVO;
import org.logistics.service.ContactService;
import org.logistics.service.InvFlowConfigService;
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
@RequestMapping("/Contact/*")
@AllArgsConstructor
public class ContactController {

	private InvFlowConfigService invFlowConfigService;
	private ContactService contactService;
	
	@GetMapping("/login")
	public void login(Model model) { 	
		model.addAttribute("bu_Id", invFlowConfigService.business_UnitList());	
	}
	
	@GetMapping("/login_check")
	@ResponseBody
	public String login_Check(@RequestParam(required = false) String bu_Id
							, @RequestParam(required = false) String contact_Id
							, @RequestParam(required = false) String password
							, HttpSession session) {
		
		// ② 로그인 체크
	    ContactVO user = contactService.login_Check(bu_Id, contact_Id, password);

	    if (user != null) {
	        // ③ 로그인 성공 시 세션에 사용자 정보 저장
	        session.setAttribute("loginUser", user);
	        return "{\"result\":\"success\"}";
	    } else {
	        // 로그인 실패
	        return "{\"result\":\"fail\"}";
	    }
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) { 	
		
		session.invalidate();
	    return "redirect:/";
	}
	
	
}
