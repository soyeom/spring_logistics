package org.logistics.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.logistics.domain.InboundVO;
import org.logistics.mapper.InboundMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InboundServiceImpl implements InboundService {
	@Autowired
	private InboundMapper mapper;

	@Override
	public List<InboundVO> selectByItemId(Map<String, Object> params) {
		List<InboundVO> list = mapper.selectByItemId(params);

		//  '미완료(N)' 데이터만 필터링
		// 「未完了（N）」データのみをフィルタリング
		return list.stream().filter(vo -> "N".equals(vo.getInboundComplete())).collect(Collectors.toList());
	}
}