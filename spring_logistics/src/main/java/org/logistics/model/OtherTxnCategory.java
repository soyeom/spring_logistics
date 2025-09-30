package org.logistics.model;

import java.util.Date;

import lombok.Data;

@Data
public class OtherTxnCategory {
    private String txnCode;
    private Integer buId;
    private String txnType;
    private String categoryName;
    private Integer sortOrder;
    private String useYn;

    private String accountSubject;
    private String costType;

    private String isFinishedProduct;
    private String isMaterial;
    private String isSalesUse;
    private String adjustOut;
    private String adjustIn;

    private String isVatTarget;
    private String vatProcessType;
    private String isAs;
    private String isItemJournal;

    private String isByproductIn;
    private String isReturnIn;

    private String isMove;
    private String isTransfer;
    private String isAsOut;
    private String isAsReturn;
    private String isFreeSupply;
    private String isDispatchTarget;

    private String description;
    private Date createdAt;
}
