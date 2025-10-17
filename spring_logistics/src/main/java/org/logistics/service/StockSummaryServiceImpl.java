package org.logistics.service;

import java.util.ArrayList;
import java.util.List;

import org.logistics.domain.CommonVO;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockLedgerResultDto;
import org.logistics.domain.StockSummaryResultDto;
import org.logistics.mapper.StockSummaryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class StockSummaryServiceImpl implements StockSummaryService {

    // StockSummaryMapper をAutowiredにより注入
    @Setter(onMethod_ = @Autowired)
    private StockSummaryMapper stockSummaryMapper;
    
    // 在庫受払集計リストを照会
    @Override
    public List<StockSummaryResultDto> getStockSummaryList(SearchCriteriaDto criteria) {
        return stockSummaryMapper.selectStockSummaryList(criteria);
    }
    
    // 在庫元帳リストを照会
    @Override
    public List<StockLedgerResultDto> getStockLedgerList(SearchCriteriaDto criteria) {
        return stockSummaryMapper.selectStockLedgerList(criteria);
    }
    
    // 品目資産分類リストを取得
    @Override
    public List<CommonVO> getItemAssetClassList() {
        return stockSummaryMapper.selectItemAssetClassList(); 
    }
    
    @Override
    public List<CommonVO> getBusinessBuNameList() {
    	return stockSummaryMapper.selectBusinessBuNameList(); 
    }
    
    @Override
    public List<CommonVO> getItemStatusList() {
    	return stockSummaryMapper.selectItemStatusList(); 
    }
    
}