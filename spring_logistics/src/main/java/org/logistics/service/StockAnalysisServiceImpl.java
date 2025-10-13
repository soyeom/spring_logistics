package org.logistics.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;
import org.logistics.mapper.StockAnalysisMapper;
import org.springframework.stereotype.Service;

@Service
public class StockAnalysisServiceImpl implements StockAnalysisService {
    private final StockAnalysisMapper stockAnalysisMapper;

    public StockAnalysisServiceImpl(StockAnalysisMapper stockAnalysisMapper) {
        this.stockAnalysisMapper = stockAnalysisMapper;
    }

    /**
     * 在庫分析データを取得するメインメソッド
     * 期間別の分析値を含む品目別データリストを返します。
     * @param requestDTO 検索条件
     * @return 期間別分析値を含む品目別データリスト
     */
    @Override
    public List<Map<String, Object>> getStockAnalysisData(StockAnalysisRequestDTO requestDTO) {
        List<Map<String, Object>> resultList = new ArrayList<>();

        // currentMonth 初期値設定: リクエストが空の場合、現在の年月(YYYY-MM)を設定
        String currentMonth = requestDTO.getCurrentMonth();
        if (currentMonth == null || currentMonth.trim().isEmpty()) {
            LocalDate now = LocalDate.now();
            currentMonth = String.format("%04d-%02d", now.getYear(), now.getMonthValue());
            requestDTO.setCurrentMonth(currentMonth);
        }

        // analysisItem 初期値設定: リクエストが空の場合、デフォルト値 "totalIn" を設定
        String analysisItem = requestDTO.getAnalysisItem();
        if (analysisItem == null || analysisItem.trim().isEmpty()) {
            analysisItem = "totalIn";
            requestDTO.setAnalysisItem(analysisItem);
        }

        // 1) 基準となる品目リストをDBから取得
        List<StockAnalysisResponseDTO> items = stockAnalysisMapper.getBaseItemList(requestDTO);
        if (items == null || items.isEmpty()) return resultList;

        // 2) 分析期間の計算
        // 🚩 수정: DTO에 periodMonths, periodCount가 없으므로 인자 없이 호출하고 함수 내부에서 고정값을 사용합니다.
        List<PeriodRange> periods = calculatePeriods(currentMonth);

        // 3) 品目ごとに期間別分析値を計算し、結果を組み立てる
        for (StockAnalysisResponseDTO item : items) {
            Map<String, Object> row = new LinkedHashMap<>();

            // 基本品目情報を設定
            row.put("itemAssetClass", item.getItemAssetClass());
            row.put("itemBigCategory", item.getItemBigCategory());
            row.put("itemSmallCategory", item.getItemSmallCategory());
            row.put("itemId", item.getItemId());
            row.put("itemName", item.getItemName());
            row.put("spec", item.getSpec());
            row.put("itemMidCategory", item.getItemMidCategory());
            row.put("baseUnit", item.getBaseUnit());

            // 期間別分析値を設定
            for (PeriodRange p : periods) {
                
                // 기간별 데이터를 가져오기 위한 DTO를 준비
                StockAnalysisRequestDTO periodDTO = new StockAnalysisRequestDTO();
                
                // buId, warehouseId, itemId는 Long/Integer 타입입니다. (DTO 수정이 전제)
                periodDTO.setBuId(requestDTO.getBuId());       
                periodDTO.setWarehouseId(requestDTO.getWarehouseId());
                periodDTO.setItemSmallCategory(requestDTO.getItemSmallCategory());
                periodDTO.setItemId(item.getItemId());
                
                // Mapper를 호출하여 기간별 분석값을 가져옵니다.
                Double value = stockAnalysisMapper.getPeriodValue(
                    periodDTO, 
                    p.getStartParam(),  
                    p.getEndParam(),    
                    analysisItem        
                );

                // 結果マップにキー(YYYY-MM)と値を追加（値がnullの場合は0を設定）
                row.put(p.getEndKey(), value == null ? 0 : value);
            }

            resultList.add(row);
        }

        return resultList;
    }
    
    /**
     * 分析期間を計算する
     * 基準月(currentMonth)から過去に遡って、3ヶ月 단위의 기간을 4개 생성합니다.
     * @param currentMonth 基準年月 (YYYY-MM)
     * @return 期間情報のリスト
     */
    // 🚩 수정: 인자 없이 currentMonth만 받도록 원상 복구합니다.
    private List<PeriodRange> calculatePeriods(String currentMonth) {
        List<PeriodRange> result = new ArrayList<>();
        String[] ym = currentMonth.split("-");
        int year = Integer.parseInt(ym[0]);
        int month = Integer.parseInt(ym[1]);

        // 🚩 수정: DTO가 없으므로, 기본값 3과 4를 하드코딩합니다.
        final int periodSize = 3; // 期間のサイズ（3ヶ月）
        final int count = 4;      // 生成する期間の数（4つ）

        for (int i = 0; i < count; i++) {
            // 期間の終了月を計算
            int endMonth = month - (i * periodSize);
            int endYear = year;
            while (endMonth <= 0) { // 年を跨ぐ場合の処理
                endMonth += 12;
                endYear--;
            }

            // 期間の開始月を計算 (終了月から periodSize - 1 을 引く)
            int startMonth = endMonth - (periodSize - 1);
            int startYear = endYear;
            while (startMonth <= 0) { // 年を跨ぐ場合の処理
                startMonth += 12;
                startYear--;
            }

            // 結果キーとパラメータ文字列を生成
            String endKey = String.format("%04d-%02d", endYear, endMonth);      // 表示用キー (YYYY-MM)
            String startParam = String.format("%04d%02d", startYear, startMonth); // DB検索用開始年月 (YYYYMM)
            String endParam = String.format("%04d%02d", endYear, endMonth);       // DB検索用終了年月 (YYYYMM)

            result.add(new PeriodRange(endKey, startParam, endParam));
        }

        return result;
    }

    // 期間情報を保持する内部クラス
    private static class PeriodRange {
        private final String endKey;    // 結果マップのキーとして使用 (YYYY-MM)
        private final String startParam; // 検索パラメータ用 開始年月 (YYYYMM)
        private final String endParam;   // 検索パラメータ用 終了年月 (YYYYMM)

        public PeriodRange(String endKey, String startParam, String endParam) {
            this.endKey = endKey;
            this.startParam = startParam;
            this.endParam = endParam;
        }

        public String getEndKey() { return endKey; }
        public String getStartParam() { return startParam; }
        public String getEndParam() { return endParam; }
    }
}