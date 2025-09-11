package org.logistics.service;

import java.util.List;
import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;

public interface StockAnalysisService {
    // 주기별 재고 분석 (복수 결과)
    List<StockAnalysisResponseDTO> getPeriodicStockAnalysis(StockAnalysisRequestDTO requestDTO);

    // 단일 분석 (단건 결과)
    StockAnalysisResponseDTO analyzeStock(StockAnalysisRequestDTO requestDTO);
}
