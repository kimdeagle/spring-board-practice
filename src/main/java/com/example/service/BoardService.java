package com.example.service;

import java.util.List;

import com.example.domain.BoardDTO;
import com.example.domain.Criteria;

public interface BoardService {

	public void register(BoardDTO board);
	
	public BoardDTO get(Long bno);
	
	public boolean modify(BoardDTO board);
	
	public boolean remove(Long bno);
	
	public List<BoardDTO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
}
