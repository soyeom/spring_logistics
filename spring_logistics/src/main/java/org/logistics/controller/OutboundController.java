package org.logistics.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.logistics.domain.InboundVO;
import org.logistics.domain.OutboundVO;
import org.logistics.service.OutboundService;

@RestController
@RequestMapping("/outbound")
public class OutboundController {

    @Autowired
    private OutboundService service;

    @GetMapping("/list")
    public List<OutboundVO> list(@RequestParam Map<String, Object> params) {
        return service.selectByItemId(params);
    }
}
