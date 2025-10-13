package org.logistics.mapper;

import java.util.List;
import java.util.Map;
import org.logistics.domain.OutboundVO;

public interface OutboundMapper {
    List<OutboundVO> selectByItemId(Map<String, Object> params);  
}
