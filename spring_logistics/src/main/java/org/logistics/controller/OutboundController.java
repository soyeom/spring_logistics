package org.logistics.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.logistics.domain.OutboundVO;
import org.logistics.service.OutboundService;

@RestController
@RequestMapping("/outbound")
public class OutboundController {

    @Autowired
    private OutboundService outboundService;

    @GetMapping("/list")
    public List<OutboundVO> list(@RequestParam("itemId") int itemId,
                                 @RequestParam(value="warehouseId", required=false) Integer warehouseId) {
        Map<String, Object> params = new HashMap<>();
        params.put("itemId", itemId);
        if (warehouseId != null) {
            params.put("warehouseId", warehouseId);
        }

        List<OutboundVO> list = outboundService.getByItemId(params);

        // ✅ 컨트롤러 로그
        System.out.println(">>> OutboundController result size: " + list.size());

        return list;
    }
}
