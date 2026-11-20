DROP DATABASE IF EXISTS tedxntua_poll;
CREATE DATABASE tedxntua_poll CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tedxntua_poll;

-- Τα 5 θέματα
CREATE TABLE themes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

-- Φάση 1: κάθε ψηφοφόρος διαλέγει 1 έως 3 θέματα
CREATE TABLE votes_phase1 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  voter_id VARCHAR(64) NOT NULL,
  theme_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (theme_id) REFERENCES themes(id),
  UNIQUE (voter_id, theme_id)      -- όχι το ίδιο θέμα δύο φορές
);

-- Φάση 2: κάθε ψηφοφόρος διαλέγει 1 θέμα
CREATE TABLE votes_phase2 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  voter_id VARCHAR(64) NOT NULL UNIQUE,   -- μία ψήφος ανά ψηφοφόρο
  theme_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (theme_id) REFERENCES themes(id)
);

-- Τα θέματα, ακριβώς όπως είναι γραμμένα στο frontend
INSERT INTO themes (name) VALUES
  ('Moires'), ('Anisotropia'), ('Reflect'), ('Cycle 0'), ('Synelixis');
