package org.logistics.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.logistics.model.OtherTxnCategory;

@Mapper
public interface OtherTxnCategoryMapper {
    List<OtherTxnCategory> getList(@Param("txnType") String txnType);

    String getNextTxnCode(@Param("txnType") String txnType, @Param("buId") int buId);

    void insert(OtherTxnCategory category);

    void update(OtherTxnCategory category);

    void delete(@Param("txnCode") String txnCode, @Param("buId") int buId);
}
