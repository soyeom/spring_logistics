package org.logistics.service;

import org.logistics.domain.OutRequestDTO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OutServiceImpl implements OutService {
	
	@Override
	@Transactional
	public void createOut(OutRequestDTO request)
	{
		
	}
}
