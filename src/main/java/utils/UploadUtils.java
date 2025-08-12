package utils;

import java.io.File;
import java.util.UUID;

public class UploadUtils {

	/*
	UUID(Universally Unique IDentifier)
		직역하면 '범용고유식별자' 라고 한다. JDK에서 
		기본적으로 제공되는 클래스로 32자의 영문&숫자를 
		포함한 고유한 문자열을 생성해준다. */
	public static String getUuid() {
		
		String uuid = UUID.randomUUID().toString();
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID : " + uuid);
		return uuid;
	}
	
	//파일명 변경
	 public static String getNewFileName(String originalFileName) {
	        // 확장자 추출
	        String ext = "";
	        int dotIndex = originalFileName.lastIndexOf(".");
	        if (dotIndex != -1) {
	            ext = originalFileName.substring(dotIndex);
	        }
	        // 새 파일명 = UUID + 확장자
	        return getUuid() + ext;
	    }
}
