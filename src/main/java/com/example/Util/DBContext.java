package com.example.Util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    private final static String serverName = "localhost";
    private final static String dbName = "BitesandMore";
    private final static String portNumber = "3306"; 
    private final static String userID = "sa";
    private final static String password = "123456Aa";

    public static Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "/" + dbName + "?useSSL=false&serverTimezone=UTC";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }
}
