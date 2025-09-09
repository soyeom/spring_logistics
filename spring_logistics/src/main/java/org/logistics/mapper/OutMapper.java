package org.logistics.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.logistics.domain.OutDetailDTO;
import org.logistics.domain.OutRequestDTO;

@Mapper
public interface OutMapper {

	void insertOutRequest(OutRequestDTO requestDTO);
	
	void insertOutDetail(OutDetailDTO detailDTO);
	
}