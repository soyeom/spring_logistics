package org.logistics.service;

import java.util.List;

import org.logistics.domain.OtherOutCategory; // OtherOutCategory DTO를 직접 사용
import org.logistics.domain.OutDetailDTO;
import org.logistics.domain.OutRequestDTO;
import org.logistics.mapper.OutMapper; // 매퍼 인터페이스를 주입받음
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class OutServiceImpl implements OutService {

    private final OutMapper outMapper; 

    @Override
    public void createOut(OutRequestDTO request) {
        // 출고 등록 비즈니스 로직 구현
    }

    @Override
    public List<OutDetailDTO> getOutDetails() {
     
    	return outMapper.getOutDetailsWithItemInfo();
        
           }
    
    @Override
    public List<OtherOutCategory> getOtherOutCategories() {
        
    	return outMapper.getOtherOutCategories();

     
    }
}