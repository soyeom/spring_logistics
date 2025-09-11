package org.logistics.service;

import java.util.List;

import org.logistics.domain.ItemCategoryDto;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockSummaryResultDto;
import org.logistics.mapper.StockSummaryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class StockSummaryServiceImpl implements StockSummaryService {

	//메인 검색 구현
	@Setter(onMethod_ = @Autowired)
	private StockSummaryMapper stockSummaryMapper;
	
    @Override
    public List<StockSummaryResultDto> getStockSummaryList(SearchCriteriaDto criteria) {
        return stockSummaryMapper.selectStockSummaryList(criteria);
    }
    
    // 모달 검색 구현
	@Override
	public List<ItemCategoryDto> getDistinctBigCategories(String searchTerm) {
		return stockSummaryMapper.selectDistinctBigCategories(searchTerm);
	}

	@Override
	public List<ItemCategoryDto> getDistinctMidCategories(String searchTerm) {
		return stockSummaryMapper.selectDistinctMidCategories(searchTerm);
	}

	@Override
	public List<ItemCategoryDto> getDistinctSmallCategories(String searchTerm) {
		return stockSummaryMapper.selectDistinctSmallCategories(searchTerm);
	}
}
