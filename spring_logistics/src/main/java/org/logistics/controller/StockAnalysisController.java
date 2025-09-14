package org.logistics.controller;

import java.util.List;
import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;
import org.logistics.service.StockAnalysisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    // JSP 뷰를 반환하는 메서드
    @GetMapping("/form")
    public String showStockAnalysisForm() {
        return "StockAnalysis-form";
    }

    // JSON 데이터를 반환하는 RESTful API 메서드
    @PostMapping("/analysis")
    @ResponseBody
    public ResponseEntity<List<StockAnalysisResponseDTO>> analyzeStock(@RequestBody StockAnalysisRequestDTO requestDTO) {
        try {
            List<StockAnalysisResponseDTO> analysisData = stockAnalysisService.getStockAnalysisData(requestDTO);
            return new ResponseEntity<>(analysisData, HttpStatus.OK);
        } catch (Exception e) {
            System.err.println("재고 분석 중 오류가 발생했습니다: " + e.getMessage());
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}