package org.logistics.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;

@Mapper
public interface StockAnalysisMapper {

    List<StockAnalysisResponseDTO> getStockAnalysisData(StockAnalysisRequestDTO requestDTO);
   
}