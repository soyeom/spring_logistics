package org.logistics.service;

import org.logistics.domain.ContactVO;

public interface ContactService {

	public ContactVO login_Check(String bu_Id, String contact_Id, String password);
}
