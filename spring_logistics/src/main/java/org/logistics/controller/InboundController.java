package org.logistics.controller;

import java.util.List;
import java.util.Map;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.logistics.service.InboundService;
import org.logistics.domain.InboundVO;

@RestController
@RequestMapping("/inbound")
public class InboundController {

    @Autowired
    private InboundService service;

    @GetMapping("/list")
    public List<InboundVO> list(@RequestParam Map<String, Object> params) {
        return service.getByItemId(params);
    }
}
