package org.logistics.model;

import java.util.List;
import lombok.Data;

@Data
public class OrderDTO {
    private String orderId;          // inbound_id
    private String buId;             // 사업단위
    private String inboundDate;      // 납기일 (dueDate -> inbound_date)
    private String localFlag;        // Local 구분
    private String inboundType;      // 수주구분 (orderType -> inbound_type)
    private String inboundComplete;  // 입고상태 (Y/N)
    private String createdAt;        // 생성일자

    // 외래키
    private String partyId;        // 거래처ID
    private String contactId;        // 담당자ID

    // 뷰 전용 (JOIN 결과)
    private String partyName;        // 거래처명
    private String contactName;      // 담당자명
    private String department;       // 부서

    // 환율
    private String currencyCode;     // currency_rate.currency_code
    private String exchangeRate;     // 환율 (1 USD = 1300.0)

    private List<OrderDetailDTO> details; // 디테일
}
