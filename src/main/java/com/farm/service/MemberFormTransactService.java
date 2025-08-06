package com.farm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.farm.dto.MemberDTO;


@Service
public class MemberFormTransactService {
	@Autowired
    private IMemberFormService formDao;

    @Transactional
    public void registerBuyer(MemberDTO dto) {
        formDao.registMember(dto);
        formDao.registAddr(dto);
    }
    
    @Transactional
    public void registerSeller(MemberDTO dto) {
    	formDao.registMember(dto);
    	formDao.registAddr(dto);
    	formDao.registFarm(dto);
    }
}
