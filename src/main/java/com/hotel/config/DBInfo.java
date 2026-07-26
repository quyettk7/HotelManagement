package com.hotel.config;

public class DBInfo {

    public static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    public static final String URL =
            "jdbc:sqlserver://localhost:1433;databaseName=HotelManagement;encrypt=true;trustServerCertificate=true";

    public static final String USER = "sa";

    public static final String PASSWORD = "123456";
}