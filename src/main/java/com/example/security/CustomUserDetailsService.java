package com.example.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.example.domain.MemberDTO;
import com.example.mapper.MemberMapper;
import com.example.security.domain.CustomUser;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		log.warn("Load User By UserName : " + userName);
		
		MemberDTO dto = memberMapper.read(userName);
		
		log.warn("queried by member mapper : " + dto);
		
		return dto == null ? null : new CustomUser(dto);
		
	}
	
}
