package org.logistics.service;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.logistics.mapper.InboundMapper;
import org.logistics.domain.InboundVO;

@Service
public class InboundServiceImpl implements InboundService {
    @Autowired
    private InboundMapper mapper;

    @Override
    public List<InboundVO> getByItemId(Map<String, Object> params) {
        return mapper.selectByItemId(params);
    }
}