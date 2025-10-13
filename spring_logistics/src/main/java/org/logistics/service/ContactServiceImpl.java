package org.logistics.service;

import org.logistics.domain.ContactVO;
import org.logistics.mapper.ContactMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class ContactServiceImpl implements ContactService {

	@Setter(onMethod_= @Autowired)
	private ContactMapper contactMapper;
	
	@Override
	public ContactVO login_Check(String bu_Id, String contact_Id, String password) {
		return contactMapper.login_Check(bu_Id, contact_Id, password);
	}

	@Override
	public int idCheck(ContactVO vo) {
		return contactMapper.idCheck(vo);
	}
	
	@Override
	public void save(ContactVO vo) {
		contactMapper.save(vo);
	}

	
}
