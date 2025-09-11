//package org.logistics.controller;
//
//import org.logistics.model.OrderDTO;
//import org.logistics.service.OrderService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//@Controller
//@RequestMapping("/order")
//public class OrderController {
//
//    // ✅ Service 주입
//    private final OrderService orderService;
//
//    @Autowired
//    public OrderController(OrderService orderService) {
//        this.orderService = orderService;
//    }
//
//    // 수주 입력 메인
//    @GetMapping("/entry")
//    public String orderEntry() {
//        return "order/orderEntry";  // /WEB-INF/spring/views/order/orderEntry.jsp
//    }
//
//    // 구매요청
//    @GetMapping("/purchaseRequest")
//    public String purchaseRequest() {
//        return "order/purchaseRequest";
//    }
//
//    // 생산의뢰
//    @GetMapping("/productionRequest")
//    public String productionRequest() {
//        return "order/productionRequest";
//    }
//
//    // 거래명세서
//    @GetMapping("/transactionSlip")
//    public String transactionSlip() {
//        return "order/transactionSlip";
//    }
//    
//    // 저장 API
//    @PostMapping("/save")
//    @ResponseBody
//    public ResponseEntity<String> saveOrder(@RequestBody OrderDTO orderDTO) {
//        orderService.saveOrder(orderDTO);
//        return ResponseEntity.ok("success");
//    }
//}
