package org.logistics.mapper;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockLedgerResultDto;
import org.logistics.domain.StockSummaryResultDto;

public interface StockSummaryMapper {

    /**
     * 在庫受払集計情報を照会します。
     * @param criteria 照会条件 DTO
     * @return 照会結果 DTO リスト
     */
    List<StockSummaryResultDto> selectStockSummaryList(SearchCriteriaDto criteria);
    
    // 事業単位 ID 照会
    Integer selectBusinessBuIdByName(String buName);
    
    // 在庫元帳 照会クエリ
    List<StockLedgerResultDto> selectStockLedgerList(SearchCriteriaDto criteria);
    
    // 繰越在庫 照会クエリ
    List<StockSummaryResultDto> selectCarriedOverStock(SearchCriteriaDto criteria);
}
