package org.logistics.mapper;

import java.util.List;
import java.util.Map;
import org.logistics.domain.InboundVO;

public interface InboundMapper {
    List<InboundVO> selectByItemId(Map<String, Object> params);  
}
