package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.BoardDTO;
import com.example.domain.Criteria;

public interface BoardMapper {

	public List<BoardDTO> getList();
	
	public List<BoardDTO> getListWithPaging(Criteria cri);
	
	public void insert(BoardDTO board);
	
	public void insertSelectKey(BoardDTO board);
	
	public BoardDTO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardDTO board);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
}
