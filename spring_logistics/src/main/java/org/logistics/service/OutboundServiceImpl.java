package org.logistics.service;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.logistics.mapper.OutboundMapper;
import org.logistics.domain.OutboundVO;

@Service
public class OutboundServiceImpl implements OutboundService {
    @Autowired
    private OutboundMapper mapper;

    @Override
    public List<OutboundVO> getByItemId(Map<String, Object> params) {
        return mapper.selectByItemId(params);
    }
}