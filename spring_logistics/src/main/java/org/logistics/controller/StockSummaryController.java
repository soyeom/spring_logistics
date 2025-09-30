package org.logistics.controller;

import java.util.List;

import org.logistics.domain.PopupItemVO;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockLedgerResultDto;
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
    
    /*
     * @Controller: 이 클래스가 Spring MVC의 컨트롤러 역할을 수행함을 나타냅니다.
     * 웹 요청을 받아 처리하고 뷰(View)를 반환하는 역할을 합니다.
     * @RequestMapping("/stock"): 이 컨트롤러의 모든 메서드는 /stock이라는 기본 경로를 가집니다.
     * 예를 들어, 아래의 @GetMapping("/summary")는 /stock/summary 경로에 매핑됩니다.
     * @Autowired: Spring 프레임워크가 StockSummaryService의 인스턴스를 자동으로 주입(Dependency Injection)하도록 지시합니다.
     * 이를 통해 컨트롤러는 서비스 계층의 비즈니스 로직을 호출할 수 있습니다.
     */

    // 수불집계 페이지 표시
    @GetMapping("/summary")
    public String showStockSummaryPage() {
        return "stock/stockSummary"; // stockSummary.jsp 반환
    }
    
    /* 
     * @GetMapping("/summary"): GET 방식의 /stock/summary 요청을 이 메서드에 매핑합니다.
     * 사용자가 웹 브라우저에서 해당 URL로 접근할 때 호출됩니다.
     * public String showStockSummaryPage(): 웹 페이지를 반환하는 메서드입니다.
     * 반환 값인 "stock/stockSummary"는 Spring이 src/main/webapp/WEB-
     * INF/views/stock/stockSummary.jsp
     * 파일을 찾아 사용자에게 보여주도록 지시합니다.
     */

    @GetMapping(value = "/summary/search", produces = "application/json")
    @ResponseBody // 메서드의 반환 값을 JSON 데이터로 바로 보냄
    public ResponseEntity<List<StockSummaryResultDto>> searchStockSummary(
        @ModelAttribute SearchCriteriaDto criteria) {
    	
    	System.out.println("Received SearchCriteriaDto: " + criteria.toString());
        
    	// 서비스를 호출하여 검색 조건에 맞는 재고 데이터를 가져옴
        List<StockSummaryResultDto> resultList = stockSummaryService.getStockSummaryList(criteria);
        return ResponseEntity.ok(resultList);
    }
    
    /*
     * @GetMapping("/summary/search"): /stock/summary/search URL에 대한 GET 요청을 처리합니다.
     * produces = "application/json": 이 메서드가 JSON 형식의 응답을 생성함을 명시합니다.
     * @ResponseBody: 이 메서드의 반환 값이 HTTP 응답 본문(Body)으로 직접 전송되어야 함을 나타냅니다.
     * 즉, 뷰 페이지를 반환하는 것이 아니라, 데이터를 반환합니다.
     * @ModelAttribute SearchCriteriaDto criteria: HTTP 요청 파라미터(예: searchPeriodStart, businessBuName)를 SearchCriteriaDto 객체에 자동으로 매핑합니다.
     * System.out.println(...): 디버깅 목적으로, 클라이언트로부터 전달받은 검색 조건 객체의 내용을 콘솔에 출력합니다.
     * stockSummaryService.getStockSummaryList(criteria): 주입받은 stockSummaryService의 getStockSummaryList 메서드를 호출하여 실제 데이터베이스 조회 로직을 실행합니다. criteria 객체를 넘겨주어 검색 조건을 적용합니다.
     * ResponseEntity.ok(resultList): HTTP 상태 코드 200(OK)와 함께 조회된 resultList를 JSON 형식으로 클라이언트에 반환합니다.
     */
    
    // 재고원장
    @GetMapping("/ledger")
    public String showStockLedgerPage() {
        return "stock/stockLedger"; // stockLedger.jsp 반환
    }
    
    /*
     * @GetMapping("/ledger"): /stock/ledger URL에 대한 GET요청을 처리합니다.
     * public String showStockLedgerPage(): "stock/stockLedger"라는 뷰 이름을 반환하여
     * 재고원장 조회 페이지(stockLedger.jsp)를 사용자에게 보여줍니다.
     */
    
    // --- 사업단위 재고원장 조회 API 엔드포인트 추가 ---
    @GetMapping(value = "/ledger/search", produces = "application/json")
    @ResponseBody
    public ResponseEntity<List<StockLedgerResultDto>> searchStockLedger(
    	@ModelAttribute SearchCriteriaDto criteria) {
    	
    	System.out.println("Received SearchCriteriaDto: " + criteria.toString());
    	
    	// 서비스를 호출하여 검색 조건에 맞는 재고 데이터를 가져옴
        List<StockLedgerResultDto> resultList = stockSummaryService.getStockLedgerList(criteria);
        return ResponseEntity.ok(resultList);
    }
    
    /*
     * @GetMapping("/summary/search"): /stock/summary/search URL에 대한 GET 요청을 처리합니다.
     * produces = "application/json": 이 메서드가 JSON 형식의 응답을 생성함을 명시합니다.
     * @ResponseBody: 이 메서드의 반환 값이 HTTP 응답 본문(Body)으로 직접 전송되어야 함을 나타냅니다.
     * 즉, 뷰 페이지를 반환하는 것이 아니라, 데이터를 반환합니다.
     * @ModelAttribute SearchCriteriaDto criteria: HTTP 요청 파라미터(예:
     * SearchPeriodStart, businessBuName)를 SearchCriteriaDto 객체에 자동으로 매핑합니다.
     * System.out.println(...): 디버깅 목적으로, 클라이언트로부터 전달받은 검색 조건 객체의 내용을 콘솔에 출력합니다.
     * stockSummaryService.getStockSummaryList(criteria): 주입받은 stockSummaryService의
     * getStockSummaryList메서드를 호출하여 실제 데이터베이스 조회 로직을 실행합니다.
     * criteria객체를 넘겨주어 검색 조건을 적용합니다.
     * Response Entity.ok(resultList): HTTP 상태 코드 200(OK)와 함께 조회된 resultList를 JSON 형식으로 클라이언트에 반환합니다.
     */
}
