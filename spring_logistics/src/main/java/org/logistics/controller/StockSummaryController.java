package org.logistics.controller;

import java.util.List;

import org.logistics.domain.CommonVO;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockLedgerResultDto;
import org.logistics.domain.StockSummaryResultDto;
import org.logistics.service.StockSummaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

    // 在庫受払集計ページの表示
    @GetMapping("/summary")
    public String showStockSummaryPage(Model model) {
    	
    	List<CommonVO> itemAssetClassList = stockSummaryService.getItemAssetClassList();
    	List<CommonVO> businessBuNameList = stockSummaryService.getBusinessBuNameList();
    	List<CommonVO> itemStatusList = stockSummaryService.getItemStatusList();
    	
    	model.addAttribute("itemAssetClassList", itemAssetClassList);
    	model.addAttribute("businessBuNameList", businessBuNameList);
    	model.addAttribute("itemStatusList", itemStatusList);
    	
        return "stock/stockSummary";
    }

    @GetMapping(value = "/summary/search", produces = "application/json")
    @ResponseBody
    public ResponseEntity<List<StockSummaryResultDto>> searchStockSummary(
        @ModelAttribute SearchCriteriaDto criteria) {
    	
    	System.out.println("Received SearchCriteriaDto: " + criteria.toString());
        
    	// サービスを呼び出し、検索条件に一致する在庫集計データを取得
        List<StockSummaryResultDto> resultList = stockSummaryService.getStockSummaryList(criteria);
        return ResponseEntity.ok(resultList);
    }
    
    // 在庫元帳ページの表示
    @GetMapping("/ledger")
    public String showStockLedgerPage(
    	@RequestParam(value = "itemId", required = false) String itemId,
    	@RequestParam(value = "itemName", required = false) String itemName,
    	Model model) {
    	
    	List<CommonVO> businessBuNameList = stockSummaryService.getBusinessBuNameList();
    	
    	model.addAttribute("businessBuNameList", businessBuNameList);
    	
    	model.addAttribute("initialItemId", itemId);
    	model.addAttribute("initialItemName", itemName);
    		
        return "stock/stockLedger";
    }
    
    // --- 事業単位別 在庫元帳 照会APIエンドポイント追加 ---
    @GetMapping(value = "/ledger/search", produces = "application/json")
    @ResponseBody
    public ResponseEntity<List<StockLedgerResultDto>> searchStockLedger(
    	@ModelAttribute SearchCriteriaDto criteria) {
    	
    	System.out.println("Received SearchCriteriaDto: " + criteria.toString());
    	
    	// サービスを呼び出し、検索条件に一致する在庫元帳データを取得
        List<StockLedgerResultDto> resultList = stockSummaryService.getStockLedgerList(criteria);
        return ResponseEntity.ok(resultList);
    }
}
