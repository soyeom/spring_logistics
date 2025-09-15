package org.logistics.controller;

import java.util.List;

import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;
import org.logistics.service.StockAnalysisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/stock-analysis")
public class StockAnalysisController {

    private final StockAnalysisService stockAnalysisService;

    @Autowired
    public StockAnalysisController(StockAnalysisService stockAnalysisService) {
        this.stockAnalysisService = stockAnalysisService;
    }

    // 📌 Ajax에서 호출하는 API (DB 조회)
    @PostMapping(value="/analysis", consumes = "application/json", produces = "application/json")
    @ResponseBody
    public List<StockAnalysisResponseDTO> getStockAnalysis(@RequestBody StockAnalysisRequestDTO requestDTO) {
        return stockAnalysisService.getStockAnalysisData(requestDTO);
    }

    // 📌 JSP 화면 연결
    @GetMapping("/form")
    public String viewPage() {
        // StockAnalysis-form.jsp 로 이동
        return "StockAnalysis-form";
    }

   

}
