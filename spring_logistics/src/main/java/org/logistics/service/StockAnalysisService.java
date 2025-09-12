package org.logistics.service;

import java.util.List;
import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;

public interface StockAnalysisService {
    List<StockAnalysisResponseDTO> getStockAnalysisData(StockAnalysisRequestDTO requestDTO);
}