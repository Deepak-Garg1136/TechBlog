package com.techBlog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class ImageHandler {
	public boolean deleteFile(String path) {
		try {
			File file = new File(path);
			return file.delete();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean saveFile(InputStream is, String path) throws IOException{
		try {
			byte[] imageData = new byte[is.available()];
			is.read(imageData);
			
			FileOutputStream fileOutputStream = new FileOutputStream(path);
			fileOutputStream.write(imageData);
			fileOutputStream.flush();
			fileOutputStream.close();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
		
	}
}
