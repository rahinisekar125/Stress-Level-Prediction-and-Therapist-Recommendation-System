package com.stress;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {
    private static final String DEFAULT_URL = "jdbc:postgresql://ep-super-term-ah3xk0bx-pooler.c-3.us-east-1.aws.neon.tech/neondb?user=neondb_owner&password=npg_5bMXL9tCQOBi&sslmode=require&channelBinding=require";

    // Get database configuration from environment variables
    private static String getDatabaseUrl() {
        String url = System.getenv("DATABASE_URL");
        return (url != null && !url.trim().isEmpty()) ? url : DEFAULT_URL;
    }

    private static String getDatabaseUsername() {
        String username = System.getenv("DATABASE_USERNAME");
        return (username != null && !username.trim().isEmpty()) ? username : "neondb_owner";
    }

    private static String getDatabasePassword() {
        String password = System.getenv("DATABASE_PASSWORD");
        return (password != null && !password.trim().isEmpty()) ? password : "npg_5bMXL9tCQOBi";
    }

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
        String url = getDatabaseUrl();
        String username = getDatabaseUsername();
        String password = getDatabasePassword();

        System.out.println("Connecting to database with URL: " + url);
        return DriverManager.getConnection(url, username, password);
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