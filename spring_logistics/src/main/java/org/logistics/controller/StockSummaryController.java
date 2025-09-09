package org.logistics.controller;

import java.util.List;

import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockSummaryResultDto;
import org.logistics.service.StockSummaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/stock")
public class StockSummaryController {

    @Autowired
    private StockSummaryService stockSummaryService;

    
    /**
     * '/stock/summary' URL로 접속하면 이 메서드가 실행됩니다.
     * @return 'stockSummary.jsp'라는 웹 페이지를 사용자에게 보여줍니다.
     */
    @GetMapping("/summary")
    public String showStockSummaryPage() {
        return "stock/stockSummary"; // stockSummary.jsp 또는 stockSummary.html을 반환
    }

    
    /**
     * '/stock/summary/search' URL로 AJAX 요청이 오면 해당 메서드 실행
     * 사용자가 검색 버튼을 눌렀을 때 호출
     * @param criteria 웹 요청의 파라미터(검색 조건)를 자동으로 'SearchCriteriaDto' 객체에 담아줍니다.
     * @return 서비스에서 받은 결과 목록을 JSON 형태로 변환하여 웹 응답으로 보냅니다.
     */
    @GetMapping("/summary/search")
    @ResponseBody // 메서드의 반환 값을 JSON 데이터로 바로 보냄
    public ResponseEntity<List<StockSummaryResultDto>> searchStockSummary(
        @ModelAttribute SearchCriteriaDto criteria) {
    	
    	System.out.println("Received SearchCriteriaDto: " + criteria.toString());
        
    	// 서비스를 호출하여 검색 조건에 맞는 재고 데이터를 가져옴
        List<StockSummaryResultDto> resultList = stockSummaryService.getStockSummaryList(criteria);
        return ResponseEntity.ok(resultList);
    }
}
