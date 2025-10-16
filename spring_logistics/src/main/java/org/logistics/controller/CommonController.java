package org.logistics.controller;

import java.util.List;
import org.logistics.domain.BusinessUnitDTO;
import org.logistics.service.CommonService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/common")
public class CommonController {

    private final CommonService commonService;

    // Service 주입
    public CommonController(CommonService commonService) {
        this.commonService = commonService;
    }

    // GET http://localhost:8282/common/bus 요청 처리
    @GetMapping("/bus")
    public ResponseEntity<List<BusinessUnitDTO>> getBusinessUnits() {
        // Service를 통해 DB 데이터를 가져와 JSON으로 반환
        List<BusinessUnitDTO> buList = commonService.getBusinessUnits();
        
        // 데이터가 없어도 200 OK를 반환합니다. (빈 리스트)
        return ResponseEntity.ok(buList); 
    }
}