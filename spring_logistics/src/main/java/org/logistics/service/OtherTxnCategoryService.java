package org.logistics.service;

import java.util.List;
import org.logistics.model.OtherTxnCategory;

public interface OtherTxnCategoryService {

    /** ================== 基本照会 (기본 조회) ================== */
    List<OtherTxnCategory> getList(String txnType);
    // ✅ 取引タイプ別の区分一覧取得 / 거래 유형별 구분 목록 조회


    /** ================== 登録・更新 (등록 및 수정) ================== */

    void register(OtherTxnCategory category);
    // ✅ 区分マスタ新規登録 / 구분 마스터 신규 등록

    void modify(OtherTxnCategory category);
    // ✅ 区分マスタ修正 / 구분 마스터 수정


    /** ================== 削除 (삭제) ================== */
    void delete(String txnCode, int buId);
    // ✅ 区分マスタ削除 / 구분 마스터 삭제


    /** ================== 登録または更新 (등록 또는 수정 통합) ================== */
    void saveOrUpdate(OtherTxnCategory category);
    // ✅ 登録または更新を自動判別して処理 / 신규 또는 수정 여부를 자동 판별하여 처리
}
