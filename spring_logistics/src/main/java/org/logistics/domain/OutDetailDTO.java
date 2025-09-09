package org.logistics.domain;

import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;

@Data
public class OutDetailDTO {
    private Long outDetailId;
    private Long itemId;
    private BigDecimal qty;
    private BigDecimal unitPrice;
    private BigDecimal amount;
    private String specialNote;
    private String lotNo;
    private String otherOutCode;
    private char isChargeSupply;
    private String assetClass;
    private String assetProcType;
    private Date createdAt;
    private String currencyCode;
    private BigDecimal exchangeRate;
}