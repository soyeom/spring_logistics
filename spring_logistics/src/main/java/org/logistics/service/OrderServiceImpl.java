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

    // ================== CRUD ==================
    @Override
    @Transactional
    public void saveOrder(OrderDTO orderDTO) {
        // 1. 마스터 저장
        orderMapper.insertOrder(orderDTO);

        // 2. 디테일 저장
        if (orderDTO.getDetails() != null) {
            for (OrderDetailDTO detail : orderDTO.getDetails()) {
                detail.setInboundId(orderDTO.getOrderId()); // FK 연결
                detail.setBuId(orderDTO.getBuId());
                orderMapper.insertOrderDetail(detail);
            }
        }
    }

    @Override
	public List<OrderDetailDTO> getOrderList(String buId, String orderId) {
		
    	return orderMapper.getOrderList(buId, orderId);
	}

	@Override
    public OrderDTO getOrder(String buId, String orderId) {
        OrderDTO order = orderMapper.selectOrder(orderId, buId);
        if (order != null) {
            // buId + orderId 기반 상세조회
            order.setDetails(orderMapper.selectOrderDetails(orderId, buId));
        }
        return order;
    }

    @Override
    @Transactional
    public void updateOrder(OrderDTO orderDTO) {
        // 1. 마스터 수정
        orderMapper.updateOrder(orderDTO);

        // 2. 기존 디테일 삭제 후 재등록
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
        // 디테일 먼저 삭제
        orderMapper.deleteOrderDetails(orderId, buId);

        // 마스터 삭제
        orderMapper.deleteOrder(orderId, buId);
    }

    // ================== inbound_master ==================
    @Override
    public List<String> getInboundTypeList() {
        return orderMapper.getInboundTypeList();
    }

    @Override
    public List<String> getInboundTypeList(String buId) {
        return orderMapper.getInboundTypeListByBuId(buId);
    }

    @Override
    public List<OrderDTO> getOrdersByInboundType(String buId, String inboundType) {
        List<OrderDTO> orders = orderMapper.getOrdersByInboundType(buId, inboundType);
        for (OrderDTO order : orders) {
            order.setDetails(orderMapper.selectOrderDetails(order.getOrderId(), buId));
        }
        return orders;
    }

    // ================== 공통 조회 ==================
    @Override
    public List<BusinessUnitVO> getBusinessUnitList() {
        return orderMapper.getBusinessUnitList();
    }

    @Override
    public List<String> getInboundTypeDropDown() {
        return orderMapper.getInboundTypeList();
    }

    @Override
    public List<String> getLocalFlagList() {
        return orderMapper.getLocalFlagList();
    }

    @Override
    public List<String> getConsignmentList() {
        return orderMapper.getConsignmentList();
    }

    @Override
    public List<String> getCurrencyList() {
        return orderMapper.getCurrencyList();
    }

    // ================== 검색 ==================
    @Override
    public List<OrderDTO> searchOrders(String buId, String inboundType, String localFlag, String startDate, String endDate) {
        List<OrderDTO> orders = orderMapper.searchOrders(buId, inboundType, localFlag, startDate, endDate);
        for (OrderDTO order : orders) {
            order.setDetails(orderMapper.selectOrderDetails(order.getOrderId(), buId));
        }
        return orders;
    }

    // ================== 신규 추가 ==================
    @Override
    public List<OrderDetailDTO> getOrderDetails(String buId, String orderId) {
        return orderMapper.selectOrderDetails(orderId, buId);
    }

    @Override
    public List<OrderDetailDTO> getItemMasterByBuId(String buId) {
        return orderMapper.selectItemMasterByBuId(buId);
    }
    
    
}
