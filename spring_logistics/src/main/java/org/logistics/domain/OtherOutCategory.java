package org.logistics.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OtherOutCategory {

    private String otherOutCode;
    private Long buId;
    private String categoryName;
    private String description;
    private char useYn;
    private Date createdAt;
}