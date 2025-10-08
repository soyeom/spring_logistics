package org.logistics.controller;

import java.util.List;

import org.logistics.model.BusinessUnitVO;
import org.logistics.model.OrderDTO;
import org.logistics.model.OrderDetailDTO;
import org.logistics.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/order")
public class OrderController {

    private final OrderService orderService;

    @Autowired
    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    /** ================== 수주 입력 화면 (JSP) ==================
     * ✅ 受注入力画面 (JSP)
     * → 수주 입력 페이지를 표시하며, 공통 셀렉트박스 데이터를 모델에 추가한다.
     */
    @GetMapping("/entry")
    public String orderEntry(Model model,
                             @RequestParam(required = false) String buId) {

        // ✅ 共通セレクトボックスデータ / 공통 셀렉트박스 데이터 조회
        List<BusinessUnitVO> buList = orderService.getBusinessUnitList();
        List<String> localFlagList = orderService.getLocalFlagList();
        List<String> consignmentList = orderService.getConsignmentList();
        List<String> currencyList = orderService.getCurrencyList();

        // ✅ モデルにデータを追加 / 모델에 데이터 추가
        model.addAttribute("buList", buList);
        model.addAttribute("localFlagList", localFlagList);
        model.addAttribute("consignmentList", consignmentList);
        model.addAttribute("currencyList", currencyList);

        // ✅ inboundType は buId の有無により取得 / buId 여부에 따라 inboundType 조회
        if (buId != null && !buId.isEmpty()) {
            model.addAttribute("inboundTypeList", orderService.getInboundTypeList(buId));
        } else {
            model.addAttribute("inboundTypeList", orderService.getInboundTypeList());
        }

        // ✅ ビュー名を明示的に指定 / 뷰 이름 명시적 지정
        return "order/orderEntry";   // /WEB-INF/views/order/orderEntry.jsp
    }


    /** ================== 단건 조회 ==================
     * ✅ 単一受注の詳細照会
     * (GET /order/in_detail_list?buId=...&orderId=...)
     * → buId 및 orderId로 해당 수주의 상세 데이터를 조회
     */
    @GetMapping("/in_detail_list")
    @ResponseBody
    public List<OrderDetailDTO> inBoundDetailSearch(
            @RequestParam("buId") String buId,
            @RequestParam("orderId") String orderId) {
       
        // ✅ サービス層から受注詳細リストを取得 / 서비스 계층에서 수주 상세리스트 조회
        return orderService.getOrderList(buId, orderId);
    }


    /** ================== 수주 목록 조회 ==================
     * ✅ 受注明細リストの検索処理
     * (GET /order/search)
     * → 필터 조건(buId, inboundType, localFlag, 기간 등)에 따라 수주 목록 검색
     */
    @GetMapping("/search")
    @ResponseBody
    public List<OrderDTO> searchOrders(
            @RequestParam(required = false) String buId,
            @RequestParam(required = false) String inboundType,
            @RequestParam(required = false) String localFlag,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            @RequestParam(required = false) String partyId,
            @RequestParam(required = false) String contactId
    ) {
        // ✅ 条件により受注リストを取得 / 조건에 맞는 수주 리스트 조회
        List<OrderDTO> orders = orderService.searchOrders(buId, inboundType, localFlag, startDate, endDate, partyId, contactId);

        // ✅ 各Orderに明細情報を注入 / 각 수주 객체에 상세 리스트 주입
        for (OrderDTO order : orders) {
            order.setDetails(orderService.getOrderDetails(order.getBuId(), order.getOrderId()));
        }

        // ✅ JSON形式で返却 / JSON 형식으로 반환
        return orders;
    }


    /** ================== 품목 마스터 조회 ==================
     * ✅ 品目マスタ情報の取得
     * (GET /order/items/{buId})
     * → 사업부 ID 기준으로 품목 마스터 조회
     */
    @GetMapping("/items/{buId}")
    @ResponseBody
    public List<OrderDetailDTO> getItemMaster(@PathVariable String buId) {
        // ✅ サービス層から品目マスタを取得 / 서비스 계층에서 품목 마스터 조회
        return orderService.getItemMasterByBuId(buId);
    }

}
