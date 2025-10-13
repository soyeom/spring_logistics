package org.logistics.domain;

import java.util.Date;

import lombok.Data;

@Data
public class InboundVO {
	private String inboundType;
	private int itemId;
	private Integer inboundQty;
	private Integer inboundDetailId;
	private Date inboundDate;
	private String note;
}
