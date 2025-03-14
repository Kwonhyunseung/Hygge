package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.UsedBoardMapper;
import com.sp.app.model.Reply;
import com.sp.app.model.Report;
import com.sp.app.model.UsedBoard;
import com.sp.app.model.UsedRequest;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class UsedBoardServiceImpl implements UsedBoardService {
	private final UsedBoardMapper mapper;
	private final StorageService storageService;

	@Override
	public void insertBoard(UsedBoard dto, String uploadPath) throws Exception {
		try {
			long num = mapper.seqValue();
			dto.setNum(num);
			mapper.insertBoard(dto);
			if (!dto.getSelectFile().isEmpty()) { // 업로드된 파일이 있을 경우
				for (MultipartFile selectFile : dto.getSelectFile()) {
					String saveFilename = storageService.uploadFileToServer(selectFile, uploadPath);
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("board_num", num);
					map.put("s_FileName", saveFilename);
					mapper.insertBoardFile(map);
				}
			}
		} catch (Exception e) {
			log.info("insertBoard : ", e);
			throw e;
		}
	}

	@Override
	public List<UsedBoard> listBoard(Map<String, Object> map) {
		List<UsedBoard> list = null;
		try {
			list = mapper.listBoard(map);
		} catch (Exception e) {
			log.info("listBoard : ", e);
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return result;
	}

	@Override
	public UsedBoard findById(long num) {
		UsedBoard dto = null;
		try {
			dto = mapper.findById(num);
			dto.setS_Filename(mapper.findFileById(num));
			dto.setPriceFormat(String.format("%,d", dto.getPrice()));
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		return dto;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		try {
			mapper.updateHitCount(num);
		} catch (Exception e) {
			log.info("updateHitCount : ", e);
			throw e;
		}
	}

	@Override
	public UsedBoard findByPrev(Map<String, Object> map) {
		UsedBoard dto = null;
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}
		return dto;
	}

	@Override
	public UsedBoard findByNext(Map<String, Object> map) {
		UsedBoard dto = null;
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext : ", e);
		}
		return dto;
	}

	@Override
	public void deleteBoard(long num, String uploadPath, long userId, String authority) throws Exception {
		try {
			List<String> files = mapper.findFileById(num);
			if (files.size() > 0) { // 서버에서 첨부파일 삭제
				for (String filename : files) {
					deleteUploadFile(uploadPath, filename);
				}
				mapper.deleteBoardFile(num); // DB 에서 첨부파일 삭제
			}

			UsedBoard dto = findById(num);
			if (dto.getMemberIdx() == userId || authority.equalsIgnoreCase("ADMIN")) { // 작성자인지 혹은 관리자인지 확인
				mapper.deleteBoard(num);
			}
		} catch (Exception e) {
			log.info("deleteBoard : ", e);
			throw e;
		}
	}
	
	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		return storageService.deleteFile(uploadPath, filename);
	}

	@Override
	public void updateBoard(UsedBoard dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			mapper.insertReply(dto);
		} catch (Exception e) {
			log.info("insertReply : ", e);
			throw e;
		}
	}

	@Override
	public int replyCount(long num) {
		int result = 0;
		try {
			result = mapper.replyCount(num);
		} catch (Exception e) {
			log.info("replyCount : ", e);
		}
		return result;
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		try {
			list = mapper.listReply(map);
		} catch (Exception e) {
			log.info("listReply : ", e);
		}
		return list;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteReply(map);
		} catch (Exception e) {
			log.info("deleteReply : ", e);
			throw e;
		}
	}
	
	@Override
	public List<Reply> listReplyAnswer(long num) {
		List<Reply> list = null;
		try {
			list = mapper.listReplyAnswer(num);
		} catch (Exception e) {
			log.info("listReplyAnswer : ", e);
		}
		return list;
	}
	
	@Override
	public int replyAnswerCount(long num) {
		int result = 0;
		try {
			result = mapper.replyAnswerCount(num);
		} catch (Exception e) {
			log.info("replyAnswerCount : ", e);
		}
		return result;
	}

	@Override
	public void insertRequest(UsedRequest dto) throws Exception {
		try {
			mapper.usedBoardRequest(dto);
		} catch (Exception e) {
			log.info("insertRequest : ", e);
			throw e;
		}
	}

	@Override
	public List<UsedRequest> listRequest(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void reportUsedBoard(Report dto) throws Exception {
		try {
			mapper.reportUsedBoard(dto);
		} catch (Exception e) {
			log.info("reportUsedBoard : ", e);
			throw e;
		}
	}

	@Override
	public int BoardCount(long memberIdx) {
		try {
		return mapper.boardCount(memberIdx);
		} catch (Exception e) {
            log.error("글 개수 조회 실패", e);
            
            throw e;
		}
	}

	@Override
	public long findWriter(long num) {
		long idx = 0;
		try {
			idx = mapper.findWriter(num);
		} catch (Exception e) {
			log.info("findWriter : ", e);
		}
		return idx;
	}

	@Override
	public boolean isArticleRequested(long num) {
		UsedRequest dto = null;
		try {
			dto = mapper.isArticleRequested(num);
			if (dto == null || dto.getProgress() == -1) {
				return false;
			}
		} catch (Exception e) {
			log.info("isArticleRequested : ", e);
		}
		return true;
	}

}
