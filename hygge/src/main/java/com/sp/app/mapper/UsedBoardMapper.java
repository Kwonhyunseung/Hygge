package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Reply;
import com.sp.app.model.Report;
import com.sp.app.model.UsedBoard;
import com.sp.app.model.UsedRequest;

@Mapper
public interface UsedBoardMapper {
	public long seqValue();
	public void insertBoard(UsedBoard dto) throws SQLException;
	public void insertBoardFile(Map<String, Object> map) throws SQLException;
	// public void updateBoard(UsedBoard dto) throws SQLException;
	public void deleteBoard(long num) throws SQLException;
	public void deleteBoardFile(long num) throws SQLException;

	public int dataCount(Map<String, Object> map);
	public List<UsedBoard> listBoard(Map<String, Object> map);

	public UsedBoard findById(long num);
	public List<String> findFileById(long num);
	public void updateHitCount(long num) throws SQLException;
	public UsedBoard findByPrev(Map<String, Object> map);
	public UsedBoard findByNext(Map<String, Object> map);

	public void reportUsedBoard(Report dto) throws SQLException;

	public void usedBoardRequest(UsedRequest dto);
	public UsedRequest isArticleRequested(long num);

	// 댓글
	public void insertReply(Reply dto) throws SQLException;
	public void deleteReply(Map<String, Object> map) throws SQLException;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(long num);

	public long findWriter(long num);

	// 답글
	public List<Reply> listReplyAnswer(long num);
	public int replyAnswerCount(long num);
	// 글 개수
	public int boardCount(long memberIdx);
}
