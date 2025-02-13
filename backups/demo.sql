SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
SET NAMES utf8mb4;

-- Usuwanie istniejących tabel (wyłączenie kontroli kluczy obcych)
SET foreign_key_checks = 0;
DROP TABLE IF EXISTS `message_link`;
DROP TABLE IF EXISTS `message`;
DROP TABLE IF EXISTS `file_to_auction`;
DROP TABLE IF EXISTS `currency`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `auctions`;
DROP TABLE IF EXISTS `accounts`;
DROP TABLE IF EXISTS `type`;
SET foreign_key_checks = 1;

-- Tworzenie tabel
CREATE TABLE `accounts` (
  `accountid` int(11) NOT NULL,
  `login` varchar(100) NOT NULL,
  `password` varchar(250) NOT NULL,
  `registerdate` date NOT NULL DEFAULT current_timestamp(),
  `account_type` varchar(3) NOT NULL DEFAULT '222',
  `verified` tinyint(1) NOT NULL,
  `whover` int(3) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(150) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `phone` varchar(9) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `codezip` varchar(6) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `auctions` (
  `auctionid` int(11) NOT NULL,
  `accountid` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `used` tinyint(1) DEFAULT 0,
  `private` tinyint(1) DEFAULT 0,
  `date_start` date DEFAULT current_timestamp(),
  `date_end` date DEFAULT NULL,
  `veryfied` int(1) NOT NULL DEFAULT 0,
  `whover` int(3) NOT NULL,
  `selled` tinyint(1) DEFAULT 0,
  `buyerid` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `currencyid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `category` (
  `categoryid` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `in_tree` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `currency` (
  `currencyid` int(10) NOT NULL,
  `currency_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `file_to_auction` (
  `file_id` int(11) NOT NULL,
  `auctionid` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `mlid` int(11) NOT NULL,
  `auctionid` int(11) NOT NULL,
  `buyerid` int(3) NOT NULL,
  `answer` tinyint(1) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `message_link` (
  `mlid` int(11) NOT NULL,
  `auctionid` int(11) NOT NULL,
  `sellerid` int(11) NOT NULL,
  `buyerid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `type` (
  `type_id` varchar(3) NOT NULL,
  `type_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Ustawienie kluczy głównych
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`accountid`);

ALTER TABLE `auctions`
  ADD PRIMARY KEY (`auctionid`);

ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryid`);

ALTER TABLE `currency`
  ADD PRIMARY KEY (`currencyid`);

ALTER TABLE `file_to_auction`
  ADD PRIMARY KEY (`file_id`),
  ADD KEY `auctionid` (`auctionid`);

ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `auctionid` (`auctionid`);

ALTER TABLE `message_link`
  ADD PRIMARY KEY (`mlid`),
  ADD KEY `auctionid` (`auctionid`),
  ADD KEY `sellerid` (`sellerid`),
  ADD KEY `buyerid` (`buyerid`);

ALTER TABLE `type`
  ADD PRIMARY KEY (`type_id`);

-- Ustawienie AUTO_INCREMENT
ALTER TABLE `accounts`
  MODIFY `accountid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

ALTER TABLE `auctions`
  MODIFY `auctionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

ALTER TABLE `category`
  MODIFY `categoryid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `currency`
  MODIFY `currencyid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `file_to_auction`
  MODIFY `file_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

ALTER TABLE `message_link`
  MODIFY `mlid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

-- Dodanie ograniczeń kluczy obcych
ALTER TABLE `file_to_auction`
  ADD CONSTRAINT `file_to_auction_ibfk_1` FOREIGN KEY (`auctionid`) REFERENCES `auctions` (`auctionid`) ON DELETE CASCADE;

ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`auctionid`) REFERENCES `auctions` (`auctionid`) ON DELETE CASCADE;

ALTER TABLE `message_link`
  ADD CONSTRAINT `message_link_ibfk_1` FOREIGN KEY (`auctionid`) REFERENCES `auctions` (`auctionid`) ON DELETE CASCADE,
  ADD CONSTRAINT `message_link_ibfk_2` FOREIGN KEY (`sellerid`) REFERENCES `accounts` (`accountid`),
  ADD CONSTRAINT `message_link_ibfk_3` FOREIGN KEY (`buyerid`) REFERENCES `accounts` (`accountid`);

ALTER TABLE `accounts`
  ADD CONSTRAINT `fk_accounts_type` FOREIGN KEY (`account_type`) REFERENCES `type` (`type_id`);

ALTER TABLE `auctions`
  ADD CONSTRAINT `fk_auctions_currency` FOREIGN KEY (`currencyid`) REFERENCES `currency` (`currencyid`);

ALTER TABLE `auctions`
  ADD CONSTRAINT `fk_auctions_category` FOREIGN KEY (`categoryid`) REFERENCES `category` (`categoryid`);

ALTER TABLE `message`
  ADD CONSTRAINT `fk_message_buyer` FOREIGN KEY (`buyerid`) REFERENCES `accounts` (`accountid`);

ALTER TABLE `auctions`
  ADD CONSTRAINT `fk_auctions_account` FOREIGN KEY (`accountid`) REFERENCES `accounts` (`accountid`);

ALTER TABLE `auctions`
  ADD CONSTRAINT `fk_auctions_whover` FOREIGN KEY (`whover`) REFERENCES `accounts` (`accountid`);

-- Samoodwołujący klucz obcy w tabeli accounts dla kolumny whover
ALTER TABLE `accounts`
  ADD CONSTRAINT `fk_accounts_whover` FOREIGN KEY (`whover`) REFERENCES `accounts` (`accountid`);



-- Tabela typów kont (role użytkowników)
INSERT INTO `type` (type_id, type_name) VALUES
  ('101', 'administrator'),
  ('222', 'user'),
  ('444', 'moderator');

-- Tabela walut
INSERT INTO `currency` (currencyid, currency_name) VALUES
  (1, 'PLN'),
  (2, 'EUR');

-- Tabela kategorii (6 przykładowych)
INSERT INTO `category` (categoryid, name, in_tree) VALUES
  (1, 'Elektronika', 0),
  (2, 'Książki', 0),
  (3, 'Meble', 0),
  (4, 'Odzież', 0),
  (5, 'Sport', 0),
  (6, 'Motoryzacja', 0);

-- Tabela użytkowników (10 kont: admin, mod oraz 8 użytkowników)
INSERT INTO `accounts` (accountid, login, password, registerdate, account_type, verified, whover, firstname, lastname, email, phone, address, codezip, city, country)
VALUES
  (1, 'admin', 'admin', '2025-10-01', '101', 1, 1, 'Admin', 'Istrator', 'admin@example.com', '123456789', 'Ul. Admina 1', '00-001', 'Warszawa', 'Polska'),
  (2, 'mod', 'mod', '2025-10-02', '444', 1, 1, 'Mod', 'Erator', 'mod@example.com', '234567890', 'Ul. Modera 2', '00-002', 'Kraków', 'Polska'),
  (3, 'user1', 'user1', '2025-10-03', '222', 1, 2, 'Jan', 'Kowalski', 'jan.kowalski@example.com', '345678901', 'Ul. Kwiatowa 3', '00-003', 'Poznań', 'Polska'),
  (4, 'user2', 'user2', '2025-10-04', '222', 1, 2, 'Anna', 'Nowak', 'anna.nowak@example.com', '456789012', 'Ul. Słoneczna 4', '00-004', 'Gdańsk', 'Polska'),
  (5, 'user3', 'user3', '2025-10-05', '222', 1, 2, 'Piotr', 'Wiśniewski', 'piotr.w@example.com', '567890123', 'Ul. Leśna 5', '00-005', 'Wrocław', 'Polska'),
  (6, 'user4', 'user4', '2025-10-06', '222', 1, 2, 'Katarzyna', 'Zielińska', 'katarzyna.z@example.com', '678901234', 'Ul. Morska 6', '00-006', 'Łódź', 'Polska'),
  (7, 'user5', 'user5', '2025-10-07', '222', 1, 2, 'Marek', 'Lewandowski', 'marek.l@example.com', '789012345', 'Ul. Piękna 7', '00-007', 'Sopot', 'Polska'),
  (8, 'user6', 'user6', '2025-10-08', '222', 1, 2, 'Ewa', 'Kowalczyk', 'ewa.k@example.com', '890123456', 'Ul. Radosna 8', '00-008', 'Lublin', 'Polska'),
  (9, 'user7', 'user7', '2025-10-09', '222', 1, 2, 'Tomasz', 'Wojciechowski', 'tomasz.w@example.com', '901234567', 'Ul. Spacerowa 9', '00-009', 'Katowice', 'Polska'),
  (10, 'user8', 'user8', '2025-10-10', '222', 1, 2, 'Magdalena', 'Krawczyk', 'magdalena.k@example.com', '012345678', 'Ul. Polna 10', '00-010', 'Łódź', 'Polska');

-- Tabela aukcji
-- Przyjmujemy, że aukcje wystawiają tylko użytkownicy z kontem '222'
-- Aukcje zakończone (4 aukcje): sprzedawcy: konta 3,4,5,6 – kupujący wybrani z pozostałych
-- Aukcja niezweryfikowana (1 aukcja): sprzedawca: konto 7
-- Aukcje trwające (3 aukcje): sprzedawcy: konta 8,9,10
INSERT INTO `auctions` (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid)
VALUES
  -- Aukcje zakończone – daty: start w październiku, zakończenie w listopadzie 2025
  (1, 3, 1, 'Używany smartfon Samsung Galaxy A10', 'Smartfon w dobrym stanie, lekko używany, działa bez zarzutu. Idealny dla studenta.', 1, 0, '2025-10-15', '2025-11-15', 1, 2, 1, 8, 299.0, 1),
  (2, 4, 2, 'Kolekcja podręczników do matematyki', 'Zestaw podręczników używanych, w dobrym stanie. Świetny wybór dla studentów.', 1, 0, '2025-10-16', '2025-11-16', 1, 2, 1, 9, 150.0, 1),
  (3, 5, 3, 'Biurko studenckie', 'Solidne biurko idealne do nauki i pracy. Minimalne ślady użytkowania.', 1, 0, '2025-10-17', '2025-11-17', 1, 2, 1, 10, 200.0, 1),
  (4, 6, 4, 'Kurtka zimowa', 'Ciepła kurtka zimowa, idealna na chłodne dni. Lekko używana.', 1, 0, '2025-10-18', '2025-11-18', 1, 2, 1, 7, 120.0, 1),
  -- Aukcja niezweryfikowana – sprzedawca: konto 7
  (5, 7, 5, 'Rower górski', 'Rower górski w stanie do odnowienia. Niezweryfikowana aukcja, cena do negocjacji.', 1, 0, '2025-10-19', '2025-11-19', 0, 2, 0, NULL, 250.0, 1),
  -- Aukcje trwające – daty zakończenia w grudniu 2025
  (6, 8, 6, 'Skuter miejski', 'Mały skuter miejski, idealny do poruszania się po mieście. Aukcja zweryfikowana i wciąż trwająca.', 1, 0, '2025-10-20', '2025-12-20', 1, 2, 0, NULL, 1200.0, 1),
  (7, 9, 2, 'Zestaw książek do programowania', 'Nowoczesne książki z programowania, idealne dla studentów informatyki. Aukcja zweryfikowana.', 1, 0, '2025-10-21', '2025-12-21', 1, 2, 0, NULL, 80.0, 1),
  (8, 10, 3, 'Krzesło biurowe', 'Ergonomiczne krzesło biurowe, komfortowe do długich godzin nauki. Aukcja zweryfikowana.', 0, 0, '2025-10-22', '2025-12-22', 1, 2, 0, NULL, 90.0, 2);

-- Tabela zdjęć – do każdej aukcji wstawiamy jeden rekord
INSERT INTO `file_to_auction` (file_id, auctionid, filename, file_path) VALUES
  (1, 1, 'photo_auction1.jpg', 'images/photo_auction1.jpg'),
  (2, 2, 'photo_auction2.jpg', 'images/photo_auction2.jpg'),
  (3, 3, 'photo_auction3.jpg', 'images/photo_auction3.jpg'),
  (4, 4, 'photo_auction4.jpg', 'images/photo_auction4.jpg'),
  (5, 5, 'photo_auction5.jpg', 'images/photo_auction5.jpg'),
  (6, 6, 'photo_auction6.jpg', 'images/photo_auction6.jpg'),
  (7, 7, 'photo_auction7.jpg', 'images/photo_auction7.jpg'),
  (8, 8, 'photo_auction8.jpg', 'images/photo_auction8.jpg');

-- Tabela linków wiadomości – dla aukcji, do których prowadzona jest korespondencja
-- Dla aukcji zakończonych (auctionid 1,2,3,4) oraz trwających (auctionid 6,7,8)
INSERT INTO `message_link` (mlid, auctionid, sellerid, buyerid) VALUES
  (1, 1, 3, 8),
  (2, 2, 4, 9),
  (3, 3, 5, 10),
  (4, 4, 6, 7),
  (5, 6, 8, 4),
  (6, 7, 9, 5),
  (7, 8, 10, 6);

-- Tabela wiadomości
-- A) Dla aukcji zakończonych – rozmowy składają się z 6 wiadomości (kupujący: answer=0, sprzedający: answer=1)
-- Aukcja 1 (auctionid=1, mlid=1, cena = 299.0 PLN)
INSERT INTO `message` (id, mlid, auctionid, buyerid, answer, date, description) VALUES
  (1, 1, 1, 8, 0, '2025-11-10 10:00:00', 'Dzień dobry, czy smartfon jest w pełni sprawny?'),
  (2, 1, 1, 8, 1, '2025-11-10 10:05:00', 'Dzień dobry, tak, telefon działa bez zarzutu.'),
  (3, 1, 1, 8, 0, '2025-11-10 10:10:00', 'Czy mógłby Pan sprzedać go za 224 zł?'),
  (4, 1, 1, 8, 1, '2025-11-10 10:15:00', 'Przykro mi, ale cena jest zbyt niska.'),
  (5, 1, 1, 8, 1, '2025-11-10 10:20:00', 'Mogę zaproponować cenę 269 zł.'),
  (6, 1, 1, 8, 0, '2025-11-10 10:25:00', 'Dziękuję, zgadzam się na tę cenę. Proszę o dalsze instrukcje.'),

  -- Aukcja 2 (auctionid=2, mlid=2, cena = 150.0 PLN)
  (7, 2, 2, 9, 0, '2025-11-11 11:00:00', 'Witam, czy podręczniki są kompletne i czytelne?'),
  (8, 2, 2, 9, 1, '2025-11-11 11:05:00', 'Witam, tak, wszystkie książki są w dobrym stanie.'),
  (9, 2, 2, 9, 0, '2025-11-11 11:10:00', 'Czy mogłyby być sprzedane za 112 zł?'),
  (10, 2, 2, 9, 1, '2025-11-11 11:15:00', 'Cena 112 zł jest za niska.'),
  (11, 2, 2, 9, 1, '2025-11-11 11:20:00', 'Proponuję 135 zł jako ostateczną cenę.'),
  (12, 2, 2, 9, 0, '2025-11-11 11:25:00', 'Dziękuję, akceptuję proponowaną cenę.'),

  -- Aukcja 3 (auctionid=3, mlid=3, cena = 200.0 PLN)
  (13, 3, 3, 10, 0, '2025-11-12 12:00:00', 'Cześć, czy biurko jest stabilne i bez uszkodzeń?'),
  (14, 3, 3, 10, 1, '2025-11-12 12:05:00', 'Cześć, biurko jest w bardzo dobrym stanie, bez żadnych uszkodzeń.'),
  (15, 3, 3, 10, 0, '2025-11-12 12:10:00', 'Czy sprzeda Pan biurko za 150 zł?'),
  (16, 3, 3, 10, 1, '2025-11-12 12:15:00', 'Niestety, cena 150 zł jest zbyt niska.'),
  (17, 3, 3, 10, 1, '2025-11-12 12:20:00', 'Mogę zaoferować cenę 180 zł.'),
  (18, 3, 3, 10, 0, '2025-11-12 12:25:00', 'Dziękuję, zgadzam się na 180 zł.'),

  -- Aukcja 4 (auctionid=4, mlid=4, cena = 120.0 PLN)
  (19, 4, 4, 7, 0, '2025-11-13 13:00:00', 'Dzień dobry, czy kurtka jest jeszcze dostępna?'),
  (20, 4, 4, 7, 1, '2025-11-13 13:05:00', 'Dzień dobry, kurtka jest dostępna i w dobrym stanie.'),
  (21, 4, 4, 7, 0, '2025-11-13 13:10:00', 'Czy sprzeda Pan kurtkę za 90 zł?'),
  (22, 4, 4, 7, 1, '2025-11-13 13:15:00', 'Proponowana cena 90 zł jest zbyt niska.'),
  (23, 4, 4, 7, 1, '2025-11-13 13:20:00', 'Mogę zaoferować kurtkę za 108 zł.'),
  (24, 4, 4, 7, 0, '2025-11-13 13:25:00', 'Zgadzam się na 108 zł, dziękuję.'),

  -- B) Dla aukcji trwających – rozmowy składają się z 3 wiadomości
  -- Aukcja 6 (auctionid=6, mlid=5)
  (25, 5, 6, 4, 0, '2025-11-14 14:00:00', 'Witam, czy skuter jest nadal dostępny?'),
  (26, 5, 6, 4, 1, '2025-11-14 14:05:00', 'Tak, skuter jest dostępny.'),
  (27, 5, 6, 4, 0, '2025-11-14 14:10:00', 'Dziękuję za informację, rozważę zakup.'),

  -- Aukcja 7 (auctionid=7, mlid=6)
  (28, 6, 7, 5, 0, '2025-11-15 15:00:00', 'Cześć, czy książki są jeszcze dostępne?'),
  (29, 6, 7, 5, 1, '2025-11-15 15:05:00', 'Cześć, książki są dostępne, można je obejrzeć na miejscu.'),
  (30, 6, 7, 5, 0, '2025-11-15 15:10:00', 'Dzięki za informację, zastanowię się.'),

  -- Aukcja 8 (auctionid=8, mlid=7, aukcja w EUR)
  (31, 7, 8, 6, 0, '2025-11-16 16:00:00', 'Dzień dobry, czy krzesło jest wygodne i solidne?'),
  (32, 7, 8, 6, 1, '2025-11-16 16:05:00', 'Dzień dobry, krzesło jest bardzo wygodne i idealne do długiej pracy przy biurku.'),
  (33, 7, 8, 6, 0, '2025-11-16 16:10:00', 'Dziękuję za odpowiedź, rozważę zakup.');
  
COMMIT;
