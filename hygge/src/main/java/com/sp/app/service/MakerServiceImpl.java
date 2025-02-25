package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.MakerMapper;
import com.sp.app.model.Category;
import com.sp.app.model.Funding;
import com.sp.app.model.Product;

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

	@Override
	public void insertProduct(Product dto) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("num", dto.getNum());
			for (int i = 0; i < dto.getTitleList().size(); i++) {
				int price = dto.getPriceList().get(i);
				int stock = dto.getStockList().get(i);
				String detail = dto.getDetailList().get(i);
				String title = dto.getTitleList().get(i);
				String origin = dto.getOriginList().get(i);

				map.put("price", price);
				map.put("stock", stock);
				map.put("detail", detail);
				map.put("title", title);
				map.put("origin", origin);

				mapper.insertProduct(map);
			}
		} catch (Exception e) {
			log.info("insertProduct : ", e);
		}
	}

}
