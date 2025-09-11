package org.logistics.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.logistics.domain.ItemCategoryDto;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockSummaryResultDto;

public interface StockSummaryMapper {

    /**
     * 재고 수불집계 정보를 조회합니다.
     * @param criteria 조회 조건 DTO
     * @return 조회 결과 DTO 리스트
     */
    List<StockSummaryResultDto> selectStockSummaryList(SearchCriteriaDto criteria);
    
    Integer selectBusinessBuIdByName(String buName);
    
    // 모달 검색 메소드
    List<ItemCategoryDto> selectDistinctBigCategories(@Param("searchTerm") String searchTerm);
    List<ItemCategoryDto> selectDistinctMidCategories(@Param("searchTerm") String searchTerm);
    List<ItemCategoryDto> selectDistinctSmallCategories(@Param("searchTerm") String searchTerm);
    
}
