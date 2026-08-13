package com.example.Util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    //  jdbc:sqlserver://localhost:1433;databaseName=BitesandMore;encrypt=true;trustServerCertificate=true
    // Data Source=localhost,1433;Initial Catalog=BitesandMore;User ID=sa;Password=;Pooling=False;Trust Server Certificate=True;Authentication=SqlPassword
    public static Connection getConnection() throws Exception {
        // Cho phép cấu hình bằng biến môi trường khi deploy; fallback giữ tương thích
        // với cấu hình SQL Server local của project.
        String url = value("BITES_DB_URL",
                "jdbc:sqlserver://localhost:1433;databaseName=BitesandMore;trustServerCertificate=true;");
        String user = value("BITES_DB_USER", "sa");
        String password = value("BITES_DB_PASSWORD", "123456Aa@");
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, user, password);
    }

    private static String value(String name, String fallback) {
        String value = System.getenv(name);
        return value == null || value.trim().isEmpty() ? fallback : value.trim();
    }
}
