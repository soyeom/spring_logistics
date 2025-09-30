package org.logistics.service;

import java.util.List;
import org.logistics.model.*;

public interface OrderService {

    // ================== CRUD (inbound_master 기준) ==================
    void saveOrder(OrderDTO orderDTO);  // inbound_master insert
    OrderDTO getOrder(String buId, String orderId);  // inbound_master 단건조회
    void updateOrder(OrderDTO orderDTO);  // inbound_master update
    void deleteOrder(String buId, String orderId);  // inbound_master delete

    public List<OrderDetailDTO> getOrderList(String buId, String orderId);
    

    // ================== inbound_master ==================
    List<String> getInboundTypeList();             // 전체 조회 (수주구분)
    List<String> getInboundTypeList(String buId);  // buId별 조회
    List<OrderDTO> getOrdersByInboundType(String buId, String inboundType); // 조건 조회

    // ================== 공통 조회 ==================
    List<BusinessUnitVO> getBusinessUnitList();
    List<String> getInboundTypeDropDown(); // ✅ 수정: OrderTypeVO 대신 inboundType 전용
    List<String> getLocalFlagList();
    List<String> getConsignmentList();
    List<String> getCurrencyList();

    // ================== 검색 ==================
    List<OrderDTO> searchOrders(
            String buId,
            String inboundType,
            String localFlag,
            String startDate,
            String endDate
    );

    // ================== 신규 추가 ==================
    /** 품목 상세조회 (item_master + inbound_detail + inbound_master) */
    List<OrderDetailDTO> getOrderDetails(String buId, String orderId);

    /** Item Master 기준 품목 목록 조회 (그리드 기본 뼈대) */
    List<OrderDetailDTO> getItemMasterByBuId(String buId);
}
