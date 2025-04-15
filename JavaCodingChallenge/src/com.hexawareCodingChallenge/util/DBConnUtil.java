package com.hexareCodingChallenge.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.hexareCodingChallenge.util.DBPropertyUtil;

public class DBConnUtil {
    
    private static Connection conn;

    public static Connection getConnection() {
        if (conn == null) {
            try {
                String connectionString = DBPropertyUtil.getPropertyString("resources/dataBase.properties");
                String []connectionCredentials= connectionString.split("\\|");
                String url= connectionCredentials[0];
                String user= connectionCredentials[1];
                String password= connectionCredentials[2];
                conn = DriverManager.getConnection(url,user,password);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return conn;
    }
}
