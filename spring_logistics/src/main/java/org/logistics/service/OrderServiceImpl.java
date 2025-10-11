package org.logistics.service;

import java.util.List;

import org.logistics.mapper.OrderMapper;
import org.logistics.model.BusinessUnitVO;
import org.logistics.model.OrderDTO;
import org.logistics.model.OrderDetailDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    /** ================== CRUD 処理 (기본 CRUD 처리) ================== */

    @Override
    @Transactional
    public void saveOrder(OrderDTO orderDTO) {
        // ✅ 【1】マスタ登録 / 마스터 저장 (inbound_master)
        orderMapper.insertOrder(orderDTO);

        // ✅ 【2】ディテール登録 / 디테일 저장 (inbound_detail)
        if (orderDTO.getDetails() != null) {
            for (OrderDetailDTO detail : orderDTO.getDetails()) {
                detail.setInboundId(orderDTO.getOrderId()); // 🔹 外部キー設定 / FK 연결
                detail.setBuId(orderDTO.getBuId());
                orderMapper.insertOrderDetail(detail);
            }
        }
    }

    @Override
    public List<OrderDetailDTO> getOrderList(String buId, String orderId) {
        // ✅ 受注明細一覧取得 / 수주 상세 리스트 조회
        return orderMapper.getOrderList(buId, orderId);
    }

    @Override
    public OrderDTO getOrder(String buId, String orderId) {
        // ✅ 単件受注照会 / 단건 수주 조회
        OrderDTO order = orderMapper.selectOrder(orderId, buId);
        if (order != null) {
            // 🔹 子テーブル(ディテール)を結合 / 자식 테이블(상세) 조인
            order.setDetails(orderMapper.selectOrderDetails(orderId, buId));
        }
        return order;
    }

    @Override
    @Transactional
    public void updateOrder(OrderDTO orderDTO) {
        // ✅ 【1】マスタ更新 / 마스터 수정
        orderMapper.updateOrder(orderDTO);

        // ✅ 【2】既存ディテール削除後、再登録 / 기존 디테일 삭제 후 재등록
        orderMapper.deleteOrderDetails(orderDTO.getOrderId(), orderDTO.getBuId());

        if (orderDTO.getDetails() != null) {
            for (OrderDetailDTO detail : orderDTO.getDetails()) {
                detail.setInboundId(orderDTO.getOrderId());
                detail.setBuId(orderDTO.getBuId());
                orderMapper.insertOrderDetail(detail);
            }
        }
    }

    @Override
    @Transactional
    public void deleteOrder(String buId, String orderId) {
        // ✅ 【1】ディテール削除 / 디테일 먼저 삭제
        orderMapper.deleteOrderDetails(orderId, buId);

        // ✅ 【2】マスタ削除 / 마스터 삭제
        orderMapper.deleteOrder(orderId, buId);
    }

    /** ================== inbound_master 関連 (입고 마스터 관련) ================== */
    @Override
    public List<String> getInboundTypeList() {
        // ✅ 入庫区分一覧(全件) / 입고 구분 전체 조회
        return orderMapper.getInboundTypeList();
    }

    @Override
    public List<String> getInboundTypeList(String buId) {
        // ✅ 事業部別入庫区分一覧 / 사업부별 입고 구분 조회
        return orderMapper.getInboundTypeListByBuId(buId);
    }

    @Override
    public List<OrderDTO> getOrdersByInboundType(String buId, String inboundType) {
        // ✅ 入庫区分別受注検索 / 입고구분별 수주 검색
        List<OrderDTO> orders = orderMapper.getOrdersByInboundType(buId, inboundType);
        for (OrderDTO order : orders) {
            order.setDetails(orderMapper.selectOrderDetails(order.getOrderId(), buId)); // 子データ設定 / 자식 데이터 설정
        }
        return orders;
    }

    /** ================== 共通マスタ参照 (공통 마스터 조회) ================== */
    @Override
    public List<BusinessUnitVO> getBusinessUnitList() {
        // ✅ 事業部一覧 / 사업부 목록 조회
        return orderMapper.getBusinessUnitList();
    }

    @Override
    public List<String> getInboundTypeDropDown() {
        // ✅ 入庫区分ドロップダウン用 / 입고 구분 드롭다운용
        return orderMapper.getInboundTypeList();
    }

    @Override
    public List<String> getLocalFlagList() {
        // ✅ ローカル区分一覧 / 내수·수출 구분 목록
        return orderMapper.getLocalFlagList();
    }

    @Override
    public List<String> getConsignmentList() {
        // ✅ 委託区分一覧 / 위탁 구분 목록
        return orderMapper.getConsignmentList();
    }

    @Override
    public List<String> getCurrencyList() {
        // ✅ 通貨コード一覧 / 통화 코드 목록
        return orderMapper.getCurrencyList();
    }

    /** ================== 検索機能 (검색 기능) ================== */
    @Override
    public List<OrderDTO> searchOrders(String buId, String inboundType, String localFlag, String startDate, String endDate, String partyId, String contactId) {
        // ✅ 条件検索(事業部, 区分, 期間) / 조건 검색 (사업부, 구분, 기간)
        List<OrderDTO> orders = orderMapper.searchOrders(buId, inboundType, localFlag, startDate, endDate, partyId, contactId);
        for (OrderDTO order : orders) {
            order.setDetails(orderMapper.selectOrderDetails(order.getOrderId(), buId)); // ディテール結合 / 상세 결합
        }
        return orders;
    }

    /** ================== 明細・マスタ連携 (상세 및 마스터 연계) ================== */
    @Override
    public List<OrderDetailDTO> getOrderDetails(String buId, String orderId) {
        // ✅ 品目詳細照会 / 품목 상세 조회
        return orderMapper.selectOrderDetails(orderId, buId);
    }

    @Override
    public List<OrderDetailDTO> getItemMasterByBuId(String buId) {
        // ✅ 事業部別品目マスタ取得 / 사업부별 품목 마스터 조회
        return orderMapper.selectItemMasterByBuId(buId);
    }
}
