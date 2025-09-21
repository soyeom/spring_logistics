package org.logistics.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;

@Mapper
public interface StockAnalysisMapper {
    List<StockAnalysisResponseDTO> getBaseItemList(StockAnalysisRequestDTO requestDTO);

    /**
     * 기간별 값 조회
     * 파라미터 이름을 @Param으로 명시하여 XML에서 #{itemId} 등으로 바인딩 가능하게 합니다.
     */
    Double getPeriodValue(
        @Param("itemId") Long itemId,
        @Param("buId") Long buId,
        @Param("startMonth") String startMonth, // "YYYYMM"
        @Param("endMonth") String endMonth,     // "YYYYMM"
        @Param("analysisItem") String analysisItem
    );
}
