package com.farm.service;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.PassFindDTO;

@Mapper
public interface IPassFinderService {
	public Long findUser(PassFindDTO passFindDTO);
	public int sendNewPw(@Param("member_id") Long member_id, 
						 @Param("passwd") String passwd);
}
