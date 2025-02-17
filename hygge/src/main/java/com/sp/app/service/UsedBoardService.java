package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Reply;
import com.sp.app.model.Report;
import com.sp.app.model.UsedBoard;
import com.sp.app.model.UsedRequest;

public interface UsedBoardService {
	public void insertBoard(UsedBoard dto, String uploadPath) throws Exception;
	public List<UsedBoard> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public UsedBoard findById(long num);
	public void updateHitCount(long num) throws Exception;
	public UsedBoard findByPrev(Map<String, Object> map);
	public UsedBoard findByNext(Map<String, Object> map);
	public void deleteBoard(long num, String uploadPath, long userId, String authority) throws Exception;
	public void updateBoard(UsedBoard dto) throws Exception;

	public boolean deleteUploadFile(String uploadPath, String filename);

	public void reportUsedBoard(Report dto) throws Exception;

	public void insertReply(Reply dto) throws Exception;
	public int replyCount(long num);
	public List<Reply> listReply(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;

	public List<Reply> listReplyAnswer(long num);
	public int replyAnswerCount(long num);

	public long findWriter(long num);

	// 중고거래 신청
	public void insertRequest(UsedRequest dto) throws Exception;
	public List<UsedRequest> listRequest(Map<String, Object> map);
	public int BoardCount(long memberIdx);
	// 작성 글 갯수 
}
