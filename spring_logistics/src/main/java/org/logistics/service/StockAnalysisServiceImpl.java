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
    public List<StockAnalysisResponseDTO> getPeriodicStockAnalysis(StockAnalysisRequestDTO requestDTO) {
        return stockAnalysisMapper.getPeriodicStockAnalysis(requestDTO);
    }

    @Override
    public StockAnalysisResponseDTO analyzeStock(StockAnalysisRequestDTO requestDTO) {
        // 예시로 단일 결과를 가져오는 쿼리 호출 또는 로직 작성
        List<StockAnalysisResponseDTO> list = stockAnalysisMapper.getStockAnalysisData(requestDTO);
        if (list == null || list.isEmpty()) {
            return null;
        }
        return list.get(0); // 단일 결과 반환 (필요에 따라 예외 처리 가능)
    }
}
