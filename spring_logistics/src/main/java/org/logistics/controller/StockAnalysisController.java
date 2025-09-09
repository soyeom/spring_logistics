package org.logistics.controller;

import java.util.List;

import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;
import org.logistics.service.StockAnalysisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/stockAnalysis")
public class StockAnalysisController {

	private final StockAnalysisService stockAnalysisService;
	
	@Autowired
    public StockAnalysisController(StockAnalysisService stockAnalysisService) {
        this.stockAnalysisService = stockAnalysisService;
    }
	
	@PostMapping("/analysis")
	public List<StockAnalysisResponseDTO> getStockAnalysisData(@RequestBody StockAnalysisRequestDTO requestDTO){
		return stockAnalysisService.getPeriodicStockAnalysis(requestDTO);
}
	
}