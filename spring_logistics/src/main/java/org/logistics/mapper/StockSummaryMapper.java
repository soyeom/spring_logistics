package org.logistics.mapper;

import java.util.List;

import org.logistics.domain.CommonVO;
import org.logistics.domain.SearchCriteriaDto;
import org.logistics.domain.StockLedgerResultDto;
import org.logistics.domain.StockSummaryResultDto;

public interface StockSummaryMapper {

    /**
     * 在庫受払集計情報を照会します。
     * @param criteria 照会条件 DTO
     * @return 照会結果 DTO リスト
     */
    List<StockSummaryResultDto> selectStockSummaryList(SearchCriteriaDto criteria);
    
    // 事業単位 ID 照会
    Integer selectBusinessBuIdByName(String buName);
    
    // 在庫元帳 照会クエリ
    List<StockLedgerResultDto> selectStockLedgerList(SearchCriteriaDto criteria);
    
    // 繰越在庫 照会クエリ
    List<StockSummaryResultDto> selectCarriedOverStock(SearchCriteriaDto criteria);
    
    // 品目資産分類リストを照会するメソッドを追加
    /**
     * 品目資産分類のコードリストを照会します。
     * @return 品目資産分類リスト (例: PopupItemVO リスト)
     */
    List<CommonVO> selectItemAssetClassList();
    List<CommonVO> selectBusinessBuNameList();
    List<CommonVO> selectItemStatusList();
    List<CommonVO> selectUnitStandardList();
}
