package org.logistics.mapper;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.logistics.domain.ItemCategoryDto;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockLedgerResultDto;
import org.logistics.domain.StockSummaryResultDto;

public interface StockSummaryMapper {

    /**
     * 재고 수불집계 정보를 조회합니다.
     * @param criteria 조회 조건 DTO
     * @return 조회 결과 DTO 리스트
     */
    List<StockSummaryResultDto> selectStockSummaryList(SearchCriteriaDto criteria);
    
    /*
     * 기능: 사용자가 입력한 검색 조건(criteria)을 기반으로 재고 수불집계 정보를 조회합니다.
     * 연결: 이 메서드는 StockSummaryMapper.xml 파일의 selectStockSummaryList 쿼리에 매핑되어 있습니다.
     * 반환 값: 조회된 재고 수불집계 데이터 목록(List<StockSummaryResultDto>)을 반환합니다.
     */
    
    // 사업단위 ID 조회
    Integer selectBusinessBuIdByName(String buName);
    
    /*
     * 기능: 사업단위 이름(buName)을 사용하여 해당 사업단위의 고유 ID를 조회합니다.
     * 이 ID는 다른 쿼리에서 필터링 조건으로 사용될 수 있습니다.
     */
    
    // 재고원장 조회 쿼리
    List<StockLedgerResultDto> selectStockLedgerList(SearchCriteriaDto criteria);
    
    /*
     * 기능: 재고원장 페이지에서 사용되는 조회 메서드로, 검색조건(criteria)에 맞는 재고원장 상세 데이터를 조회합니다.
     * 연결: StockSummaryMapper.xml의 selectStockLedgerList 쿼리와 연결됩니다.
     */
    
    // 이월재고 조회 쿼리
    List<StockSummaryResultDto> selectCarriedOverStock(SearchCriteriaDto criteria);
    
    /*
     * 기능: SearchCriteriaDto에 정의된 기간 시작일 이전에 발생한 거래를 바탕으로 이월 재고를 계산하고 조회합니다.
     * 이 정보는 수불집계 페이지에서 기초 재고로 사용됩니다.
     */
}
