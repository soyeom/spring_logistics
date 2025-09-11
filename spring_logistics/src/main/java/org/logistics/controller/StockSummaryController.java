package org.logistics.controller;

import java.util.List;

import org.logistics.domain.ItemCategoryDto;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockSummaryResultDto;
import org.logistics.service.StockSummaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/stock")
public class StockSummaryController {

    @Autowired
    private StockSummaryService stockSummaryService;

    @GetMapping("/summary")
    public String showStockSummaryPage() {
        return "stock/stockSummary"; // stockSummary.jsp 반환
    }

    @GetMapping(value = "/summary/search", produces = "application/json")
    @ResponseBody // 메서드의 반환 값을 JSON 데이터로 바로 보냄
    public ResponseEntity<List<StockSummaryResultDto>> searchStockSummary(
        @ModelAttribute SearchCriteriaDto criteria) {
    	
    	System.out.println("Received SearchCriteriaDto: " + criteria.toString());
        
    	// 서비스를 호출하여 검색 조건에 맞는 재고 데이터를 가져옴
        List<StockSummaryResultDto> resultList = stockSummaryService.getStockSummaryList(criteria);
        return ResponseEntity.ok(resultList);
    }
    
    // --- 모달 검색 API 엔드포인트 추가 ---
    @GetMapping(value = "/categories/big", produces = "application/json")
    @ResponseBody // 메서드의 반환 값을 JSON 데이터로 바로 보냄
    public ResponseEntity<List<ItemCategoryDto>> getBigCategories(@RequestParam(required = false) String searchTerm) {
        List<ItemCategoryDto> categories = stockSummaryService.getDistinctBigCategories(searchTerm);
        return ResponseEntity.ok(categories);
    }

    @GetMapping(value = "/categories/mid", produces = "application/json")
    @ResponseBody
    public ResponseEntity<List<ItemCategoryDto>> getMidCategories(@RequestParam(required = false) String searchTerm) {
        List<ItemCategoryDto> categories = stockSummaryService.getDistinctMidCategories(searchTerm);
        return ResponseEntity.ok(categories);
    }

    @GetMapping(value = "/categories/small", produces = "application/json")
    @ResponseBody
    public ResponseEntity<List<ItemCategoryDto>> getSmallCategories(@RequestParam(required = false) String searchTerm) {
        List<ItemCategoryDto> categories = stockSummaryService.getDistinctSmallCategories(searchTerm);
        return ResponseEntity.ok(categories);
    }
}
