package org.logistics.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.logistics.model.OtherTxnCategory;

@Mapper
public interface OtherTxnCategoryMapper {

    /** ================== 取引区分リスト取得 ==================
     * ✅ 取引区分リストをタイプ別に取得する
     * → 거래 유형(txnType: 入庫/出庫/移動 등)에 따른 거래 구분 리스트를 조회한다.
     * @param txnType 取引タイプ (IN / OUT / MOVE 등)
     */
    List<OtherTxnCategory> getList(@Param("txnType") String txnType);

    /** ================== 次取引コード採番 ==================
     * ✅ 次の取引コードを採番する
     * → 신규 등록 시, 해당 거래유형(txnType)과 사업부(buId)에 따른 다음 거래코드를 생성한다.
     * @param txnType 取引タイプ / 거래유형
     * @param buId 事業部ID / 사업부 ID
     */
    String getNextTxnCode(@Param("txnType") String txnType, @Param("buId") int buId);

    /** ================== 新規登録 ==================
     * ✅ 取引区分を新規登録する
     * → 거래 구분 데이터를 신규로 등록한다.
     * @param category 取引区分DTO / 거래구분 DTO
     */
    void insert(OtherTxnCategory category);

    /** ================== 更新 ==================
     * ✅ 取引区分を更新する
     * → 기존 거래 구분 데이터를 수정한다.
     * @param category 取引区分DTO / 거래구분 DTO
     */
    void update(OtherTxnCategory category);

    /** ================== 削除 ==================
     * ✅ 取引区分を削除する
     * → 거래코드(txnCode) 및 사업부(buId) 기준으로 거래 구분 데이터를 삭제한다.
     * @param txnCode 取引コード / 거래코드
     * @param buId 事業部ID / 사업부 ID
     */
    void delete(@Param("txnCode") String txnCode, @Param("buId") int buId);
}
