package org.logistics.service;

import java.util.List;
import java.util.Map;
import org.logistics.domain.InboundVO;

public interface InboundService {
    List<InboundVO> selectByItemId(Map<String, Object> params);
}
