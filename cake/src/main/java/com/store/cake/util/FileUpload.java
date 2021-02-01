package com.store.cake.util;

import java.io.File;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;


public class FileUpload {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUpload.class);
	private static final String uploadPath = "D:\\localGit\\piece_of_cake\\cake\\src\\main\\webapp\\resources\\images\\";
	public String uploadFile(MultipartFile file, String folder) throws Exception{
		
		logger.info("file name : " + file.getOriginalFilename());
		logger.info("file size : " + file.getSize());
		logger.info("content type : " + file.getContentType());
		
		String Path = uploadPath + folder;
		
		//random name
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() + "_" + file.getOriginalFilename();
		File target = new File(Path, fileName);
		
        if ( ! new File(Path).exists()) {
            new File(Path).mkdirs();
        }
        try {
            FileCopyUtils.copy(file.getBytes(), target);
        } catch(Exception e) {
            e.printStackTrace();
        }
		
		return fileName;
		
	}
	
	public void deleteFile(String folder, String fileName) {

		String fullPath = uploadPath + folder + "\\" + fileName;
		System.out.println(fullPath + " / 입니다.");
		File deleteFile = new File(fullPath);
		if (deleteFile.exists()) {
			deleteFile.delete();
		} else {
			System.out.println("파일이 존재하지 않습니다.");
		}
	}
	
}
