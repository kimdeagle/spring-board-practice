package com.example.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.example.config.RootConfig;
import com.example.domain.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes=RootConfig.class)
@Slf4j
public class MemberMapperTests {

	@Autowired
	private MemberMapper mapper;
	
	@Test
	public void testRead() {
		MemberDTO dto = mapper.read("admin90");
		
		log.info("dto");
		
		dto.getAuthList().forEach(authDTO -> log.info(authDTO.toString()));
	}
	
}
