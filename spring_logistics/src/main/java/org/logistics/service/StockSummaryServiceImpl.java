package org.logistics.service;

import java.util.List;

import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockSummaryResultDto;
import org.logistics.mapper.StockSummaryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class StockSummaryServiceImpl implements StockSummaryService {

	@Setter(onMethod_ = @Autowired)
	private StockSummaryMapper stockSummaryMapper;

	
    /**
     * 'StockSummaryService'에 정의된 기능을 실제로 구현한 부분입니다.
     * @param criteria 사용자가 입력한 검색 조건입니다.
     * @return 매퍼를 통해 데이터베이스에서 가져온 결과를 그대로 반환합니다.
     */
    @Override
    public List<StockSummaryResultDto> getStockSummaryList(SearchCriteriaDto criteria) {
        return stockSummaryMapper.selectStockSummaryList(criteria);
    }
}
