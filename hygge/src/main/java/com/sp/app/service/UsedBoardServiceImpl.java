package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;
import com.sp.app.mapper.UsedBoardMapper;
import com.sp.app.model.Reply;
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
	private final MyUtil myUtil;

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
		// TODO Auto-generated method stub
		
	}

	@Override
	public UsedBoard findByPrev(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UsedBoard findByNext(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteBoard(long num, String uploadPath, String userId, int userLevel) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateBoard(UsedBoard dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertRequest(UsedRequest dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<UsedRequest> listRequest(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}


}
