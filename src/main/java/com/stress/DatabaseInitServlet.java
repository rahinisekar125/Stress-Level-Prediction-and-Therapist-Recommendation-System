package com.stress;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;

public class DatabaseInitServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            initializeDatabase();
        } catch (Exception e) {
            System.err.println(
                    "Warning: Database initialization failed, but application will continue: " + e.getMessage());
            // Don't throw exception - allow application to start even if DB init fails
        }
    }

    private void initializeDatabase() {
        Connection conn = null;
        Statement stmt = null;

        try {
            conn = DatabaseUtil.getConnection();
            stmt = conn.createStatement();

            // Ensure users table exists and has all required columns
            String createUsersTable = """
                    CREATE TABLE IF NOT EXISTS users (
                        id SERIAL PRIMARY KEY
                    )
                    """;

            // Ensure bookings table exists and has all required columns
            String createBookingsTable = """
                    CREATE TABLE IF NOT EXISTS bookings (
                        id SERIAL PRIMARY KEY
                    )
                    """;

            stmt.execute(createUsersTable);
            stmt.execute(createBookingsTable);

            // Add columns to users table if they don't exist
            String[] usersColumns = {
                    "ALTER TABLE users ADD COLUMN IF NOT EXISTS username VARCHAR(50) UNIQUE",
                    "ALTER TABLE users ADD COLUMN IF NOT EXISTS password VARCHAR(255)",
                    "ALTER TABLE users ADD COLUMN IF NOT EXISTS location VARCHAR(100)",
                    "ALTER TABLE users ADD COLUMN IF NOT EXISTS age INTEGER",
                    "ALTER TABLE users ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
            };

            // Add columns to bookings table if they don't exist
            String[] bookingsColumns = {
                    "ALTER TABLE bookings ADD COLUMN IF NOT EXISTS username VARCHAR(50)",
                    "ALTER TABLE bookings ADD COLUMN IF NOT EXISTS therapist VARCHAR(100)",
                    "ALTER TABLE bookings ADD COLUMN IF NOT EXISTS slot VARCHAR(20)",
                    "ALTER TABLE bookings ADD COLUMN IF NOT EXISTS booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
            };

            // Execute ALTER TABLE statements for users table
            for (String sql : usersColumns) {
                try {
                    stmt.execute(sql);
                } catch (SQLException e) {
                    System.err.println("Warning: Could not add column to users table: " + e.getMessage());
                }
            }

            // Execute ALTER TABLE statements for bookings table
            for (String sql : bookingsColumns) {
                try {
                    stmt.execute(sql);
                } catch (SQLException e) {
                    System.err.println("Warning: Could not add column to bookings table: " + e.getMessage());
                }
            }

            // Add unique constraint to bookings table if it doesn't exist
            try {
                stmt.execute(
                        "ALTER TABLE bookings ADD CONSTRAINT IF NOT EXISTS unique_therapist_slot UNIQUE (therapist, slot)");
            } catch (SQLException e) {
                System.err.println("Warning: Could not add unique constraint to bookings table: " + e.getMessage());
            }

            System.out.println("Database tables initialized/updated successfully!");

        } catch (SQLException e) {
            System.err.println("Error initializing database: " + e.getMessage());
            // Don't throw exception - allow application to start
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            DatabaseUtil.closeConnection(conn);
        }
    }
}