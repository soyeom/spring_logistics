package org.logistics.service;

import java.util.List;

import org.logistics.model.OtherTxnCategory;

public interface OtherTxnCategoryService {
    List<OtherTxnCategory> getList(String txnType);

    // 기존 메소드 유지
    void register(OtherTxnCategory category);
    void modify(OtherTxnCategory category);

    //
    void delete(String txnCode, int buId);

    // ✅ 신규 추가
    
    void saveOrUpdate(OtherTxnCategory category);
    
}
