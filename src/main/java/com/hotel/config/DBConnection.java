package com.hotel.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {

        try {

            Class.forName(DBInfo.DRIVER);

            return DriverManager.getConnection(
                    DBInfo.URL,
                    DBInfo.USER,
                    DBInfo.PASSWORD
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}