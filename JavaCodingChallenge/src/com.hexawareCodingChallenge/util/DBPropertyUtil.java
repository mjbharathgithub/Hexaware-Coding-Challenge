package com.hexareCodingChallenge.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class DBPropertyUtil {
    

	public static String getPropertyString(String fileName) {
		// TODO Auto-generated method stub
		Properties props = new Properties();
        try (FileInputStream fis = new FileInputStream(fileName)) {
            props.load(fis);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String url =  props.getProperty("db.url");
        String user = props.getProperty("db.user");
        String password = props.getProperty("db.password");

        return url+"|"+ user + "|" + password;
		
	}

}
