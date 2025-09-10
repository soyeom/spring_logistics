package org.logistics.controller;

import java.util.List;

import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;
import org.logistics.service.StockAnalysisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; // @RestController -> @Controller로 변경
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody; // 추가

@Controller
@RequestMapping("/stockAnalysis")
public class StockAnalysisController {

    private final StockAnalysisService stockAnalysisService;

    @Autowired
    public StockAnalysisController(StockAnalysisService stockAnalysisService) {
        this.stockAnalysisService = stockAnalysisService;
    }

    @GetMapping("/form")
    public String showStockAnalysisForm() {
        return "StockAnalysis-form"; // JSP 뷰 반환
    }

    @PostMapping("/analysis")
    @ResponseBody // JSON 데이터 반환을 명시
    public List<StockAnalysisResponseDTO> getPeriodicStockAnalysis(@RequestBody StockAnalysisRequestDTO requestDTO) {
        return stockAnalysisService.getPeriodicStockAnalysis(requestDTO);
    }
    
    @GetMapping("/warehouseSearchPopup")
    public String showWarehouseSearchPopup() {
    	
    	return "warehouseSearchPopup";
    }
    
    @GetMapping("/itemSubCategorySearchPopup")
    public String showitemSubCategorySearchPopup() {
    	return "itemSubCategorySearchPopup";
    }
}