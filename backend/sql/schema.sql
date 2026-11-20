CREATE DATABASE IF NOT EXISTS tedxntua_poll;
USE tedxntua_poll;

CREATE TABLE polls (
  id INT AUTO_INCREMENT PRIMARY KEY,
  question VARCHAR(255) NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE options (
  id INT AUTO_INCREMENT PRIMARY KEY,
  poll_id INT NOT NULL,
  text VARCHAR(255) NOT NULL,
  FOREIGN KEY (poll_id) REFERENCES polls(id) ON DELETE CASCADE
);

CREATE TABLE votes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  poll_id INT NOT NULL,
  option_id INT NOT NULL,
  voter_id VARCHAR(64) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (poll_id) REFERENCES polls(id) ON DELETE CASCADE,
  FOREIGN KEY (option_id) REFERENCES options(id) ON DELETE CASCADE,
  UNIQUE (poll_id, voter_id)
);

INSERT INTO polls (question) VALUES ('Ποιο θέμα θέλετε για το TEDxNTUA 2027;');
INSERT INTO options (poll_id, text) VALUES (1,'Τεχνολογία'),(1,'Περιβάλλον'),(1,'Τέχνη');
