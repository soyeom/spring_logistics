package org.logistics.service;

import java.util.List;

import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;
import org.logistics.mapper.StockAnalysisMapper;
import org.springframework.stereotype.Service;

@Service
public class StockAnalysisServiceImpl implements StockAnalysisService {
    private final StockAnalysisMapper stockAnalysisMapper;

    public StockAnalysisServiceImpl(StockAnalysisMapper stockAnalysisMapper) {
        this.stockAnalysisMapper = stockAnalysisMapper;
    }

    @Override
    public List<StockAnalysisResponseDTO> getStockAnalysisData(StockAnalysisRequestDTO requestDTO) {
        return stockAnalysisMapper.getStockAnalysisData(requestDTO);
    }

}