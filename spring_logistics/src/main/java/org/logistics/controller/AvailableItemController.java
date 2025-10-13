package org.logistics.controller;

import java.util.List;
import java.util.Map;

import org.logistics.domain.AvailableItemVO;
import org.logistics.service.AvailableItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.logistics.service.*;
@Controller
@RequestMapping("/availableItems")
public class AvailableItemController {

    @Autowired
    private AvailableItemService service;
    
    @Autowired
    private PopupService popupService;

    @GetMapping
    public String view(Model model) {
        model.addAttribute("items", service.getAvailableItems());
        model.addAttribute("buList", service.getBusinessUnits());
        model.addAttribute("assetClassList",service.getAssetClasses());
        
        return "availableItems";
    }

    @GetMapping("/list")
    @ResponseBody
    public List<AvailableItemVO> search(@RequestParam Map<String, Object> params) {
        boolean isEmpty = params.values().stream().allMatch(v -> v == null || v.toString().isEmpty());

        if (isEmpty) {
            return service.getAvailableItems();
        } else {
            return service.search(params);
        }
    }
}

