-- Plastic Usage Monitoring System Database Schema

-- Create database
CREATE DATABASE IF NOT EXISTS plastic_usage_db;
USE plastic_usage_db;

-- Users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    daily_limit INT DEFAULT 10,
    is_active BOOLEAN DEFAULT TRUE
);

-- Plastic usage records table
CREATE TABLE plastic_usage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    usage_date DATE NOT NULL,
    plastic_bottles INT DEFAULT 0,
    plastic_covers INT DEFAULT 0,
    plastic_bags INT DEFAULT 0,
    other_plastic_items INT DEFAULT 0,
    total_items INT GENERATED ALWAYS AS (plastic_bottles + plastic_covers + plastic_bags + other_plastic_items) STORED,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_date (user_id, usage_date)
);

-- Usage alerts table
CREATE TABLE usage_alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    alert_date DATE NOT NULL,
    alert_type VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- User settings table
CREATE TABLE user_settings (
    setting_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    setting_name VARCHAR(50) NOT NULL,
    setting_value VARCHAR(255) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_setting (user_id, setting_name)
);

-- Insert sample data for testing
INSERT INTO users (username, email, password_hash, full_name, daily_limit) VALUES
('admin', 'admin@plastic.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 20),
('john_doe', 'john@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John Doe', 10),
('jane_smith', 'jane@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Jane Smith', 15);

-- Insert sample plastic usage data
INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) VALUES
(2, '2024-01-01', 3, 2, 1, 0, 'Regular grocery shopping'),
(2, '2024-01-02', 2, 1, 2, 1, 'Takeaway food containers'),
(3, '2024-01-01', 1, 3, 0, 2, 'Office supplies'),
(3, '2024-01-02', 4, 2, 3, 0, 'Weekly shopping');

-- Insert sample alerts
INSERT INTO usage_alerts (user_id, alert_date, alert_type, message) VALUES
(2, '2024-01-02', 'DAILY_LIMIT_EXCEEDED', 'You have exceeded your daily plastic usage limit of 10 items. Total items used: 6'),
(3, '2024-01-02', 'DAILY_LIMIT_EXCEEDED', 'You have exceeded your daily plastic usage limit of 15 items. Total items used: 9');

-- Waste collections table
CREATE TABLE IF NOT EXISTS waste_collections (
    collection_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    collection_date DATE NOT NULL,
    plastic_weight_kg DOUBLE DEFAULT 0,
    recyclable_weight_kg DOUBLE DEFAULT 0,
    non_recyclable_weight_kg DOUBLE DEFAULT 0,
    collection_location VARCHAR(100),
    collector_name VARCHAR(100),
    notes TEXT,
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Reduction suggestions table
CREATE TABLE IF NOT EXISTS reduction_suggestions (
    suggestion_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    impact_level VARCHAR(20) NOT NULL,
    estimated_reduction INT DEFAULT 0,
    is_implemented BOOLEAN DEFAULT FALSE,
    created_at DATE NOT NULL,
    implemented_date DATE NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Insert default user settings
INSERT INTO user_settings (user_id, setting_name, setting_value) VALUES
(2, 'email_notifications', 'true'),
(2, 'weekly_reports', 'true'),
(3, 'email_notifications', 'false'),
(3, 'weekly_reports', 'true');
