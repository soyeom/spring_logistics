package org.logistics.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.logistics.mapper.AvailableItemMapper;
import org.logistics.domain.AvailableItemVO;

@Service
public class AvailableItemService {

    @Autowired
    private AvailableItemMapper mapper;

    public List<AvailableItemVO> getAvailableItems() {
        List<AvailableItemVO> items = mapper.getAvailableItems();

        System.out.println(">>> Mapper is null? " + (mapper == null));
        return mapper.getAvailableItems();
    }
    
    
}
