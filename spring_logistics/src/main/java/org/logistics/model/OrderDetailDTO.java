//package org.logistics.model;
//
//import java.math.BigDecimal;
//import java.util.Date;
//
//import lombok.Data;
//
//@Data
//public class OrderDetailDTO {
//    private Long detailId;      // 수주 상세 ID (PK)
//    private Long orderId;       // 수주 ID (FK → OrderDTO)
//    private Long itemId;        // 품목 ID (item_master 참조)
//    private String itemName;    // 품목명 (조인용)
//    private BigDecimal qty;     // 수량
//    private BigDecimal unitPrice; // 단가
//    private BigDecimal amount;    // 금액 (qty * unitPrice)
//    private String currency;      // 통화
//    private Date createdAt;       // 생성일시
//}
