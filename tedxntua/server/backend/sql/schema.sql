-- Δημιουργία της βάσης με υποστήριξη πλήρους Unicode (ελληνικά, εμότζι κ.λπ.)
CREATE DATABASE IF NOT EXISTS tedxntua
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tedxntua;

-- 1. Όλα τα προτεινόμενα θέματα
CREATE TABLE themes (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(100) NOT NULL UNIQUE,            -- το όνομα του θέματος (μοναδικό)
  description TEXT NULL,                               -- προαιρετική περιγραφή
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP      -- πότε προστέθηκε
);

-- 2. Φάσεις ψηφοφορίας (πάντα ακριβώς 2 γραμμές)
CREATE TABLE phases (
  id        TINYINT PRIMARY KEY,                       -- 1 ή 2
  name      VARCHAR(50) NOT NULL,
  status    ENUM('pending','open','closed') NOT NULL DEFAULT 'pending',  -- σε αναμονή / ανοιχτή / κλειστή
  max_votes TINYINT NOT NULL DEFAULT 3,                -- πόσα θέματα μπορεί να επιλέξει κάθε ψηφοφόρος
  opens_at  DATETIME NULL,                             -- προαιρετική ώρα έναρξης
  closes_at DATETIME NULL,                             -- προαιρετική ώρα λήξης
  CHECK (id IN (1, 2))                                 -- επιτρέπονται μόνο οι φάσεις 1 και 2
);

-- Αρχικές τιμές: στη φάση 1 έως 3 επιλογές, στη φάση 2 μόνο 1
INSERT INTO phases (id, name, max_votes) VALUES
  (1, 'Фаза 1: усі теми', 3),
  (2, 'Фаза 2: фінал',    1);

-- 3. Ποια θέματα συμμετέχουν σε ποια φάση
CREATE TABLE phase_themes (
  phase_id TINYINT NOT NULL,
  theme_id INT NOT NULL,
  PRIMARY KEY (phase_id, theme_id),                    -- ένα θέμα μία φορά ανά φάση
  FOREIGN KEY (phase_id) REFERENCES phases(id),
  FOREIGN KEY (theme_id) REFERENCES themes(id) ON DELETE CASCADE  -- αν διαγραφεί το θέμα, φεύγει και από τις φάσεις
);

-- 4. Ψήφοι
CREATE TABLE votes (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  phase_id   TINYINT NOT NULL,
  theme_id   INT NOT NULL,
  voter_id   VARCHAR(64) NOT NULL,                     -- αναγνωριστικό ψηφοφόρου (email / token / cookie, θα το αποφασίσετε)
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_vote (phase_id, voter_id, theme_id),   -- ο ίδιος ψηφοφόρος δεν ψηφίζει το ίδιο θέμα δύο φορές στην ίδια φάση
  -- επιτρέπεται ψήφος μόνο για θέμα που συμμετέχει στη συγκεκριμένη φάση:
  FOREIGN KEY (phase_id, theme_id) REFERENCES phase_themes(phase_id, theme_id)
);

-- 5. Το τελικό θέμα (το πολύ μία γραμμή)
CREATE TABLE final_theme (
  id        TINYINT PRIMARY KEY DEFAULT 1,
  theme_id  INT NOT NULL,
  chosen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,       -- πότε επιλέχθηκε
  FOREIGN KEY (theme_id) REFERENCES themes(id),
  CHECK (id = 1)                                       -- εξασφαλίζει ότι υπάρχει μόνο μία γραμμή
);

-- 6. Αποτελέσματα ανά φάση (προβολή: πλήθος ψήφων για κάθε θέμα)
CREATE VIEW phase_results AS
SELECT pt.phase_id, t.id AS theme_id, t.name, COUNT(v.id) AS votes
FROM phase_themes pt
JOIN themes t ON t.id = pt.theme_id
LEFT JOIN votes v ON v.phase_id = pt.phase_id AND v.theme_id = pt.theme_id  -- LEFT JOIN: εμφανίζονται και θέματα με 0 ψήφους
GROUP BY pt.phase_id, t.id, t.name;

-- 7. Προστασία σε επίπεδο βάσης: η φάση πρέπει να είναι ανοιχτή και να μην ξεπερνιέται το όριο ψήφων
DELIMITER $$
CREATE TRIGGER trg_votes_before_insert
BEFORE INSERT ON votes
FOR EACH ROW
BEGIN
  DECLARE v_status VARCHAR(10);   -- κατάσταση της φάσης
  DECLARE v_max TINYINT;          -- μέγιστος αριθμός ψήφων ανά ψηφοφόρο
  DECLARE v_cnt INT;              -- πόσες ψήφους έχει ήδη δώσει ο ψηφοφόρος

  SELECT status, max_votes INTO v_status, v_max FROM phases WHERE id = NEW.phase_id;

  -- Έλεγχος 1: η φάση πρέπει να είναι ανοιχτή
  IF v_status <> 'open' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Phase is not open';
  END IF;

  -- Έλεγχος 2: ο ψηφοφόρος δεν έχει φτάσει ήδη το όριο
  SELECT COUNT(*) INTO v_cnt FROM votes
   WHERE phase_id = NEW.phase_id AND voter_id = NEW.voter_id;
  IF v_cnt >= v_max THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Vote limit reached';
  END IF;
END$$
DELIMITER ;