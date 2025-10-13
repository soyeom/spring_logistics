package org.logistics.domain;

import lombok.Data;

@Data
public class BusinessUnitDTO {
    private Long id;   // DB business_unit.bu_id와 매핑
    private String name; // DB business_unit.bu_name와 매핑
}