package org.logistics.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.logistics.domain.OtherTxnCategory;
import org.logistics.service.OtherTxnCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/txnCategory")
public class OtherTxnCategoryController {

    @Autowired
    private OtherTxnCategoryService service;

    /** ================== JSP 화면 호출 ==================
     * ✅ JSP表示画面を呼び出す
     * → 거래 구분(入出庫区分) 설정 화면을 JSP로 반환한다。
     */
    @GetMapping("/list")
    public String list() {
        return "txnCategory/tabList";
    }

    /** ================== 조회 API ==================
     * ✅ 取引区分リストの照会API
     * → 거래 구분(출고/입고/이동 등)을 타입별로 조회하는 API
     */
    @ResponseBody
    @GetMapping(value = "/api/list/{txnType}", produces = "application/json;charset=UTF-8")
    public List<OtherTxnCategory> getList(@PathVariable("txnType") String txnType) {
        return service.getList(txnType);
    }

    /** ================== 저장 / 수정 API ==================
     * ✅ 登録・更新API
     * → 신규 데이터 저장 또는 기존 데이터 수정
     */
    @ResponseBody
    @PostMapping("/api/save")
    public ResponseEntity<?> saveCategory(@RequestBody OtherTxnCategory dto) {
        try {
            // ✅ Boolean → "Y"/"N" 변환
            normalizeFlags(dto);

            // ✅ 서비스 계층에 저장 또는 수정 요청
            service.saveOrUpdate(dto);

            // ✅ 결과 반환
            Map<String, Object> result = new HashMap<>();
            result.put("result", "success");
            return ResponseEntity.ok(result);

        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> error = new HashMap<>();
            error.put("result", "error");
            error.put("message", e.getMessage());
            return ResponseEntity.status(500).body(error);
        }
    }

    /** ================== 삭제 API ==================
     * ✅ 削除API
     * → 거래 구분(txnCategory)을 코드 기준으로 삭제한다。
     */
    @ResponseBody
    @PostMapping("/api/delete")
    public ResponseEntity<?> deleteCategory(@RequestBody Map<String, Object> data) {
        try {
            String txnCode = (String) data.get("txnCode");
            int buId = Integer.parseInt(data.get("buId").toString());
            service.delete(txnCode, buId);

            Map<String, Object> result = new HashMap<>();
            result.put("result", "success");
            return ResponseEntity.ok(result);

        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> error = new HashMap<>();
            error.put("result", "error");
            error.put("message", e.getMessage());
            return ResponseEntity.status(500).body(error);
        }
    }

    /** ================== 내부 메서드 ==================
     * ✅ チェックボックスなどのtrue/falseを"Y"/"N"に変換
     * (체크박스 값 true/false → "Y"/"N"으로 변환)
     */
    private void normalizeFlags(OtherTxnCategory dto) {
        dto.setUseYn(toYN(dto.getUseYn()));
        dto.setIsFinishedProduct(toYN(dto.getIsFinishedProduct()));
        dto.setIsMaterial(toYN(dto.getIsMaterial()));
        dto.setIsSalesUse(toYN(dto.getIsSalesUse()));
        dto.setAdjustOut(toYN(dto.getAdjustOut()));
        dto.setAdjustIn(toYN(dto.getAdjustIn()));
        dto.setIsVatTarget(toYN(dto.getIsVatTarget()));
        dto.setIsAs(toYN(dto.getIsAs()));
        dto.setIsItemJournal(toYN(dto.getIsItemJournal()));
        dto.setIsByproductIn(toYN(dto.getIsByproductIn()));
        dto.setIsReturnIn(toYN(dto.getIsReturnIn()));
        dto.setIsMove(toYN(dto.getIsMove()));
        dto.setIsTransfer(toYN(dto.getIsTransfer()));
        dto.setIsAsOut(toYN(dto.getIsAsOut()));
        dto.setIsAsReturn(toYN(dto.getIsAsReturn()));
        dto.setIsFreeSupply(toYN(dto.getIsFreeSupply()));
        dto.setIsDispatchTarget(toYN(dto.getIsDispatchTarget()));
    }

    /** ================== true/false/null → Y/N 변환기 ================== */
    private String toYN(Object flag) {
        if (flag == null) return "N";
        String value = flag.toString().trim().toLowerCase();
        return ("y".equals(value) || "true".equals(value) || "1".equals(value)) ? "Y" : "N";
    }
}
