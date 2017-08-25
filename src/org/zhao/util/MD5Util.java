package org.zhao.util;

import java.util.UUID;

import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;

public class MD5Util {
	private static final String SALT = "中国电信netctoss";

	public static String md5Salt(String password) {
		return DigestUtils.md5Hex(password + SALT);
	}
	
	@Test
	public void testMd5Salt(){
		String token=UUID.randomUUID().toString();
		System.out.println(token);
		String password="123456";
		password=md5Salt(password);
		System.out.println(password);
		//0388bcd06ed58ad068b9a6c1b9b13f8c
	}
}
