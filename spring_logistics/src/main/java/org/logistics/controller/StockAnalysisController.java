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

    /**
     * 📌 Ajax에서 호출하는 API
     * - DB에서 계산된 결과를 Map 구조로 내려줌
     * - 각 row는 {itemId, itemName, ..., "202509": 123, "202506": 90, ...} 형식
     */
    @PostMapping(value="/analysis", consumes = "application/json", produces = "application/json")
    @ResponseBody
    public List<Map<String, Object>> getStockAnalysisAjax(@RequestBody StockAnalysisRequestDTO requestDTO) {
        return stockAnalysisService.getStockAnalysisData(requestDTO);
    }

    /**
     * 📌 JSP 화면 렌더링 방식 (form 호출 시)
     */
    @GetMapping("/form")
    public String viewFormPage() {
        return "StockAnalysis-form"; // StockAnalysis-form.jsp 로 이동
    }

    /**
     * 📌 JSP에서 바로 DB 조회 후 테이블로 뿌리는 방식
     */
    @GetMapping("/table")
    public String getStockAnalysisTable(StockAnalysisRequestDTO requestDTO, Model model) {
        List<Map<String, Object>> analysisData = stockAnalysisService.getStockAnalysisData(requestDTO);
        model.addAttribute("analysisData", analysisData);
        return "stock/analysis"; // stock/analysis.jsp 로 이동
    }

    /**
     * 📌 창고 선택 팝업 페이지 이동
     */
    @GetMapping("/warehouse-popup")
    public String warehousePopup() {
        return "warehouse-popup"; // warehouse-popup.jsp 로 이동
    }

    /**
     * 📌 소분류 선택 팝업 페이지 이동
     */
    @GetMapping("/item-small-category-popup")
    public String itemSmallCategoryPopup() {
        return "item-small-category-popup"; // item-small-category-popup.jsp 로 이동
    }
}
