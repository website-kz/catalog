CREATE DATABASE IF NOT EXISTS freelance_portal
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE freelance_portal;

-- 1. Кворки
CREATE TABLE IF NOT EXISTS kworks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  kwork_url VARCHAR(512) NOT NULL,
  category VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Клики по кворкам
CREATE TABLE IF NOT EXISTS kwork_clicks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  kwork_id INT NOT NULL,
  user_ip VARCHAR(45),
  user_agent TEXT,
  clicked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (kwork_id) REFERENCES kworks(id)
);

-- 3. Уведомления (лог, кто получил код FReedoM500)
CREATE TABLE IF NOT EXISTS push_notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_ip VARCHAR(45),
  notification_type VARCHAR(100),
  shown_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Список юзеров (на будущее: авторизация, e-mail, бонусы)
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) UNIQUE,
  password_hash VARCHAR(255),
  role ENUM('client', 'admin') DEFAULT 'client',
  registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Подписки на скидки / обновления
CREATE TABLE IF NOT EXISTS subscriptions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) UNIQUE,
  confirmed BOOLEAN DEFAULT FALSE,
  subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Использование кодов скидок
CREATE TABLE IF NOT EXISTS promo_codes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(50) NOT NULL,
  used_by_ip VARCHAR(45),
  used_by_user_id INT,
  used_at TIMESTAMP,
  FOREIGN KEY (used_by_user_id) REFERENCES users(id)
);

-- 7. Лог событий
CREATE TABLE IF NOT EXISTS system_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  event_type VARCHAR(100),
  source_ip VARCHAR(45),
  payload JSON,
  logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);