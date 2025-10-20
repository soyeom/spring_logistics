package org.logistics.service;

import java.util.List;
import java.util.UUID;

import org.logistics.domain.OtherTxnCategory;
import org.logistics.mapper.OtherTxnCategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OtherTxnCategoryServiceImpl implements OtherTxnCategoryService {

    @Autowired
    private OtherTxnCategoryMapper mapper;

    /** ================== 一覧照会 (리스트 조회) ================== */
    @Override
    public List<OtherTxnCategory> getList(String txnType) {
        // ✅ 取引タイプ別区分一覧を取得 / 거래유형별 구분 목록 조회
        return mapper.getList(txnType);
    }

    /** ================== 登録または更新 (등록 또는 수정) ================== */
    @Transactional
    @Override
    public void saveOrUpdate(OtherTxnCategory category) {
        // ✅ カテゴリ名必須チェック / 카테고리명 필수값 검증
        if (category.getCategoryName() == null || category.getCategoryName().trim().isEmpty()) {
            throw new IllegalArgumentException("CATEGORY_NAME 필수");
        }

        // ✅ 新規登録処理 / 신규 등록 처리
        if (category.getTxnCode() == null || category.getTxnCode().isEmpty()) {
            // 🔹 一意なコード生成(UUID) / 고유 코드 생성(UUID 기반)
            String newCode = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
            category.setTxnCode(category.getTxnType() + newCode);
            // category.setBuId(10);          // 事業部ID固定(仮設定) / 사업부 ID 임시 설정
            category.setUseYn("Y");       // 使用可フラグ / 사용여부 기본 Y
            mapper.insert(category);
        } else {
            // ✅ 既存データ更新処理 / 기존 데이터 수정 처리
            mapper.update(category);
        }
    }

    /** ================== 新規登録 (신규 등록) ================== */
    @Override
    public void register(OtherTxnCategory category) {
        // ✅ 区分マスタ新規登録 / 구분 마스터 신규 등록
        category.setUseYn("Y");  // 使用可に設定 / 사용가능으로 설정
        mapper.insert(category);
    }

    /** ================== 修正 (수정) ================== */
    @Override
    public void modify(OtherTxnCategory category) {
        // ✅ 区分マスタ更新 / 구분 마스터 수정
        mapper.update(category);
    }

    /** ================== 削除 (삭제) ================== */
    @Override
    public void delete(String txnCode, int buId) {
        // ✅ 区分マスタ削除 / 구분 마스터 삭제
        mapper.delete(txnCode, buId);
    }
}
