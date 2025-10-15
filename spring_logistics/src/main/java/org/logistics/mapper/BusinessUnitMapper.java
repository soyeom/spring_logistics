package org.logistics.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.logistics.domain.BusinessUnitDTO;

@Mapper // Spring과 MyBatis가 이 인터페이스를 인식하도록 합니다.
public interface BusinessUnitMapper {
    
    // 사업 부문 목록을 모두 조회하는 메서드
    List<BusinessUnitDTO> selectBusinessUnits();
}