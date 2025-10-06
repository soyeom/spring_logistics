package org.logistics.controller;

import java.util.List;

import org.logistics.model.BusinessUnitVO;
import org.logistics.model.OrderDTO;
import org.logistics.model.OrderDetailDTO;
import org.logistics.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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

    /** ================== 수주 입력 화면 (JSP) ================== */
    @GetMapping("/entry")
    public String orderEntry(Model model,
                             @RequestParam(required = false) String buId) {

        // ✅ 공통 셀렉트박스 데이터
        List<BusinessUnitVO> buList = orderService.getBusinessUnitList();
        List<String> localFlagList = orderService.getLocalFlagList();
        List<String> consignmentList = orderService.getConsignmentList();
        List<String> currencyList = orderService.getCurrencyList();

        model.addAttribute("buList", buList);
        model.addAttribute("localFlagList", localFlagList);
        model.addAttribute("consignmentList", consignmentList);
        model.addAttribute("currencyList", currencyList);

        // ✅ inboundType 은 buId 여부에 따라 조회
        if (buId != null && !buId.isEmpty()) {
            model.addAttribute("inboundTypeList", orderService.getInboundTypeList(buId));
        } else {
            model.addAttribute("inboundTypeList", orderService.getInboundTypeList());
        }

        // ✅ 뷰 이름을 명시적으로 지정
        return "order/orderEntry";   // /WEB-INF/views/order/orderEntry.jsp
    }

    /** ================== 단건 조회 (JSON) ================== */
//    @GetMapping("/{buId}/{orderId}")
//    @ResponseBody
//    public ResponseEntity<OrderDTO> getOrder(@PathVariable String buId,
//                                             @PathVariable String orderId) {
//        OrderDTO order = orderService.getOrder(buId, orderId);
//        if (order == null) {
//            return ResponseEntity.notFound().build();
//        }
//        order.setDetails(orderService.getOrderDetails(buId, orderId));
//        return ResponseEntity.ok(order);
//    }
 // 단건 조회 (GET /order/{buId}/{orderId})
    @GetMapping("/in_detail_list")
    @ResponseBody
    public List<OrderDetailDTO> inBoundDetailSearch(@RequestParam("buId") String buId, @RequestParam("orderId") String orderId) {
       
		return orderService.getOrderList(buId, orderId);
		
       // return invFlowConfigService.getOutBoundDetail2(bu_Id, out_Id);
    }
//    @GetMapping("/{buId}/{orderId}")
//    @ResponseBody
//    public OrderDTO getOrder(@PathVariable String buId,
//                             @PathVariable String orderId) {
//        OrderDTO order = orderService.getOrder(buId, orderId);
//        if (order != null) {
//            order.setDetails(orderService.getOrderDetails(buId, orderId));
//        }
//        return order;
//    }

    /** ================== 검색 조회 (JSON) ================== */
//    @GetMapping("/search")
//    @ResponseBody
//    public List<OrderDTO> searchOrders(
//            @RequestParam(required = false) String buId,
//            @RequestParam(required = false) String inboundType,
//            @RequestParam(required = false) String localFlag,
//            @RequestParam(required = false) String startDate,
//            @RequestParam(required = false) String endDate
//    ) {
//        return orderService.searchOrders(buId, inboundType, localFlag, startDate, endDate);
//    }
    @GetMapping("/search")
    @ResponseBody
    public List<OrderDTO> searchOrders(
            @RequestParam(required = false) String buId,
            @RequestParam(required = false) String inboundType,
            @RequestParam(required = false) String localFlag,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate
    ) {
        List<OrderDTO> orders = orderService.searchOrders(buId, inboundType, localFlag, startDate, endDate);

        // ✅ 각 order에 details 주입
        for (OrderDTO order : orders) {
            order.setDetails(orderService.getOrderDetails(order.getBuId(), order.getOrderId()));
        }

        return orders;
    }

    /** ================== Item Master 조회 (JSON) ================== */
    @GetMapping("/items/{buId}")
    @ResponseBody
    public List<OrderDetailDTO> getItemMaster(@PathVariable String buId) {
        return orderService.getItemMasterByBuId(buId);
    }


}
