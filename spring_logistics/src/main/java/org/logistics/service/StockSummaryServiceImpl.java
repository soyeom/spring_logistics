package org.logistics.service;

import java.util.List;

import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockLedgerResultDto;
import org.logistics.domain.StockSummaryResultDto;
import org.logistics.mapper.StockSummaryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class StockSummaryServiceImpl implements StockSummaryService {
	
	/*
	 * @Service 어노테이션: 이 클래스가 Spring의 서비스 계층 컴포넌트임을 나타냅니다.
	 * @Controller와 @Repository 사이에 위치하며, 비즈니스 로직을 처리하는 역할을 합니다.
	 * Spring은 이 어노테이션을 보고 이 클래스를 빈(Bean)으로 등록하여 다른 곳에서 주입받아 사용할 수 있게 합니다.
	 * implements StockSummaryService: 이 클래스는 StockSummaryService 인터페이스를 구현합니다.
	 * 이는 인터페이스에 선언된 모든 메서드를 이 클래스가 반드시 구현해야 한다는 의미입니다.
	 * 이로써 서비스 계층의 일관성을 보장합니다.
	 */

    // 메인 검색 구현
    @Setter(onMethod_ = @Autowired)
    private StockSummaryMapper stockSummaryMapper;
    
    /*
     * @Setter(onMethod_ = @Autowired): 이 코드는 Lombok 라이브러리의 기능입니다.
     * @Setter: 이 필드(stockSummaryMapper)에 대한 Setter 메서드를 자동으로 생성해줍니다.
     * onMethod_ = @Autowired: 생성된 Setter 메서드 위에 @Autowired 어노테이션을 붙여주도록 지시합니다.
     * 결과적으로 Spring이 StockSummaryMapper의 인스턴스를 자동으로 주입(Dependency Injection)하게 됩니다.
     * private StockSummaryMapper stockSummaryMapper;: 이 필드는 Mapper 인터페이스를 참조합니다.
     * 서비스 계층은 이 Mapper를 통해 데이터베이스에 접근하여 데이터를 조회하거나 수정하는 등의 작업을 수행합니다.
     */
    
    // 재고 수불집계 조회 구현
    @Override
    public List<StockSummaryResultDto> getStockSummaryList(SearchCriteriaDto criteria) {
        return stockSummaryMapper.selectStockSummaryList(criteria);
    }
    
    /*
     * @Override: 이 메서드가 상위 인터페이스(StockSummaryService)의 메서드를 재정의했음을 나타냅니다.
     * public List<StockSummaryResultDto> getStockSummaryList(SearchCriteriaDto criteria) { ... }:
     * 이 메서드는 재고 수불집계 목록을 조회하는 비즈니스 로직을 구현합니다.
     * return stockSummaryMapper.selectStockSummaryList(criteria); 코드는 직접적인 로직 없이,
     * 단순히 Mapper에게 작업을 위임합니다. 이는 서비스 계층의 역할이 데이터베이스 접근이 아닌,
     * 비즈니스 로직을 처리하는 것임을 보여줍니다. 이 경우 비즈니스 로직이 단순하여 Mapper 호출만으로 충분합니다.
     */
    
    // 재고원장 조회 구현
    @Override
    public List<StockLedgerResultDto> getStockLedgerList(SearchCriteriaDto criteria) {
        return stockSummaryMapper.selectStockLedgerList(criteria);
    }
    
    /*
     * public List<StockLedgerResultDto> getStockLedgerList(SearchCriteriaDto criteria) { ... }:
     * 이 메서드 역시 재고원장 목록을 조회하는 비즈니스 로직을 구현합니다.
     * 위와 마찬가지로 stockSummaryMapper.selectStockLedgerList(criteria); 를 호출하여
     * 데이터 조회 작업을 Mapper에 위임합니다.
     */
}