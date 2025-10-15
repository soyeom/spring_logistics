package org.logistics.controller;

import java.util.List;
import java.util.Map;

import org.logistics.domain.AvailableItemVO;
import org.logistics.service.AvailableItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.logistics.service.*;
@Controller
@RequestMapping("/warehouse")
public class AvailableItemController {

    @Autowired
    private AvailableItemService service;
    
    @Autowired
    private PopupService popupService;

    //가용재고조회 기본 화면 요청 처리 (可用在庫照会画面の初期表示処理)
    @GetMapping("/availableItems")
    public String view(Model model) {
        model.addAttribute("items", service.getAvailableItems()); //전체 재고 리스트를 조회하여 화면에 전달 (在庫一覧データを取得して画面に渡す)
        model.addAttribute("buList", service.getBusinessUnits()); //셀렉트 박스로 조회할 조건은 따로 받아오기 (セレクトボックスで照会する条件は別に受け取る)
        model.addAttribute("assetClassList",service.getAssetClasses());
        
        return "zaikou/availableItems";
    }

    @GetMapping("/availableList")
    @ResponseBody //JSON 형식으로 응답(JSON形式で応答)
    public List<AvailableItemVO> search(@RequestParam Map<String, Object> params) {
    	
    	//모든 검색조건이 비어있는지 확인 (全ての検索条件が空かどうかを確認)
        boolean isEmpty = params.values().stream().allMatch(v -> v == null || v.toString().isEmpty());

        if (isEmpty) {
            return service.getAvailableItems(); //조건이 없으면 전체 데이터 반환 (条件なしの場合、全データを返す)
        } else {
            return service.search(params); //조건이 있을 경우 검색 실행 (条件ありの場合、検索を実行)
        }
    }
}

