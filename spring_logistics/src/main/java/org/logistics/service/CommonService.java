package org.logistics.service;

import java.util.List;
import org.logistics.domain.BusinessUnitDTO;

public interface CommonService {
    
    // 사업 부문 목록을 가져오는 추상 메서드
    List<BusinessUnitDTO> getBusinessUnits();
}