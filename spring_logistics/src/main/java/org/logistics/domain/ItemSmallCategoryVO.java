package org.logistics.domain;

import lombok.Data;

@Data
public class ItemSmallCategoryVO {

    private String smallCategory;     // item_master.small_category
    private String personalIdNo;      // party.personal_id_no
    private String bigCategory;       // item_master.big_category
    private String midCategory;       // item_master.mid_category
}
