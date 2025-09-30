package org.logistics.service;

import java.util.List;
import java.util.UUID;

import org.logistics.mapper.OtherTxnCategoryMapper;
import org.logistics.model.OtherTxnCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OtherTxnCategoryServiceImpl implements OtherTxnCategoryService {

    @Autowired
    private OtherTxnCategoryMapper mapper;

    @Override
    public List<OtherTxnCategory> getList(String txnType) {
        return mapper.getList(txnType);
    }

    @Transactional
    @Override
    public void saveOrUpdate(OtherTxnCategory category) {
        if (category.getCategoryName() == null || category.getCategoryName().trim().isEmpty()) {
            throw new IllegalArgumentException("CATEGORY_NAME 필수");
        }

        if (category.getTxnCode() == null || category.getTxnCode().isEmpty()) {
            String newCode = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
            category.setTxnCode(category.getTxnType() + newCode);
            category.setBuId(1);
            category.setUseYn("Y");
            mapper.insert(category);
        } else {
            mapper.update(category);
        }
    }

    @Override
    public void register(OtherTxnCategory category) {
        category.setUseYn("Y");
        mapper.insert(category);
    }

    @Override
    public void modify(OtherTxnCategory category) {
        mapper.update(category);
    }

    @Override
    public void delete(String txnCode, int buId) {
        mapper.delete(txnCode, buId);
    }
}
