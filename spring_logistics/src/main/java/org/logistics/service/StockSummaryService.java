package org.logistics.service;

import java.util.List;

import org.logistics.domain.ItemCategoryDto;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockLedgerResultDto;
import org.logistics.domain.StockSummaryResultDto;

public interface StockSummaryService {

    // 메인 검색
    List<StockSummaryResultDto> getStockSummaryList(SearchCriteriaDto criteria);
    
    /*
     * 기능: 재고 수불집계 페이지에서 사용자가 입력한 다양한 검색 조건(criteria)을 기반으로 데이터베이스에서 재고 정보를 조회합니다.
     * 이 메서드는 단순히 StockSummaryMapper의 해당 메서드를 호출하여 데이터를 가져오는 역할을 합니다.
     * DTO: SearchCriteriaDto는 검색 조건을 담고, StockSummaryResultDto는 조회된 결과 데이터를 담는 객체입니다.
     */
    
    // 재고원장 조회
    List<StockLedgerResultDto> getStockLedgerList(SearchCriteriaDto criteria);
    
    /*
     * 메서드: List<StockLedgerResultDto> getStockLedgerList(SearchCriteriaDto criteria)
     * 기능: 재고원장 페이지에서 사용자의 검색 조건(criteria)에 맞는 재고 거래 내역을 상세하게 조회합니다.
     * DTO: StockLedgerResultDto는 재고 거래의 상세 정보를 담는 객체입니다.
     */

}
