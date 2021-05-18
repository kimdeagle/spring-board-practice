package com.example.service;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.ReplyDTO;
import com.example.domain.ReplyPageDTO;

public interface ReplyService {

	public int register(ReplyDTO reply);
	
	public ReplyDTO get(Long rno);
	
	public int modify(ReplyDTO reply);
	
	public int remove(Long rno);
	
	public List<ReplyDTO> getList(Criteria cri, Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	
}
