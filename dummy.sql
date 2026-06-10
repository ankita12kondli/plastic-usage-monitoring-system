-- ============================================================
-- PLASTIC USAGE MONITORING SYSTEM - DUMMY DATA
-- ============================================================
-- This file contains sample data for testing and demonstration
-- Run this after schema is created to populate the database
-- ============================================================

-- ============================================================
-- SAMPLE USERS - LOGIN CREDENTIALS
-- ============================================================
-- Password for all users: "password" (hashed with BCrypt)
-- To add new users, copy the pattern below

-- Admin user (full system access)
MERGE INTO users (username, email, password_hash, full_name, daily_limit) 
VALUES ('admin', 'admin@plastic.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 20);

-- Regular users
MERGE INTO users (username, email, password_hash, full_name, daily_limit) 
VALUES ('john_doe', 'john@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John Doe', 10);

MERGE INTO users (username, email, password_hash, full_name, daily_limit) 
VALUES ('jane_smith', 'jane@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Jane Smith', 15);

MERGE INTO users (username, email, password_hash, full_name, daily_limit) 
VALUES ('alice_wong', 'alice@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Alice Wong', 12);

MERGE INTO users (username, email, password_hash, full_name, daily_limit) 
VALUES ('bob_miller', 'bob@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Bob Miller', 8);

MERGE INTO users (username, email, password_hash, full_name, daily_limit) 
VALUES ('carol_white', 'carol@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Carol White', 15);

-- ============================================================
-- LOGIN INFORMATION SUMMARY
-- ============================================================
-- | Username     | Password  | Role       | Daily Limit |
-- |--------------|-----------|------------|-------------|
-- | admin        | password  | Admin      | 20 items    |
-- | john_doe     | password  | User       | 10 items    |
-- | jane_smith   | password  | User       | 15 items    |
-- | alice_wong   | password  | User       | 12 items    |
-- | bob_miller   | password  | User       | 8 items     |
-- | carol_white  | password  | User       | 15 items    |
-- ============================================================

-- ============================================================
-- SAMPLE PLASTIC USAGE DATA
-- ============================================================
-- john_doe usage records (last 7 days)
INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (2, CURRENT_DATE - 1, 3, 2, 1, 0, 'Normal day at work') 
ON DUPLICATE KEY UPDATE plastic_bottles=3, plastic_covers=2, plastic_bags=1, other_plastic_items=0, notes='Normal day at work';

INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (2, CURRENT_DATE - 2, 2, 1, 2, 1, 'Grocery shopping day') 
ON DUPLICATE KEY UPDATE plastic_bottles=2, plastic_covers=1, plastic_bags=2, other_plastic_items=1, notes='Grocery shopping day';

INSERT INTO plastic_usage (user_id, usage_date, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (2, CURRENT_DATE - 3, 4, 0, 1, 2, 'Ordered food delivery') 
ON DUPLICATE KEY UPDATE plastic_bottles=4, plastic_covers=0, plastic_bags=1, other_plastic_items=2, notes='Ordered food delivery';

INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (2, CURRENT_DATE - 4, 1, 1, 0, 0, 'Stayed home, minimal usage') 
ON DUPLICATE KEY UPDATE plastic_bottles=1, plastic_covers=1, plastic_bags=0, other_plastic_items=0, notes='Stayed home, minimal usage';

INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (2, CURRENT_DATE - 5, 5, 3, 2, 1, 'Party at friends place') 
ON DUPLICATE KEY UPDATE plastic_bottles=5, plastic_covers=3, plastic_bags=2, other_plastic_items=1, notes='Party at friends place';

-- jane_smith usage records (eco-friendly user)
INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (3, CURRENT_DATE - 1, 1, 0, 0, 0, 'Used reusable bottles only') 
ON DUPLICATE KEY UPDATE plastic_bottles=1, plastic_covers=0, plastic_bags=0, other_plastic_items=0, notes='Used reusable bottles only';

INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (3, CURRENT_DATE - 2, 0, 1, 0, 0, 'Brought own containers') 
ON DUPLICATE KEY UPDATE plastic_bottles=0, plastic_covers=1, plastic_bags=0, other_plastic_items=0, notes='Brought own containers';

INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (3, CURRENT_DATE - 3, 2, 0, 1, 0, 'Minimal plastic day') 
ON DUPLICATE KEY UPDATE plastic_bottles=2, plastic_covers=0, plastic_bags=1, other_plastic_items=0, notes='Minimal plastic day';

-- alice_wong usage records (moderate user)
INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (4, CURRENT_DATE - 1, 2, 2, 1, 1, 'Regular office day') 
ON DUPLICATE KEY UPDATE plastic_bottles=2, plastic_covers=2, plastic_bags=1, other_plastic_items=1, notes='Regular office day';

INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (4, CURRENT_DATE - 2, 3, 1, 2, 0, 'Takeout lunch and dinner') 
ON DUPLICATE KEY UPDATE plastic_bottles=3, plastic_covers=1, plastic_bags=2, other_plastic_items=0, notes='Takeout lunch and dinner';

-- bob_miller usage records (high usage - will trigger alerts)
INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (5, CURRENT_DATE - 1, 4, 3, 3, 2, 'Multiple deliveries today') 
ON DUPLICATE KEY UPDATE plastic_bottles=4, plastic_covers=3, plastic_bags=3, other_plastic_items=2, notes='Multiple deliveries today';

INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (5, CURRENT_DATE - 2, 5, 2, 4, 1, 'Above daily limit') 
ON DUPLICATE KEY UPDATE plastic_bottles=5, plastic_covers=2, plastic_bags=4, other_plastic_items=1, notes='Above daily limit';

-- carol_white usage records
INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (6, CURRENT_DATE - 1, 2, 1, 1, 1, 'Normal day') 
ON DUPLICATE KEY UPDATE plastic_bottles=2, plastic_covers=1, plastic_bags=1, other_plastic_items=1, notes='Normal day';

INSERT INTO plastic_usage (user_id, usage_date, plastic_bottles, plastic_covers, plastic_bags, other_plastic_items, notes) 
VALUES (6, CURRENT_DATE - 2, 3, 2, 2, 0, 'Shopping day') 
ON DUPLICATE KEY UPDATE plastic_bottles=3, plastic_covers=2, plastic_bags=2, other_plastic_items=0, notes='Shopping day';

-- ============================================================
-- SAMPLE ALERTS DATA
-- ============================================================

-- Alert for john_doe - Daily limit warning
INSERT INTO usage_alerts (user_id, alert_date, alert_type, message, is_read) 
VALUES (2, CURRENT_DATE - 5, 'DAILY_LIMIT', 'You have exceeded your daily plastic limit of 10 items (used 11 items)', FALSE)
ON DUPLICATE KEY UPDATE message='You have exceeded your daily plastic limit of 10 items (used 11 items)', is_read=FALSE;

-- Alert for john_doe - Weekly summary
INSERT INTO usage_alerts (user_id, alert_date, alert_type, message, is_read) 
VALUES (2, CURRENT_DATE - 2, 'WEEKLY_SUMMARY', 'Your weekly plastic usage: 45 items. Try to reduce by 10% next week!', FALSE)
ON DUPLICATE KEY UPDATE message='Your weekly plastic usage: 45 items. Try to reduce by 10% next week!', is_read=FALSE;

-- Alert for bob_miller - Daily limit exceeded (high priority)
INSERT INTO usage_alerts (user_id, alert_date, alert_type, message, is_read) 
VALUES (5, CURRENT_DATE - 1, 'DAILY_LIMIT', 'ALERT: You exceeded your daily limit of 8 items (used 12 items). Consider reducing plastic usage!', FALSE)
ON DUPLICATE KEY UPDATE message='ALERT: You exceeded your daily limit of 8 items (used 12 items). Consider reducing plastic usage!', is_read=FALSE;

-- Alert for bob_miller - Previous day warning
INSERT INTO usage_alerts (user_id, alert_date, alert_type, message, is_read) 
VALUES (5, CURRENT_DATE - 2, 'DAILY_LIMIT', 'You exceeded your daily limit of 8 items (used 12 items)', TRUE)
ON DUPLICATE KEY UPDATE message='You exceeded your daily limit of 8 items (used 12 items)', is_read=TRUE;

-- Alert for jane_smith - Encouragement (low usage)
INSERT INTO usage_alerts (user_id, alert_date, alert_type, message, is_read) 
VALUES (3, CURRENT_DATE - 1, 'ENCOURAGEMENT', 'Great job! You are below your daily limit. Keep up the eco-friendly habits!', FALSE)
ON DUPLICATE KEY UPDATE message='Great job! You are below your daily limit. Keep up the eco-friendly habits!', is_read=FALSE;

-- Alert for alice_wong - Tips
INSERT INTO usage_alerts (user_id, alert_date, alert_type, message, is_read) 
VALUES (4, CURRENT_DATE - 2, 'TIP', 'Tip: Use a reusable water bottle to save approximately 3 plastic bottles per day!', FALSE)
ON DUPLICATE KEY UPDATE message='Tip: Use a reusable water bottle to save approximately 3 plastic bottles per day!', is_read=FALSE;

-- ============================================================
-- DATA STATISTICS AFTER INSERT
-- ============================================================
-- Total Users: 6 (1 admin + 5 regular users)
-- Total Usage Records: 15 records across all users
-- Total Alerts: 6 alerts (mix of warnings and encouragements)
-- Date Range: Last 7 days (CURRENT_DATE - 5 to CURRENT_DATE - 1)
-- ============================================================

-- ============================================================
-- QUICK REFERENCE COMMANDS
-- ============================================================

-- View all users:
-- SELECT * FROM users;

-- View all plastic usage:
-- SELECT * FROM plastic_usage ORDER BY usage_date DESC;

-- View all alerts:
-- SELECT * FROM usage_alerts ORDER BY created_at DESC;

-- View user's daily summary:
-- SELECT u.username, p.usage_date, p.total_items 
-- FROM users u JOIN plastic_usage p ON u.user_id = p.user_id 
-- WHERE u.username = 'john_doe';

-- View unread alerts for user:
-- SELECT * FROM usage_alerts 
-- WHERE user_id = 2 AND is_read = FALSE;

-- Reset all data (WARNING: Deletes everything!):
-- DELETE FROM usage_alerts;
-- DELETE FROM plastic_usage;
-- DELETE FROM users WHERE username != 'admin';

-- ============================================================
-- END OF DUMMY DATA
-- ============================================================
