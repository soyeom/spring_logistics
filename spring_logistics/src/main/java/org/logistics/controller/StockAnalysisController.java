package org.logistics.controller;

import java.util.List;
import java.util.Map;

import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.service.StockAnalysisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

  
    @PostMapping(value="/analysis", consumes = "application/json", produces = "application/json")
    @ResponseBody
    public List<Map<String, Object>> getStockAnalysisAjax(@RequestBody StockAnalysisRequestDTO requestDTO) {
        return stockAnalysisService.getStockAnalysisData(requestDTO);
    }

  
    @GetMapping("/form")
    public String viewFormPage() {
        return "Analysis/StockAnalysis-form"; // StockAnalysis-form.jspに遷移
    }

    
    @GetMapping("/table")
    public String getStockAnalysisTable(StockAnalysisRequestDTO requestDTO, Model model) {
        List<Map<String, Object>> analysisData = stockAnalysisService.getStockAnalysisData(requestDTO);
        model.addAttribute("analysisData", analysisData);
        return "stock/analysis"; // stock/analysis.jspに遷移
    }

    
    @GetMapping("/warehouse_popup")
    public String warehouse_Popup() {
        return "warehouse_popup"; // warehouse_popup.jspに遷移
    }

    
    @GetMapping("/category_popup_small")
    public String category_popup_small() {
        return "category_popup_small"; // category_popup_small.jspに遷移
    }
}
