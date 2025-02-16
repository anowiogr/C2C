START TRANSACTION;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `message_link`;
DROP TABLE IF EXISTS `message`;
DROP TABLE IF EXISTS `file_to_auction`;
DROP TABLE IF EXISTS `auctions`;
DROP TABLE IF EXISTS `accounts`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `currency`;
DROP TABLE IF EXISTS `type`;
SET FOREIGN_KEY_CHECKS = 1;


-- Utworzenie tabeli accounts
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

-- Utworzenie tabeli auctions
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

-- Utworzenie tabeli category
CREATE TABLE `category` (
  `categoryid` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `in_tree` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Utworzenie tabeli currency
CREATE TABLE `currency` (
  `currencyid` int(10) NOT NULL,
  `currency_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Utworzenie tabeli file_to_auction
CREATE TABLE `file_to_auction` (
  `file_id` int(11) NOT NULL,
  `auctionid` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Utworzenie tabeli message
CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `mlid` int(11) NOT NULL,
  `auctionid` int(11) NOT NULL,
  `buyerid` int(3) NOT NULL,
  `answer` tinyint(1) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Utworzenie tabeli message_link
CREATE TABLE `message_link` (
  `mlid` int(11) NOT NULL,
  `auctionid` int(11) NOT NULL,
  `sellerid` int(11) NOT NULL,
  `buyerid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Utworzenie tabeli type
CREATE TABLE `type` (
  `type_id` varchar(3) NOT NULL,
  `type_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Ustawienie kluczy głównych
ALTER TABLE accounts
  ADD PRIMARY KEY (accountid);

ALTER TABLE auctions
  ADD PRIMARY KEY (auctionid);

ALTER TABLE category
  ADD PRIMARY KEY (categoryid);

ALTER TABLE currency
  ADD PRIMARY KEY (currencyid);

ALTER TABLE file_to_auction
  ADD PRIMARY KEY (file_id),
  ADD KEY auctionid (auctionid);

ALTER TABLE message
  ADD PRIMARY KEY (id),
  ADD KEY auctionid (auctionid);

ALTER TABLE message_link
  ADD PRIMARY KEY (mlid),
  ADD KEY auctionid (auctionid),
  ADD KEY sellerid (sellerid),
  ADD KEY buyerid (buyerid);

ALTER TABLE type
  ADD PRIMARY KEY (type_id);

-- Ustawienie AUTO_INCREMENT
ALTER TABLE accounts
  MODIFY accountid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE auctions
  MODIFY auctionid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

ALTER TABLE category
  MODIFY categoryid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE currency
  MODIFY currencyid int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE file_to_auction
  MODIFY file_id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE message
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE message_link
  MODIFY mlid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

-- Dodanie ograniczeń kluczy obcych (zakomentowane zgodnie z wymaganiami)
/*
-- Dodanie ograniczeń kluczy obcych
ALTER TABLE file_to_auction
  ADD CONSTRAINT file_to_auction_ibfk_1 FOREIGN KEY (auctionid) REFERENCES auctions (auctionid) ON DELETE CASCADE;

ALTER TABLE message
  ADD CONSTRAINT message_ibfk_1 FOREIGN KEY (auctionid) REFERENCES auctions (auctionid) ON DELETE CASCADE;

ALTER TABLE message_link
  ADD CONSTRAINT message_link_ibfk_1 FOREIGN KEY (auctionid) REFERENCES auctions (auctionid) ON DELETE CASCADE,
  ADD CONSTRAINT message_link_ibfk_2 FOREIGN KEY (sellerid) REFERENCES accounts (accountid),
  ADD CONSTRAINT message_link_ibfk_3 FOREIGN KEY (buyerid) REFERENCES accounts (accountid);

ALTER TABLE accounts
  ADD CONSTRAINT fk_accounts_type FOREIGN KEY (account_type) REFERENCES type (type_id);

ALTER TABLE auctions
  ADD CONSTRAINT fk_auctions_currency FOREIGN KEY (currencyid) REFERENCES currency (currencyid);

ALTER TABLE auctions
  ADD CONSTRAINT fk_auctions_category FOREIGN KEY (categoryid) REFERENCES category (categoryid);

ALTER TABLE message
  ADD CONSTRAINT fk_message_buyer FOREIGN KEY (buyerid) REFERENCES accounts (accountid);

ALTER TABLE auctions
  ADD CONSTRAINT fk_auctions_account FOREIGN KEY (accountid) REFERENCES accounts (accountid);

ALTER TABLE auctions
  ADD CONSTRAINT fk_auctions_whover FOREIGN KEY (whover) REFERENCES accounts (accountid);

-- Samoodwołujący klucz obcy w tabeli accounts dla kolumny whover
ALTER TABLE accounts
  ADD CONSTRAINT fk_accounts_whover FOREIGN KEY (whover) REFERENCES accounts (accountid);
*/
COMMIT;

-- ----------------------------------------------------------
-- Poniżej rozpoczynamy wstawianie przykładowych danych.
-- Całość operacji odbywa się wewnątrz TRANSACTION.

START TRANSACTION;

-- ----------------------------------------
-- Dane dla tabeli type (poziomy użytkowników)
INSERT INTO type (type_id, type_name) VALUES
('101', 'Administrator'),
('222', 'Użytkownik');

-- ----------------------------------------
-- Dane dla tabeli currency

INSERT INTO currency (currencyid, currency_name) VALUES
(1, 'PLN'),
(2, 'EUR');

-- ----------------------------------------
-- Dane dla tabeli category

INSERT INTO category (categoryid, name, in_tree) VALUES
(1, 'Elektronika', 0),
(2, 'Meble', 0),
(3, 'Rowery', 0),
(4, 'Podręczniki', 0),
(5, 'Sport i Rekreacja', 0),
(6, 'Gry i Konsole', 0);

-- ----------------------------------------
-- Dane dla tabeli accounts

INSERT INTO accounts (accountid, login, password, registerdate, account_type, verified, whover, firstname, lastname, email, phone, address, codezip, city, country) VALUES
(1, 'admin', '$argon2id$v=19$m=65536,t=4,p=1$admin$admin', '2024-09-10', '101', 1, 0, 'Admin', 'Adminowski', 'admin@example.com', '111111111', 'ul. Centrum 1', '00-001', 'Warszawa', 'Polska'),
(2, 'mod', '$argon2id$v=19$m=65536,t=4,p=1$mod$mod', '2024-09-11', '222', 1, 1, 'Marek', 'Moderator', 'mod@example.com', '222222222', 'ul. Moderatorów 2', '00-002', 'Kraków', 'Polska'),
(3, 'Kazimierz12', '$argon2id$v=19$m=65536,t=4,p=1$Kazimierz12$Kazimierz12', '2024-09-12', '222', 1, 2, 'Kazimierz', 'Nowak', 'kazimierz12@example.com', '333333333', 'ul. Stara 3', '12-345', 'Kielce', 'Polska'),
(4, 'Władysław34', '$argon2id$v=19$m=65536,t=4,p=1$Władysław34$Władysław34', '2024-09-13', '222', 1, 2, 'Władysław', 'Kowalski', 'wladyslaw34@example.com', '444444444', 'ul. Młoda 4', '23-456', 'Lublin', 'Polska'),
(5, 'Zbigniew56', '$argon2id$v=19$m=65536,t=4,p=1$Zbigniew56$Zbigniew56', '2024-09-14', '222', 1, 2, 'Zbigniew', 'Wiśniewski', 'zbigniew56@example.com', '555555555', 'ul. Nowa 5', '34-567', 'Poznań', 'Polska'),
(6, 'Stanisław78', '$argon2id$v=19$m=65536,t=4,p=1$Stanisław78$Stanisław78', '2024-09-15', '222', 1, 2, 'Stanisław', 'Wójcik', 'stanislaw78@example.com', '666666666', 'ul. Krótka 6', '45-678', 'Gdańsk', 'Polska'),
(7, 'Janusz90', '$argon2id$v=19$m=65536,t=4,p=1$Janusz90$Janusz90', '2024-09-16', '222', 1, 2, 'Janusz', 'Kamiński', 'janusz90@example.com', '777777777', 'ul. Długa 7', '56-789', 'Wrocław', 'Polska'),
(8, 'Bogdan23', '$argon2id$v=19$m=65536,t=4,p=1$Bogdan23$Bogdan23', '2024-09-17', '222', 1, 2, 'Bogdan', 'Lewandowski', 'bogdan23@example.com', '888888888', 'ul. Piękna 8', '67-890', 'Szczecin', 'Polska'),
(9, 'Mieczysław45', '$argon2id$v=19$m=65536,t=4,p=1$Mieczysław45$Mieczysław45', '2024-09-18', '222', 1, 2, 'Mieczysław', 'Zieliński', 'mieczyslaw45@example.com', '999999999', 'ul. Leśna 9', '78-901', 'Katowice', 'Polska'),
(10, 'Czesław67', '$argon2id$v=19$m=65536,t=4,p=1$Czesław67$Czesław67', '2024-09-19', '222', 1, 2, 'Czesław', 'Szymański', 'czeslaw67@example.com', '101010101', 'ul. Szkolna 10', '89-012', 'Łódź', 'Polska');

-- ----------------------------------------
-- Dane dla tabeli auctions
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
-- Użytkownik Kazimierz12 (id=3)
(24, 3, 1, 'Używany laptop Lenovo ThinkPad', 'Laptop Lenovo ThinkPad, 15-calowy, w dobrym stanie, idealny dla studenta.', 0, 0, '2024-10-05', '2024-10-12', 1, 2, 0, NULL, 900, 1),
(25, 3, 2, 'Biurko studenckie z drugiej ręki', 'Solidne biurko, lekkie ślady użytkowania, dobre do nauki i pracy.', 0, 0, '2024-10-06', '2024-10-13', 1, 2, 0, NULL, 200, 1),
-- Użytkownik Władysław34 (id=4)
(26, 4, 3, 'Używany rower górski', 'Rower górski z lekkim zużyciem, sprawny mechanizm, gotowy do jazdy w terenie.', 0, 0, '2024-10-07', '2024-10-14', 1, 2, 0, NULL, 400, 1),
(27, 4, 4, 'Zestaw podręczników do ekonomii', 'Kompletny zestaw podręczników dla studentów ekonomii, używane, lecz czytelne.', 0, 0, '2024-10-08', '2024-10-15', 1, 2, 0, NULL, 150, 1),
-- Użytkownik Zbigniew56 (id=5)
(28, 5, 5, 'Sprzęt fitness – hantle i mata', 'Zestaw do ćwiczeń w domu, hantle oraz mata, idealne dla aktywnego studenta.', 0, 0, '2024-10-09', '2024-10-16', 1, 2, 0, NULL, 250, 1),
(29, 5, 6, 'Konsola do gier z kolekcją gier', 'Używana konsola z kilkoma grami, gotowa do rozrywki, sprawna technicznie.', 0, 0, '2024-10-10', '2024-10-17', 1, 2, 0, NULL, 300, 1),
-- Użytkownik Stanisław78 (id=6)
(30, 6, 1, 'Smartfon Xiaomi w dobrym stanie', 'Xiaomi, lekko używany smartfon, sprawny aparat, doskonały dla studenta.', 0, 0, '2024-10-11', '2024-10-18', 1, 2, 0, NULL, 180, 1),
(31, 6, 3, 'Używana hulajnoga elektryczna', 'Hulajnoga elektryczna, idealna do szybkiego przemieszczania się po mieście, sprawna.', 0, 0, '2024-10-12', '2024-10-19', 1, 2, 0, NULL, 220, 1),
-- Użytkownik Janusz90 (id=7)
(32, 7, 2, 'Krzesło biurowe – ergonomiczne', 'Ergonomiczne krzesło biurowe, komfortowe podczas długich godzin nauki.', 0, 0, '2024-10-13', '2024-10-20', 1, 2, 0, NULL, 120, 1),
(33, 7, 4, 'Podręcznik z programowania w C++', 'Podręcznik dla początkujących programistów, przejrzysty i dobrze ilustrowany.', 0, 0, '2024-10-14', '2024-10-21', 1, 2, 0, NULL, 100, 1),
-- Użytkownik Bogdan23 (id=8)
(34, 8, 5, 'Rower miejski – lekko używany', 'Lekki rower miejski, idealny na dojazdy, w pełni sprawny, z niewielkim przebiegiem.', 0, 0, '2024-10-15', '2024-10-22', 1, 2, 0, NULL, 300, 1),
(35, 8, 6, 'Konsola PlayStation 4 z grami', 'PS4 z kilkoma grami, w dobrym stanie, gotowa do używania. Aukcja w EUR.', 0, 0, '2024-10-16', '2024-10-23', 1, 2, 0, NULL, 350, 2),
-- Użytkownik Mieczysław45 (id=9)
(36, 9, 1, 'Tablet Samsung Galaxy Tab', 'Tablet Samsung, idealny do nauki i rozrywki, w dobrym stanie, sprawny.', 0, 0, '2024-10-17', '2024-10-24', 1, 2, 0, NULL, 280, 1),
(37, 9, 2, 'Stolik kawowy – nowoczesny design', 'Stolik kawowy, nowoczesny design, lekko używany, pasuje do każdego wnętrza.', 0, 0, '2024-10-18', '2024-10-25', 1, 2, 0, NULL, 180, 1),
-- Użytkownik Czesław67 (id=10)
(38, 10, 3, 'Składany rower trekkingowy', 'Rowerek trekkingowy, składany, wygodny i lekki, idealny na wycieczki.', 0, 0, '2024-10-19', '2024-10-26', 1, 2, 0, NULL, 320, 1),
(39, 10, 4, 'Książki naukowe – zestaw 3 tomów', 'Zestaw trzech książek naukowych, idealny dla studentów kierunków ścisłych.', 0, 0, '2024-10-20', '2024-10-27', 1, 2, 0, NULL, 200, 1);

-- ----------------------------------------
-- Oferty niezweryfikowane (używane) – dodatkowe 3 aukcje
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(40, 3, 1, 'Stary aparat fotograficzny analogowy', 'Klasyczny aparat fotograficzny, idealny dla miłośników fotografii analogowej, z widocznymi śladami użytkowania.', 1, 0, '2024-10-21', '2024-10-28', 0, 0, 0, NULL, 150, 1),
(41, 5, 6, 'Używana konsola Nintendo 64', 'Kultowa konsola Nintendo 64, używana, ale w pełni sprawna, świetna dla kolekcjonerów.', 1, 0, '2024-10-22', '2024-10-29', 0, 0, 0, NULL, 220, 1),
(42, 7, 2, 'Zestaw mebli do kawalerki – stół i krzesła', 'Kompletny zestaw mebli idealny do małego mieszkania, używany, ale zadbany.', 1, 0, '2024-10-23', '2024-10-30', 0, 0, 0, NULL, 180, 1);

-- ----------------------------------------
-- Dane dla tabeli file_to_auction
-- Każdej aukcji przypisujemy jedno zdjęcie – nazwa pliku zawiera id aukcji oraz datę/godzinę (przykładowo ustawioną na 10:00:00)
INSERT INTO file_to_auction (auctionid, filename, file_path) VALUES
(24, '24_20241005100000.jpg', 'images/auction/'),
(25, '25_20241006100000.jpg', 'images/auction/'),
(26, '26_20241007100000.jpg', 'images/auction/'),
(27, '27_20241008100000.jpg', 'images/auction/'),
(28, '28_20241009100000.jpg', 'images/auction/'),
(29, '29_20241010100000.jpg', 'images/auction/'),
(30, '30_20241011100000.jpg', 'images/auction/'),
(31, '31_20241012100000.jpg', 'images/auction/'),
(32, '32_20241013100000.jpg', 'images/auction/'),
(33, '33_20241014100000.jpg', 'images/auction/'),
(34, '34_20241015100000.jpg', 'images/auction/'),
(35, '35_20241016100000.jpg', 'images/auction/'),
(36, '36_20241017100000.jpg', 'images/auction/'),
(37, '37_20241018100000.jpg', 'images/auction/'),
(38, '38_20241019100000.jpg', 'images/auction/'),
(39, '39_20241020100000.jpg', 'images/auction/'),
(40, '40_20241021100000.jpg', 'images/auction/'),
(41, '41_20241022100000.jpg', 'images/auction/'),
(42, '42_20241023100000.jpg', 'images/auction/');

-- ----------------------------------------
-- Dane dla tabel message oraz message_link (korespondencja dotycząca każdej aukcji)
  
-- Aukcja id=24
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (24, 3, 4);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(1, 24, 4, 0, '2024-10-05 10:05:00', 'Dzień dobry, czy przedmiot "Używany laptop Lenovo ThinkPad" jest jeszcze dostępny? Czy mogliby Państwo rozważyć sprzedaż za 675 PLN?'),
(1, 24, 4, 1, '2024-10-05 10:15:00', 'Witam, dziękuję za zapytanie. Aukcja jest aktywna, jednak proponowana przez Pana cena jest zbyt niska. Proponuję cenę 810 PLN.'),
(1, 24, 4, 0, '2024-10-05 10:25:00', 'Dziękuję za odpowiedź, zgadzam się na zaproponowaną cenę. Proszę o finalizację transakcji.');

-- Aukcja id=25
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (25, 3, 5);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(2, 25, 5, 0, '2024-10-06 10:05:00', 'Dzień dobry, czy biurko studenckie jest nadal dostępne? Czy możliwa jest sprzedaż za 150 PLN?'),
(2, 25, 5, 1, '2024-10-06 10:15:00', 'Witam, biurko jest dostępne, jednak proponowana cena jest zbyt niska. Proponuję 180 PLN.'),
(2, 25, 5, 0, '2024-10-06 10:25:00', 'Dziękuję, akceptuję proponowaną cenę.');

-- Aukcja id=26
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (26, 4, 3);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(3, 26, 3, 0, '2024-10-07 10:05:00', 'Dzień dobry, czy rower górski jest dostępny? Czy mógłbym kupić go za 300 PLN?'),
(3, 26, 3, 1, '2024-10-07 10:15:00', 'Witam, rower jest dostępny, ale cena 300 PLN jest zbyt niska. Proponuję 360 PLN.'),
(3, 26, 3, 0, '2024-10-07 10:25:00', 'Dziękuję, zgadzam się na 360 PLN.');

-- Aukcja id=27
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (27, 4, 5);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(4, 27, 5, 0, '2024-10-08 10:05:00', 'Dzień dobry, czy zestaw podręczników jest nadal dostępny? Czy możliwa jest sprzedaż za 112.50 PLN?'),
(4, 27, 5, 1, '2024-10-08 10:15:00', 'Witam, podręczniki są dostępne, jednak proponowana cena jest zbyt niska. Proponuję 135 PLN.'),
(4, 27, 5, 0, '2024-10-08 10:25:00', 'Dziękuję, akceptuję 135 PLN.');

-- Aukcja id=28
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (28, 5, 3);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(5, 28, 3, 0, '2024-10-09 10:05:00', 'Dzień dobry, czy sprzęt fitness jest dostępny? Czy mogę kupić za 187.50 PLN?'),
(5, 28, 3, 1, '2024-10-09 10:15:00', 'Witam, sprzęt jest dostępny, ale cena 187.50 PLN jest zbyt niska. Proponuję 225 PLN.'),
(5, 28, 3, 0, '2024-10-09 10:25:00', 'Dziękuję, zgadzam się na 225 PLN.');

-- Aukcja id=29
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (29, 5, 6);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(6, 29, 6, 0, '2024-10-10 10:05:00', 'Dzień dobry, czy konsola jest nadal dostępna? Czy możliwa jest sprzedaż za 225 PLN?'),
(6, 29, 6, 1, '2024-10-10 10:15:00', 'Witam, konsola jest dostępna, jednak cena 225 PLN jest zbyt niska. Proponuję 270 PLN.'),
(6, 29, 6, 0, '2024-10-10 10:25:00', 'Dziękuję, akceptuję 270 PLN.');

-- Aukcja id=30
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (30, 6, 7);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(7, 30, 7, 0, '2024-10-11 10:05:00', 'Dzień dobry, czy smartfon jest dostępny? Czy mógłbym kupić go za 135 PLN?'),
(7, 30, 7, 1, '2024-10-11 10:15:00', 'Witam, smartfon jest dostępny, ale cena 135 PLN jest zbyt niska. Proponuję 162 PLN.'),
(7, 30, 7, 0, '2024-10-11 10:25:00', 'Dziękuję, zgadzam się na 162 PLN.');

-- Aukcja id=31
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (31, 6, 8);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(8, 31, 8, 0, '2024-10-12 10:05:00', 'Dzień dobry, czy hulajnoga elektryczna jest dostępna? Czy mogę kupić za 165 PLN?'),
(8, 31, 8, 1, '2024-10-12 10:15:00', 'Witam, hulajnoga jest dostępna, jednak cena 165 PLN jest zbyt niska. Proponuję 198 PLN.'),
(8, 31, 8, 0, '2024-10-12 10:25:00', 'Dziękuję, akceptuję 198 PLN.');

-- Aukcja id=32
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (32, 7, 8);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(9, 32, 8, 0, '2024-10-13 10:05:00', 'Dzień dobry, czy krzesło biurowe jest nadal dostępne? Czy możliwa jest sprzedaż za 90 PLN?'),
(9, 32, 8, 1, '2024-10-13 10:15:00', 'Witam, krzesło jest dostępne, ale cena 90 PLN jest zbyt niska. Proponuję 108 PLN.'),
(9, 32, 8, 0, '2024-10-13 10:25:00', 'Dziękuję, zgadzam się na 108 PLN.');

-- Aukcja id=33
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (33, 7, 9);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(10, 33, 9, 0, '2024-10-14 10:05:00', 'Dzień dobry, czy podręcznik jest dostępny? Czy mógłbym kupić za 75 PLN?'),
(10, 33, 9, 1, '2024-10-14 10:15:00', 'Witam, podręcznik jest dostępny, jednak cena 75 PLN jest zbyt niska. Proponuję 90 PLN.'),
(10, 33, 9, 0, '2024-10-14 10:25:00', 'Dziękuję, akceptuję 90 PLN.');

-- Aukcja id=34
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (34, 8, 7);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(11, 34, 7, 0, '2024-10-15 10:05:00', 'Dzień dobry, czy rower miejski jest nadal dostępny? Czy możliwa jest sprzedaż za 225 PLN?'),
(11, 34, 7, 1, '2024-10-15 10:15:00', 'Witam, rower jest dostępny, ale cena 225 PLN jest zbyt niska. Proponuję 270 PLN.'),
(11, 34, 7, 0, '2024-10-15 10:25:00', 'Dziękuję, zgadzam się na 270 PLN.');

-- Aukcja id=35 (waluta EUR)
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (35, 8, 9);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(12, 35, 9, 0, '2024-10-16 10:05:00', 'Dzień dobry, czy konsola PS4 jest dostępna? Czy mogę kupić za 262.50 EUR?'),
(12, 35, 9, 1, '2024-10-16 10:15:00', 'Witam, konsola jest dostępna, jednak cena 262.50 EUR jest zbyt niska. Proponuję 315 EUR.'),
(12, 35, 9, 0, '2024-10-16 10:25:00', 'Dziękuję, akceptuję 315 EUR.');

-- Aukcja id=36
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (36, 9, 10);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(13, 36, 10, 0, '2024-10-17 10:05:00', 'Dzień dobry, czy tablet jest dostępny? Czy mogę kupić za 210 PLN?'),
(13, 36, 10, 1, '2024-10-17 10:15:00', 'Witam, tablet jest dostępny, jednak cena 210 PLN jest zbyt niska. Proponuję 252 PLN.'),
(13, 36, 10, 0, '2024-10-17 10:25:00', 'Dziękuję, zgadzam się na 252 PLN.');

-- Aukcja id=37
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (37, 9, 3);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(14, 37, 3, 0, '2024-10-18 10:05:00', 'Dzień dobry, czy stolik kawowy jest nadal dostępny? Czy możliwa jest sprzedaż za 135 PLN?'),
(14, 37, 3, 1, '2024-10-18 10:15:00', 'Witam, stolik jest dostępny, jednak cena 135 PLN jest zbyt niska. Proponuję 162 PLN.'),
(14, 37, 3, 0, '2024-10-18 10:25:00', 'Dziękuję, akceptuję 162 PLN.');

-- Aukcja id=38
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (38, 10, 3);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(15, 38, 3, 0, '2024-10-19 10:05:00', 'Dzień dobry, czy rower trekkingowy jest dostępny? Czy mogę kupić za 240 PLN?'),
(15, 38, 3, 1, '2024-10-19 10:15:00', 'Witam, rower jest dostępny, ale cena 240 PLN jest zbyt niska. Proponuję 288 PLN.'),
(15, 38, 3, 0, '2024-10-19 10:25:00', 'Dziękuję, zgadzam się na 288 PLN.');

-- Aukcja id=39
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (39, 10, 4);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(16, 39, 4, 0, '2024-10-20 10:05:00', 'Dzień dobry, czy zestaw książek jest dostępny? Czy możliwa jest sprzedaż za 150 PLN?'),
(16, 39, 4, 1, '2024-10-20 10:15:00', 'Witam, książki są dostępne, jednak cena 150 PLN jest zbyt niska. Proponuję 180 PLN.'),
(16, 39, 4, 0, '2024-10-20 10:25:00', 'Dziękuję, akceptuję 180 PLN.');

-- Aukcja id=40 (oferta niezweryfikowana)
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (40, 3, 4);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(17, 40, 4, 0, '2024-10-21 10:05:00', 'Dzień dobry, czy aparat fotograficzny jest dostępny? Czy mogę kupić za 112.50 PLN?'),
(17, 40, 4, 1, '2024-10-21 10:15:00', 'Witam, aparat jest dostępny, jednak cena 112.50 PLN jest zbyt niska. Proponuję 135 PLN.'),
(17, 40, 4, 0, '2024-10-21 10:25:00', 'Dziękuję, akceptuję 135 PLN.');

-- Aukcja id=41 (oferta niezweryfikowana)
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (41, 5, 6);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(18, 41, 6, 0, '2024-10-22 10:05:00', 'Dzień dobry, czy konsola Nintendo 64 jest dostępna? Czy mogę kupić za 165 PLN?'),
(18, 41, 6, 1, '2024-10-22 10:15:00', 'Witam, konsola jest dostępna, jednak cena 165 PLN jest zbyt niska. Proponuję 198 PLN.'),
(18, 41, 6, 0, '2024-10-22 10:25:00', 'Dziękuję, zgadzam się na 198 PLN.');

-- Aukcja id=42 (oferta niezweryfikowana)
INSERT INTO message_link (auctionid, sellerid, buyerid) VALUES (42, 7, 8);
INSERT INTO message (mlid, auctionid, buyerid, answer, date, description) VALUES
(19, 42, 8, 0, '2024-10-23 10:05:00', 'Dzień dobry, czy zestaw mebli jest dostępny? Czy mogę kupić za 135 PLN?'),
(19, 42, 8, 1, '2024-10-23 10:15:00', 'Witam, zestaw mebli jest dostępny, jednak cena 135 PLN jest zbyt niska. Proponuję 162 PLN.'),
(19, 42, 8, 0, '2024-10-23 10:25:00', 'Dziękuję, akceptuję 162 PLN.');

COMMIT;
