package com.sp.app.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.MakerMapper;
import com.sp.app.model.Category;
import com.sp.app.model.Funding;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MakerServiceImpl implements MakerService {
	private final MakerMapper mapper;
	private final StorageService storageService;

	@Override
	public void updateProjectRequest(long num) throws Exception {
		
	}

	@Override
	public List<Category> listCategory(long num) {
		List<Category> list = null;
		try {
			list = mapper.listCategory(num);
		} catch (Exception e) {
			log.info("listCategory : ", e);
		}
		return list;
	}

	@Override
	public long insertTempProjectRequest(Funding dto, String uploadPath) throws Exception {
		long num = 0;
		try {
			num = mapper.getPR_SEQ();
			dto.setNum(num);
			mapper.insertTempProjectRequest(dto);
			if (!dto.getPhotoFiles().isEmpty()) {
				for (int i = 0; i < dto.getPhotoFiles().size(); i++) {
					dto.setSfileName(storageService.uploadFileToServer(dto.getPhotoFiles().get(i), uploadPath));
					dto.setPhoto_order(i);
					mapper.insertProjectPhoto(dto);
				}
			}
		} catch (Exception e) {
			log.info("insertTempProjectRequest : ", e);
			throw e;
		}
		return num;
	}

}
