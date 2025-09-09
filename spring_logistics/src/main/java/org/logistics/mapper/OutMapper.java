package org.logistics.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.logistics.domain.OtherOutCategory;
import org.logistics.domain.OutDetailDTO;
import org.logistics.domain.OutRequestDTO;

@Mapper
public interface OutMapper {

	void insertOutRequest(OutRequestDTO requestDTO);
	
	void insertOutDetail(OutDetailDTO detailDTO);

	List<OutDetailDTO> getOutDetailsWithItemInfo();

	List<OtherOutCategory> getOtherOutCategories();
	
}