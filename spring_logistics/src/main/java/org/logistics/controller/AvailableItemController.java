package org.logistics.controller;

import java.util.List;
import org.logistics.domain.AvailableItemVO;
import org.logistics.service.AvailableItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AvailableItemController {

    @Autowired
    private AvailableItemService service;

    @GetMapping("/availableItems")
    public String list(Model model) {
        List<AvailableItemVO> items = service.getAvailableItems();
        model.addAttribute("items", items);
        System.out.println("조회 결과 건수 = " + items.size());
        return "availableItems"; // JSP 파일명
    }
}
