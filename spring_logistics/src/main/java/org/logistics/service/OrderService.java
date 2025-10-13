package org.logistics.service;

import java.util.List;

import org.logistics.domain.BusinessUnitVO;
import org.logistics.domain.OrderDTO;
import org.logistics.domain.OrderDetailDTO;

public interface OrderService {

    /** ================== CRUD 操作 (기본 CRUD 기능: inbound_master 기준) ================== */

    void saveOrder(OrderDTO orderDTO);  
    // ✅ 受注登録 (insert) / 수주 등록 (inbound_master INSERT)

    OrderDTO getOrder(String buId, String orderId);  
    // ✅ 受注単件照会 / 수주 단건 조회 (사업부ID + 수주ID 기준)

    void updateOrder(OrderDTO orderDTO);  
    // ✅ 受注情報更新 / 수주 정보 수정 (inbound_master UPDATE)

    void deleteOrder(String buId, String orderId);  
    // ✅ 受注削除 / 수주 삭제 (inbound_master DELETE)

    public List<OrderDetailDTO> getOrderList(String buId, String orderId);
    // ✅ 受注明細リスト照会 / 수주 상세 리스트 조회


    /** ================== inbound_master 関連 (입고/수주 마스터 관련) ================== */

    List<String> getInboundTypeList();             
    // ✅ 入庫タイプ一覧(全件) / 수주 구분 전체 조회

    List<String> getInboundTypeList(String buId);  
    // ✅ 事業部別入庫タイプ一覧 / 사업부별 수주 구분 조회

    List<OrderDTO> getOrdersByInboundType(String buId, String inboundType); 
    // ✅ タイプ別受注検索 / 구분별 수주 목록 조회


    /** ================== 共通マスタ参照 (공통 마스터 조회) ================== */

    List<BusinessUnitVO> getBusinessUnitList();  
    // ✅ 事業部一覧 / 사업단위 목록 조회

    List<String> getInboundTypeDropDown();  
    // ✅ 入庫タイプドロップダウン用 / 수주 구분 콤보박스용 데이터

    List<String> getLocalFlagList();  
    // ✅ ローカル区分一覧 / 내수·수출 구분 목록

    List<String> getConsignmentList();  
    // ✅ 委託区分一覧 / 위탁 구분 목록

    List<String> getCurrencyList();  
    // ✅ 通貨コード一覧 / 통화 코드 목록


    /** ================== 検索機能 (검색 기능) ================== */
    List<OrderDTO> searchOrders(
            String buId,
            String inboundType,
            String localFlag,
            String startDate,
            String endDate,
            String partyId,
            String contactId
    );
    // ✅ 条件検索(事業部, 区分, 期間) / 조건 검색 (사업부, 구분, 기간 등)


    /** ================== 詳細・マスタ連携 (상세 및 마스터 연계) ================== */

    List<OrderDetailDTO> getOrderDetails(String buId, String orderId);
    // ✅ 品目詳細照会 / 품목 상세 조회 (item_master + inbound_detail + inbound_master JOIN)

    List<OrderDetailDTO> getItemMasterByBuId(String buId);
    // ✅ 品目マスタ一覧 / 사업부별 품목 마스터 조회 (그리드 기본 데이터)
}
