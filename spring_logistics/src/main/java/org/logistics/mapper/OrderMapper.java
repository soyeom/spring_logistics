//package org.logistics.mapper;
//
//import java.util.List;
//
//import org.apache.ibatis.annotations.Mapper;
//import org.logistics.model.OrderDTO;
//import org.logistics.model.OrderDetailDTO;
//
//@Mapper
//public interface OrderMapper {
//
//    void insertOrder(OrderDTO order);
//    void updateOrder(OrderDTO order);
//    void deleteOrder(Long orderId);
//
//    void insertOrderDetail(Long orderId, OrderDetailDTO detail);
//    void deleteOrderDetails(Long orderId);
//
//    OrderDTO selectOrder(Long orderId);
//    List<OrderDTO> selectOrderList(Long buId);
//}
