package org.logistics.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OutboundVO {
	private String outboundType;
	private Integer outboundQty;
	private Integer outboundDetailId;
	private Date outboundDate;
	private String note;
	private int itemId;
	private String outboundComplete;
}
