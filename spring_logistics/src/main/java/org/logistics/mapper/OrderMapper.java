package org.logistics.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.logistics.model.BusinessUnitVO;
import org.logistics.model.OrderDTO;
import org.logistics.model.OrderDetailDTO;

@Mapper
public interface OrderMapper {

    // ================== マスタ処理 (수주 마스터 관련) ==================

    /** ✅ 受注マスタを新規登録する  
     * → 수주 마스터 데이터를 신규로 등록한다.
     */
    void insertOrder(OrderDTO order);

    /** ✅ 受注マスタを1件取得する  
     * → buId와 orderId 기준으로 단건 수주 마스터를 조회한다.
     */
    OrderDTO selectOrder(
        @Param("orderId") String orderId,
        @Param("buId") String buId
    );

    /** ✅ 受注マスタを更新する  
     * → 수주 마스터 데이터를 수정한다.
     */
    void updateOrder(OrderDTO order);

    /** ✅ 受注マスタを削除する  
     * → buId와 orderId 기준으로 수주 마스터를 삭제한다.
     */
    void deleteOrder(
        @Param("orderId") String orderId,
        @Param("buId") String buId
    );

    /** ✅ 入庫タイプ一覧を取得 (全体)  
     * → 전체 사업부 기준 입고유형 리스트를 조회한다.
     */
    List<String> getInboundTypeList();

    /** ✅ 事業部別の入庫タイプ一覧を取得  
     * → buId 기준으로 입고유형 리스트를 조회한다.
     */
    List<String> getInboundTypeListByBuId(@Param("buId") String buId);

    /** ✅ 入庫タイプ別の受注リストを取得  
     * → buId와 inboundType 기준으로 수주 목록을 조회한다.
     */
    List<OrderDTO> getOrdersByInboundType(
        @Param("buId") String buId,
        @Param("inboundType") String inboundType
    );

    /** ✅ 条件による受注リスト検索  
     * → 사업부, 입고유형, 내수/수출, 기간 등을 조건으로 수주리스트 검색
     */
    List<OrderDTO> searchOrders(
        @Param("buId") String buId,
        @Param("inboundType") String inboundType,
        @Param("localFlag") String localFlag,
        @Param("startDate") String startDate,
        @Param("endDate") String endDate,
        @Param("partyId") String partyId,
        @Param("contactId") String contactId
        
    );


    // ================== ディテール処理 (수주 상세 관련) ==================

    /** ✅ 受注明細を登録する  
     * → 수주 상세 데이터를 등록한다.
     */
    void insertOrderDetail(OrderDetailDTO detail);

    /** ✅ 受注明細を取得する  
     * → buId + orderId 기준으로 수주 상세 내역을 조회한다.
     */
    List<OrderDetailDTO> selectOrderDetails(
        @Param("orderId") String orderId,
        @Param("buId") String buId
    );

    /** ✅ 受注明細を削除する  
     * → buId + orderId 기준으로 상세 내역을 삭제한다.
     */
    void deleteOrderDetails(
        @Param("orderId") String orderId,
        @Param("buId") String buId
    );

    /** ✅ 品目マスタを事業部単位で取得する  
     * → buId 기준으로 품목 마스터를 조회 (그리드 표시용)
     */
    List<OrderDetailDTO> selectItemMasterByBuId(@Param("buId") String buId);


    // ================== 共通処理 (공통 코드 조회) ==================

    /** ✅ 事業部リストを取得する / 사업부 리스트 조회 */
    List<BusinessUnitVO> getBusinessUnitList();

    /** ✅ Local区分リストを取得する / 내수·수출 구분 리스트 조회 */
    List<String> getLocalFlagList();

    /** ✅ 委託区分リストを取得する / 위탁 구분 리스트 조회 */
    List<String> getConsignmentList();

    /** ✅ 通貨リストを取得する / 통화 리스트 조회 */
    List<String> getCurrencyList();


    // ================== 補助関数 ==================

    /** ✅ buId + orderId 기준 受注明細リストを取得  
     * → buId 및 orderId 기준으로 수주 상세 리스트를 조회한다.
     */
    List<OrderDetailDTO> getOrderList(
        @Param("buId") String buId,
        @Param("orderId") String orderId
    );
}
