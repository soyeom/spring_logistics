package org.logistics.service;

import java.util.List;

import org.logistics.domain.ItemCategoryDto;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockSummaryResultDto;

public interface StockSummaryService {

    // 메인 검색
    List<StockSummaryResultDto> getStockSummaryList(SearchCriteriaDto criteria);
    
    // 모달 검색
    List<ItemCategoryDto> getDistinctBigCategories(String searchTerm);
    List<ItemCategoryDto> getDistinctMidCategories(String searchTerm);
    List<ItemCategoryDto> getDistinctSmallCategories(String searchTerm);
    
	
}
