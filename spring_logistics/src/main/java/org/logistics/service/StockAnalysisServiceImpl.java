package org.logistics.service;

import java.util.List;

import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;
import org.logistics.mapper.StockAnalysisMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StockAnalysisServiceImpl implements StockAnalysisService {

    private final StockAnalysisMapper stockAnalysisMapper;

    @Autowired
    public StockAnalysisServiceImpl(StockAnalysisMapper stockAnalysisMapper) {
        this.stockAnalysisMapper = stockAnalysisMapper;
    }

    @Override
    public List<StockAnalysisResponseDTO> getStockAnalysisData(StockAnalysisRequestDTO requestDTO) {
        // 매퍼를 호출하여 데이터베이스에서 재고 분석 데이터를 조회
        List<StockAnalysisResponseDTO> analysisData = stockAnalysisMapper.getStockAnalysisData(requestDTO);
        return analysisData;
    }
}