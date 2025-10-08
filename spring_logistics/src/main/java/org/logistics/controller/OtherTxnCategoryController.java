package org.logistics.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.logistics.model.OtherTxnCategory;
import org.logistics.service.OtherTxnCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/txnCategory")
public class OtherTxnCategoryController {

    @Autowired
    private OtherTxnCategoryService service;

    /** ================== JSP 화면 호출 ==================
     * ✅ JSP表示画面を呼び出す
     * → 거래 구분(入出庫区分) 설정 화면을 JSP로 반환한다.
     */
    @GetMapping("/list")
    public String list() {
        // ✅ /WEB-INF/views/txnCategory/tabList.jsp を返す / JSP 뷰 반환
        return "txnCategory/tabList";
    }

    /** ================== 조회 API ==================
     * ✅ 取引区分リストの照会API
     * → 거래 구분(출고/입고/이동 등)을 타입별로 조회하는 API
     * @param txnType 取引タイプ (OUT / IN / MOVE)
     */
    @ResponseBody
    @GetMapping(value = "/api/list/{txnType}", produces = "application/json;charset=UTF-8")
    public List<OtherTxnCategory> getList(@PathVariable("txnType") String txnType) {
        // ✅ サービス層からリストを取得 / 서비스 계층에서 목록 조회
        return service.getList(txnType);
    }


    /** ================== 저장 / 수정 API ==================
     * ✅ 登録・更新API
     * → 신규 데이터 저장 또는 기존 데이터 수정
     * @param dto OtherTxnCategory DTO オブジェクト / DTO 객체
     */
    @ResponseBody
    @PostMapping("/api/save")
    public ResponseEntity<?> saveCategory(@RequestBody OtherTxnCategory dto) {
        try {
            // ✅ サービス層に登録または更新依頼 / 서비스 계층에 저장 또는 수정 요청
            service.saveOrUpdate(dto);

            // ✅ 結果をJSON形式で返却 / 결과를 JSON 형식으로 반환
            Map<String, Object> result = new HashMap<>();
            result.put("result", "success");
            return ResponseEntity.ok(result);

        } catch (Exception e) {
            // ✅ 例外処理 / 예외 처리
            e.printStackTrace();
            Map<String, Object> error = new HashMap<>();
            error.put("result", "error");
            error.put("message", e.getMessage());
            // ✅ JSON形式でエラー応答 / JSON 형식으로 에러 응답
            return ResponseEntity.status(500).body(error);
        }
    }

    /** ================== 삭제 API ==================
     * ✅ 削除API
     * → 거래 구분(txnCategory)을 코드 기준으로 삭제한다.
     * @param data JSON形式の削除データ (txnCode, buId)
     */
    @ResponseBody
    @PostMapping("/api/delete")
    public ResponseEntity<?> deleteCategory(@RequestBody Map<String, Object> data) {
        try {
            // ✅ JSONから削除対象キーを取得 / JSON에서 삭제할 키 추출
            String txnCode = (String) data.get("txnCode");
            int buId = Integer.parseInt(data.get("buId").toString());

            // ✅ サービス層に削除依頼 / 서비스 계층에 삭제 요청
            service.delete(txnCode, buId);

            // ✅ 成功結果を返却 / 성공 결과 반환
            Map<String, Object> result = new HashMap<>();
            result.put("result", "success");
            return ResponseEntity.ok(result);

        } catch (Exception e) {
            // ✅ 例外処理 / 예외 처리
            e.printStackTrace();
            Map<String, Object> error = new HashMap<>();
            error.put("result", "error");
            error.put("message", e.getMessage());
            return ResponseEntity.status(500).body(error);
        }
    }

}
