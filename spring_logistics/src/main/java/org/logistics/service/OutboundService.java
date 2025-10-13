package org.logistics.service;

import java.util.List;
import java.util.Map;
import org.logistics.domain.OutboundVO;

public interface OutboundService {
    List<OutboundVO> getByItemId(Map<String, Object> params);
}