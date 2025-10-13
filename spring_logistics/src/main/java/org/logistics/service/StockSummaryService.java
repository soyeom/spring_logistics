package org.logistics.service;

import java.util.List;

import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockLedgerResultDto;
import org.logistics.domain.StockSummaryResultDto;

public interface StockSummaryService {

    // メインの在庫受払集計検索
    List<StockSummaryResultDto> getStockSummaryList(SearchCriteriaDto criteria);
    
    // 在庫元帳 照会
    List<StockLedgerResultDto> getStockLedgerList(SearchCriteriaDto criteria);

}
