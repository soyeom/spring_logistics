package org.logistics.service;

import java.util.List;

import org.logistics.domain.OtherOutCategory;
import org.logistics.domain.OutDetailDTO;
import org.logistics.domain.OutRequestDTO;

public interface OutService {
    void createOut(OutRequestDTO request);

    List<OutDetailDTO> getOutDetails();
    
    // 기타 출고 카테고리 리스트를 가져오는 메서드 추가
    List<OtherOutCategory> getOtherOutCategories();
}