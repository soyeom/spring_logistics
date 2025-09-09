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
    public List<StockAnalysisResponseDTO> getPeriodicStockAnalysis(StockAnalysisRequestDTO requestDTO) {
        // 비즈니스 로직을 구현하는 영역입니다.
        // 예를 들어, requestDTO에 있는 분석 기간(analysisPeriod) 정보를 바탕으로
        // startDate와 endDate를 계산하는 로직을 추가할 수 있습니다.

        // 매퍼를 호출하여 데이터베이스에서 재고 분석 데이터를 조회
        return stockAnalysisMapper.getPeriodicStockAnalysis(requestDTO);
    }
}