package org.logistics.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.logistics.mapper.OutboundMapper;
import org.logistics.domain.InboundVO;
import org.logistics.domain.OutboundVO;

@Service
public class OutboundServiceImpl implements OutboundService {
    @Autowired
    private OutboundMapper mapper;

    @Override
    public List<OutboundVO> selectByItemId(Map<String, Object> params) {
    	List<OutboundVO> list = mapper.selectByItemId(params);

		// '미완료(N)' 데이터만 필터링
    	// 「未完了（N）」データのみをフィルタリング
		return list.stream().filter(vo -> "N".equals(vo.getOutboundComplete())).collect(Collectors.toList());
    }
}