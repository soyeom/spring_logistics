package org.logistics.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;

@Mapper
public interface StockAnalysisMapper {

    /**
     * 재고 변동 추이 분석 데이터를 조회합니다.
     *
     * @param requestDTO 조회 조건을 담은 DTO
     * @return 재고 분석 결과를 담은 DTO 리스트
     */
    List<StockAnalysisResponseDTO> getStockAnalysisData(StockAnalysisRequestDTO requestDTO);

	List<StockAnalysisResponseDTO> getPeriodicStockAnalysis(StockAnalysisRequestDTO requestDTO);
}