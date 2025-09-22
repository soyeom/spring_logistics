package org.logistics.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.logistics.domain.PopupVO;

public interface PopupMapper {

	public List<PopupVO> item_List(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> contact_List(@Param ("gubun") String gubun, @Param ("text") String text);
	public List<PopupVO> warehouse_List(@Param ("gubun") String gubun, @Param ("text") String text);
}
