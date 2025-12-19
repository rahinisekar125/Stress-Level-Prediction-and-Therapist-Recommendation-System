package com.stress;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {
    private static final String URL = "jdbc:postgresql://ep-super-term-ah3xk0bx-pooler.c-3.us-east-1.aws.neon.tech/neondb?user=neondb_owner&password=npg_5bMXL9tCQOBi&sslmode=require&channelBinding=require";

    static {
        // Ensure PostgreSQL driver is loaded
        try {
            Class.forName("org.postgresql.Driver");
            System.out.println("PostgreSQL driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("Failed to load PostgreSQL driver: " + e.getMessage());
            throw new RuntimeException("PostgreSQL driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL);
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}