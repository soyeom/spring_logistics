package org.logistics.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import org.logistics.domain.StockAnalysisRequestDTO;
import org.logistics.domain.StockAnalysisResponseDTO;
import org.logistics.mapper.StockAnalysisMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StockAnalysisServiceImpl implements StockAnalysisService {

    private final StockAnalysisMapper stockAnalysisMapper;

    @Autowired
    public StockAnalysisServiceImpl(StockAnalysisMapper stockAnalysisMapper) {
        this.stockAnalysisMapper = stockAnalysisMapper;
    }

    @Override
    public List<StockAnalysisResponseDTO> getStockAnalysisData(StockAnalysisRequestDTO requestDTO) {
        List<StockAnalysisResponseDTO> analysisData = stockAnalysisMapper.getStockAnalysisData(requestDTO);

        // 요청된 분석 항목에 따라 계산 로직을 수행합니다.
        for (StockAnalysisResponseDTO item : analysisData) {
            switch (requestDTO.getAnalysisItem()) {
                case "averageStock":
                    // 평균 재고량 = (기초 재고 + 기말 재고) / 2
                    if (item.getBeginningStock() != null && item.getEndingStock() != null) {
                        BigDecimal sum = item.getBeginningStock().add(item.getEndingStock());
                        BigDecimal average = sum.divide(new BigDecimal("2"), 2, RoundingMode.HALF_UP);
                        // DTO에 계산된 값을 임시로 저장하거나 새로운 DTO에 담아 반환
                        // (여기서는 DTO 필드를 재사용하는 것으로 가정합니다.)
                        // 실제로는 DTO에 별도의 분석 항목 필드를 추가하는 것이 좋습니다.
                        item.setBeginningStock(average);
                        item.setInboundQty(null);
                        item.setOutQty(null);
                        item.setEndingStock(null);
                    }
                    break;
                case "turnoverRate":
                    // 재고 회전율 = 매출 원가 / 평균 재고액
                    // 금액 기준일 경우
                    if (requestDTO.getStockStandard().equals("금액")) {
                        if (item.getInboundAmount() != null && item.getBeginningAmount() != null && item.getEndingAmount() != null) {
                            BigDecimal totalCost = item.getInboundAmount(); // 총입고금액을 매출원가로 간주
                            BigDecimal averageStockAmount = item.getBeginningAmount().add(item.getEndingAmount()).divide(new BigDecimal("2"), 2, RoundingMode.HALF_UP);
                            if (averageStockAmount.compareTo(BigDecimal.ZERO) != 0) {
                                BigDecimal turnoverRate = totalCost.divide(averageStockAmount, 2, RoundingMode.HALF_UP).multiply(new BigDecimal("100"));
                                // DTO 필드 재사용 (재고 회전율은 퍼센트 값)
                                item.setBeginningStock(turnoverRate);
                                item.setInboundQty(null);
                                item.setOutQty(null);
                                item.setEndingStock(null);
                            }
                        }
                    } else { // 수량 기준일 경우
                        if (item.getInboundQty() != null && item.getBeginningStock() != null && item.getEndingStock() != null) {
                            BigDecimal totalOutQty = item.getOutQty(); // 총출고량을 회전된 수량으로 간주
                            BigDecimal averageStockQty = item.getBeginningStock().add(item.getEndingStock()).divide(new BigDecimal("2"), 2, RoundingMode.HALF_UP);
                            if (averageStockQty.compareTo(BigDecimal.ZERO) != 0) {
                                BigDecimal turnoverRate = totalOutQty.divide(averageStockQty, 2, RoundingMode.HALF_UP).multiply(new BigDecimal("100"));
                                item.setBeginningStock(turnoverRate);
                                item.setInboundQty(null);
                                item.setOutQty(null);
                                item.setEndingStock(null);
                            }
                        }
                    }
                    break;
                case "totalInbound":
                    // 총 입고량 (이미 매퍼에서 계산됨)
                    item.setBeginningStock(item.getInboundQty());
                    item.setInboundQty(null);
                    item.setOutQty(null);
                    item.setEndingStock(null);
                    break;
                case "totalOutbound":
                    // 총 출고량 (이미 매퍼에서 계산됨)
                    item.setBeginningStock(item.getOutQty());
                    item.setInboundQty(null);
                    item.setOutQty(null);
                    item.setEndingStock(null);
                    break;
            }
        }
        return analysisData;
    }
}