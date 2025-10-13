package org.logistics.mapper;

import org.apache.ibatis.annotations.Param;
import org.logistics.domain.ContactVO;
import org.logistics.domain.InvFlowConfigVO;

public interface ContactMapper {

	public ContactVO login_Check(@Param ("bu_Id") String bu_Id, @Param ("contact_Id") String contact_Id, @Param("password") String password);
	public int idCheck(ContactVO vo);
	public void save(ContactVO vo);
}
