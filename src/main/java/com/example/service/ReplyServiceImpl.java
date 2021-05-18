package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.Criteria;
import com.example.domain.ReplyDTO;
import com.example.domain.ReplyPageDTO;
import com.example.mapper.BoardMapper;
import com.example.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper mapper;
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Override
	public ReplyDTO get(Long rno) {
		return mapper.read(rno);
	}
	
	@Override
	public List<ReplyDTO> getList(Criteria cri, Long bno) {
		return mapper.getListWithPaging(cri, bno);
	}
	
	@Override
	public int modify(ReplyDTO reply) {
		return mapper.update(reply);
	}
	
	@Transactional
	@Override
	public int register(ReplyDTO reply) {
		
		boardMapper.updateReplyCnt(reply.getBno(), 1);
		
		return mapper.insert(reply);
	}
	
	@Transactional
	@Override
	public int remove(Long rno) {
		
		ReplyDTO reply = mapper.read(rno);
		
		boardMapper.updateReplyCnt(reply.getBno(), -1);
		
		return mapper.delete(rno);
	}
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}
	
}
