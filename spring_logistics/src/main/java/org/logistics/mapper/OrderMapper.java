package org.logistics.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.logistics.model.BusinessUnitVO;
import org.logistics.model.OrderDTO;
import org.logistics.model.OrderDetailDTO;

@Mapper
public interface OrderMapper {

    // ================== 마스터 ==================
    void insertOrder(OrderDTO order);

    OrderDTO selectOrder(
        @Param("orderId") String orderId,
        @Param("buId") String buId
    );

    void updateOrder(OrderDTO order);

    void deleteOrder(
        @Param("orderId") String orderId,
        @Param("buId") String buId
    );

    List<String> getInboundTypeList();
    List<String> getInboundTypeListByBuId(@Param("buId") String buId);

    List<OrderDTO> getOrdersByInboundType(
        @Param("buId") String buId,
        @Param("inboundType") String inboundType
    );

    List<OrderDTO> searchOrders(
        @Param("buId") String buId,
        @Param("inboundType") String inboundType,
        @Param("localFlag") String localFlag,
        @Param("startDate") String startDate,
        @Param("endDate") String endDate
    );

    // ================== 디테일 ==================
    void insertOrderDetail(OrderDetailDTO detail);

    /** buId + orderId 기반 상세 조회 */
    List<OrderDetailDTO> selectOrderDetails(
        @Param("orderId") String orderId,
        @Param("buId") String buId
    );

    /** buId + orderId 기반 삭제 */
    void deleteOrderDetails(
        @Param("orderId") String orderId,
        @Param("buId") String buId
    );

    /** buId 기준 Item Master 조회 (그리드 뼈대) */
    List<OrderDetailDTO> selectItemMasterByBuId(@Param("buId") String buId);

    // ================== 공통 ==================
    List<BusinessUnitVO> getBusinessUnitList();
    List<String> getLocalFlagList();
    List<String> getConsignmentList();
    List<String> getCurrencyList();
    
    public List<OrderDetailDTO> getOrderList(@Param ("buId") String buId, @Param ("orderId") String orderId);
}
