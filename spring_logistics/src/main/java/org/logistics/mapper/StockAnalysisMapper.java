package org.logistics.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;

@Mapper
public interface StockAnalysisMapper {

    
      //📌 基準アイテムリスト検索
      //- DTO内部のフィールドをXMLから#{dto.フィールド名}の形で参照
     
    List<StockAnalysisResponseDTO> getBaseItemList(@Param("dto") StockAnalysisRequestDTO requestDTO);

     //📌 기간별 값 조회
    Double getPeriodValue(
        @Param("dto") StockAnalysisRequestDTO requestDTO,
      //下の三つはメソッドパラメーターの値をそのまま伝達
        //warehouseIdなどのDTOフィールドはXMLから＃｛dto.フィールド名｝の形で接近
        @Param("startMonth") String startMonth,				
        @Param("endMonth") String endMonth,
        @Param("analysisItem") String analysisItem
    );
}
