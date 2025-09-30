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

    // ✅ JSP 화면
    @GetMapping("/list")
    public String list() {
        return "txnCategory/tabList";   // /WEB-INF/views/txnCategory/tabList.jsp
    }

    // ✅ 조회 API
    @ResponseBody
    @GetMapping(value = "/api/list/{txnType}", produces = "application/json;charset=UTF-8")
    public List<OtherTxnCategory> getList(@PathVariable("txnType") String txnType) {
        return service.getList(txnType);
    }


    // ✅ 저장/수정 API
    @ResponseBody
    @PostMapping("/api/save")
    public ResponseEntity<?> saveCategory(@RequestBody OtherTxnCategory dto) {
        try {
            service.saveOrUpdate(dto);
            Map<String, Object> result = new HashMap<>();
            result.put("result", "success");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> error = new HashMap<>();
            error.put("result", "error");
            error.put("message", e.getMessage());
            // JSON 보장
            return ResponseEntity.status(500).body(error);
        }
    }
 // ✅ 실제 삭제
    @ResponseBody
    @DeleteMapping("/api/delete/{txnCode}/{buId}")
    public ResponseEntity<?> deleteCategory(
            @PathVariable("txnCode") String txnCode,
            @PathVariable("buId") int buId) {
        try {
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



}
