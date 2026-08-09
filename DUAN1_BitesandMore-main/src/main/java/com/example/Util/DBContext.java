package com.example.Util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    //  jdbc:sqlserver://localhost:1433;databaseName=BitesandMore;encrypt=true;trustServerCertificate=true
    // Data Source=localhost,1433;Initial Catalog=BitesandMore;User ID=sa;Password=;Pooling=False;Trust Server Certificate=True;Authentication=SqlPassword
    private final static String serverName = "localhost";
    private final static String dbName = "BitesandMore";
    private final static String portNumber = "1433"; 
    private final static String userID = "sa";
    private final static String password = "123456Aa@";

    public static Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=BitesandMore;user=sa;password=123456Aa@;trustServerCertificate=true;";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }
}