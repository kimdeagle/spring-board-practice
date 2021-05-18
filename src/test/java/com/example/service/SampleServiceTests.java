package com.example.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.config.RootConfig;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Slf4j
@ContextConfiguration(classes= {RootConfig.class})
public class SampleServiceTests {

	@Autowired
	private SampleService service;
	
	@Test
	public void testClass() {
		//log.info(service);
		log.info(service.getClass().getName());
	}
	
	@Test
	public void testAdd() throws Exception {
		//Before Test
		log.info(service.doAdd("123", "456") + "");
		
		//AfterThrowing Test
		//log.info(service.doAdd("123", "ABC") + "");
		
		
	}
	
}
