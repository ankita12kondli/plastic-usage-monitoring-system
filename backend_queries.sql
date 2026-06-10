-- ============================================================
-- PLASTIC USAGE MONITORING SYSTEM - BACKEND SQL QUERIES
-- ============================================================
-- This file contains all SQL queries used by the Java backend
-- DAO (Data Access Object) classes
-- ============================================================

-- ============================================================
-- USER DAO QUERIES (UserDAO.java)
-- ============================================================

-- 1. CREATE USER - Register new user
INSERT INTO users (username, email, password_hash, full_name, daily_limit) 
VALUES (?, ?, ?, ?, ?);

-- 2. GET USER BY ID - Retrieve user by user_id
SELECT * FROM users WHERE user_id = ?;

-- 3. GET USER BY USERNAME - Login/authentication lookup
SELECT * FROM users WHERE username = ?;

-- 4. GET USER BY EMAIL - Email-based lookup
SELECT * FROM users WHERE email = ?;

-- 5. AUTHENTICATE USER - Login validation with password hash
SELECT password_hash FROM users WHERE username = ? AND is_active = TRUE;

-- 6. UPDATE LAST LOGIN - Track user login time
UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE user_id = ?;

-- 7. UPDATE USER - Modify user profile/settings
UPDATE users SET username = ?, email = ?, full_name = ?, daily_limit = ?, is_active = ? 
WHERE user_id = ?;

-- 8. CHANGE PASSWORD - Update user password
UPDATE users SET password_hash = ? WHERE user_id = ?;

-- 9. GET ALL USERS - Admin dashboard statistics
SELECT * FROM users ORDER BY created_at DESC;

-- ============================================================
-- PLASTIC USAGE DAO QUERIES (PlasticUsageDAO.java)
-- ============================================================

-- 10. CREATE USAGE - Record new plastic usage (with UPSERT for same day)
INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (?, ?, ?, ?, ?, ?, ?) 
ON DUPLICATE KEY UPDATE 
plastic_bottles = VALUES(plastic_bottles), 
plastic_covers = VALUES(plastic_covers), 
plastic_bags = VALUES(plastic_bags), 
other_plastic_items = VALUES(other_plastic_items), 
notes = VALUES(notes);

-- 11. GET USAGE BY ID - Retrieve specific usage record
SELECT * FROM plastic_usage WHERE usage_id = ?;

-- 12. GET USAGE BY USER AND DATE - Check for existing daily record
SELECT * FROM plastic_usage WHERE user_id = ? AND usage_date = ?;

-- 13. GET USAGE BY USER ID - All records for a user
SELECT * FROM plastic_usage WHERE user_id = ? ORDER BY usage_date DESC;

-- 14. GET USAGE BY DATE RANGE - For reports (weekly/monthly)
SELECT * FROM plastic_usage 
WHERE user_id = ? AND usage_date BETWEEN ? AND ? 
ORDER BY usage_date DESC;

-- 15. GET RECENT USAGE - Limited records for dashboard
SELECT * FROM plastic_usage WHERE user_id = ? ORDER BY usage_date DESC LIMIT ?;

-- 16. UPDATE USAGE - Modify existing usage record
UPDATE plastic_usage 
SET plastic_bottles = ?, plastic_covers = ?, plastic_bags = ?, 
other_plastic_items = ?, notes = ? 
WHERE usage_id = ?;

-- 17. DELETE USAGE - Remove usage record
DELETE FROM plastic_usage WHERE usage_id = ?;

-- 18. GET TOTAL USAGE FOR DATE - Daily summary
SELECT COALESCE(SUM(total_items), 0) as total 
FROM plastic_usage 
WHERE user_id = ? AND usage_date = ?;

-- 19. GET TOTAL USAGE FOR MONTH - Monthly summary
SELECT COALESCE(SUM(total_items), 0) as total 
FROM plastic_usage 
WHERE user_id = ? AND YEAR(usage_date) = ? AND MONTH(usage_date) = ?;

-- ============================================================
-- USAGE ALERT DAO QUERIES (UsageAlertDAO.java)
-- ============================================================

-- 20. CREATE ALERT - Generate new system alert
INSERT INTO usage_alerts (user_id, alert_date, alert_type, message) 
VALUES (?, ?, ?, ?);

-- 21. GET ALERT BY ID - Retrieve specific alert
SELECT * FROM usage_alerts WHERE alert_id = ?;

-- 22. GET ALERTS BY USER ID - All alerts for a user
SELECT * FROM usage_alerts WHERE user_id = ? ORDER BY created_at DESC;

-- 23. GET UNREAD ALERTS - Unread notifications for user
SELECT * FROM usage_alerts 
WHERE user_id = ? AND is_read = FALSE 
ORDER BY created_at DESC;

-- 24. MARK AS READ - Mark single alert as read
UPDATE usage_alerts SET is_read = TRUE WHERE alert_id = ?;

-- 25. MARK ALL AS READ - Clear all unread alerts
UPDATE usage_alerts SET is_read = TRUE 
WHERE user_id = ? AND is_read = FALSE;

-- 26. DELETE ALERT - Remove alert
DELETE FROM usage_alerts WHERE alert_id = ?;

-- 27. GET UNREAD COUNT - Dashboard notification badge
SELECT COUNT(*) as count 
FROM usage_alerts 
WHERE user_id = ? AND is_read = FALSE;

-- ============================================================
-- H2 DATABASE INITIALIZATION QUERIES (DatabaseConnection.java)
-- ============================================================

-- CREATE USERS TABLE - H2 compatible schema
CREATE TABLE IF NOT EXISTS users (
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

-- CREATE PLASTIC USAGE TABLE - H2 compatible schema
CREATE TABLE IF NOT EXISTS plastic_usage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    usage_date DATE NOT NULL,
    plastic_bottles INT DEFAULT 0,
    plastic_covers INT DEFAULT 0,
    plastic_bags INT DEFAULT 0,
    other_plastic_items INT DEFAULT 0,
    total_items INT AS (plastic_bottles + plastic_covers + plastic_bags + other_plastic_items),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_user_date (user_id, usage_date),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- CREATE USAGE ALERTS TABLE - H2 compatible schema
CREATE TABLE IF NOT EXISTS usage_alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    alert_date DATE NOT NULL,
    alert_type VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- INSERT DEFAULT USERS - Demo data
MERGE INTO users (username, email, password_hash, full_name, daily_limit) 
VALUES ('admin', 'admin@plastic.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 20);

MERGE INTO users (username, email, password_hash, full_name, daily_limit) 
VALUES ('john_doe', 'john@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John Doe', 10);

MERGE INTO users (username, email, password_hash, full_name, daily_limit) 
VALUES ('jane_smith', 'jane@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Jane Smith', 15);

-- ============================================================
-- QUERY USAGE BY FEATURE
-- ============================================================

-- AUTHENTICATION FEATURES:
-- - User Login: Query #5 (AUTHENTICATE USER)
-- - Admin Login: Query #5 + username='admin' check
-- - User Registration: Query #1 (CREATE USER)
-- - Password Change: Query #8 (CHANGE PASSWORD)

-- DASHBOARD FEATURES:
-- - Get User Info: Query #3 (GET USER BY USERNAME)
-- - Get Daily Usage: Query #18 (GET TOTAL USAGE FOR DATE)
-- - Get Recent Usage: Query #15 (GET RECENT USAGE)
-- - Get Unread Alerts Count: Query #27 (GET UNREAD COUNT)

-- USAGE ENTRY FEATURES:
-- - Record Usage: Query #10 (CREATE USAGE)
-- - Check Existing: Query #12 (GET USAGE BY USER AND DATE)
-- - Update Usage: Query #16 (UPDATE USAGE)

-- REPORTS FEATURES:
-- - Weekly Report: Query #14 with 7-day date range
-- - Monthly Report: Query #14 with 30-day date range
-- - Monthly Total: Query #19 (GET TOTAL USAGE FOR MONTH)

-- ALERTS FEATURES:
-- - Get User Alerts: Query #22 (GET ALERTS BY USER ID)
-- - Mark as Read: Query #24 (MARK AS READ)
-- - Mark All Read: Query #25 (MARK ALL AS READ)

-- SETTINGS FEATURES:
-- - Get User Settings: Query #3 (GET USER BY USERNAME)
-- - Update Settings: Query #7 (UPDATE USER)

-- ADMIN FEATURES:
-- - Get All Users: Query #9 (GET ALL USERS)
-- - Get User by ID: Query #2 (GET USER BY ID)

-- ============================================================
-- END OF BACKEND QUERIES
-- ============================================================
