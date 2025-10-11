package org.logistics.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.logistics.domain.ContactVO;
import org.logistics.domain.InvFlowConfigVO;
import org.logistics.service.ContactService;
import org.logistics.service.InvFlowConfigService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	// 로그인
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
		
	    ContactVO user = contactService.login_Check(bu_Id, contact_Id, password);

	    if (user != null) {
	        session.setAttribute("loginUser", user);
	        return "{\"result\":\"success\"}";
	    } else {
	        return "{\"result\":\"fail\"}";
	    }
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request) { 	
		
		session.invalidate();
		String referer = request.getHeader("Referer"); // 이전 페이지 URL 가져오기
		
		return referer;
	}
	
	// 회원가입
	@GetMapping("/signin")
	public void signIn(Model model) { 	
		model.addAttribute("bu_Id", invFlowConfigService.business_UnitList());	
	}
	
	@PostMapping("save")
	@ResponseBody
	public String save(ContactVO vo) {
		
		int count = contactService.idCheck(vo);

		if (count == 0) {
			contactService.save(vo);
	        return "success";
		} else {
			return "fail";
		}

	}
}
