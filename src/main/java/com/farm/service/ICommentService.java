package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.CommentDTO;

@Mapper
public interface ICommentService {

	public int insertComment(CommentDTO commentDTO);
	public ArrayList<CommentDTO> selectComments(@Param("inquiry_id") Long inquiry_id);
	public CommentDTO getComment(@Param("com_id") Long com_id);
	public int updateComment(CommentDTO commentDTO);
	public int deleteComment(@Param("com_id") Long com_id);
	
}
