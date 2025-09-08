package org.logistics.service;

import java.util.List;

import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockSummaryResultDto;

public interface StockSummaryService {

    /**
     * 사용자가 제공한 조건에 따라 재고 수불집계 목록을 가져오는 기능입니다.
     * @param criteria 사용자가 입력한 검색 조건이 담긴 객체입니다.
     * @return 데이터베이스 조회 결과가 담긴 'StockSummaryResultDto' 객체의 목록을 반환합니다.
     */
    List<StockSummaryResultDto> getStockSummaryList(SearchCriteriaDto criteria);
	
}
