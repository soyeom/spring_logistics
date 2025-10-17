package org.logistics.service;

import java.util.List;
import org.logistics.domain.BusinessUnitDTO;
import org.logistics.mapper.BusinessUnitMapper;
import org.springframework.stereotype.Service;

@Service
public class CommonServiceImpl implements CommonService {

    private final BusinessUnitMapper businessUnitMapper;

    // Mapper 주입 (Dependency Injection)
    public CommonServiceImpl(BusinessUnitMapper businessUnitMapper) {
        this.businessUnitMapper = businessUnitMapper;
    }

    @Override
    public List<BusinessUnitDTO> getBusinessUnits() {
        // Mapper를 호출하여 DB에서 데이터를 가져옵니다.
        return businessUnitMapper.selectBusinessUnits();
    }
}