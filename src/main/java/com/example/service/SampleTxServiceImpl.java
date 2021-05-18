package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mapper.Sample1Mapper;
import com.example.mapper.Sample2Mapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SampleTxServiceImpl implements SampleTxService {

	@Autowired
	private Sample1Mapper mapper1;
	
	@Autowired
	private Sample2Mapper mapper2;
	
	@Transactional
	@Override
	public void addData(String value) {
		log.info("mapper1....................");
		mapper1.insertCol1(value);
		
		log.info("mapper2....................");
		mapper2.insertCol2(value);
		
		log.info("end........................");
	}
	
}
