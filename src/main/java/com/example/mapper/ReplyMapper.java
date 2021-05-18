package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.Criteria;
import com.example.domain.ReplyDTO;

public interface ReplyMapper {

	public int insert(ReplyDTO reply);
	
	public ReplyDTO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyDTO reply);
	
	public List<ReplyDTO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	public int getCountByBno(Long bno);
	
	
}
