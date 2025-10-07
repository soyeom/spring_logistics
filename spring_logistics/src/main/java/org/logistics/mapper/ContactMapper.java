package org.logistics.mapper;

import org.apache.ibatis.annotations.Param;
import org.logistics.domain.ContactVO;

public interface ContactMapper {

	public ContactVO login_Check(@Param ("bu_Id") String bu_Id, @Param ("contact_Id") String contact_Id, @Param("password") String password);
}
