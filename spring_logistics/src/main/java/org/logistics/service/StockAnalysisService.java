package org.logistics.service;

import java.util.List;
import java.util.Map;

import org.logistics.domain.StockAnalysisRequestDTO;

public interface StockAnalysisService {
    List<Map<String, Object>> getStockAnalysisData(StockAnalysisRequestDTO requestDTO);
}

