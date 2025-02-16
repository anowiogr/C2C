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


-- Create table accounts
CREATE TABLE accounts (
  accountid int(11) NOT NULL,
  login varchar(100) NOT NULL,
  password varchar(250) NOT NULL,
  registerdate date NOT NULL DEFAULT current_timestamp(),
  account_type varchar(3) NOT NULL DEFAULT '222',
  verified tinyint(1) NOT NULL,
  whover int(3) NOT NULL,
  firstname varchar(50) DEFAULT NULL,
  lastname varchar(150) DEFAULT NULL,
  email varchar(250) DEFAULT NULL,
  phone varchar(9) DEFAULT NULL,
  address varchar(200) DEFAULT NULL,
  codezip varchar(6) DEFAULT NULL,
  city varchar(50) DEFAULT NULL,
  country varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create table auctions
CREATE TABLE auctions (
  auctionid int(11) NOT NULL,
  accountid int(11) NOT NULL,
  categoryid int(11) NOT NULL,
  title varchar(100) DEFAULT NULL,
  description text DEFAULT NULL,
  used tinyint(1) DEFAULT 0,
  private tinyint(1) DEFAULT 0,
  date_start date DEFAULT current_timestamp(),
  date_end date DEFAULT NULL,
  veryfied int(1) NOT NULL DEFAULT 0,
  whover int(3) NOT NULL,
  selled tinyint(1) DEFAULT 0,
  buyerid int(11) DEFAULT NULL,
  price double DEFAULT NULL,
  currencyid int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create table category
CREATE TABLE category (
  categoryid int(11) NOT NULL,
  name varchar(100) DEFAULT NULL,
  in_tree int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create table currency
CREATE TABLE currency (
  currencyid int(10) NOT NULL,
  currency_name varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create table file_to_auction
CREATE TABLE file_to_auction (
  file_id int(11) NOT NULL,
  auctionid int(11) NOT NULL,
  filename varchar(255) NOT NULL,
  file_path varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create table message
CREATE TABLE message (
  id int(11) NOT NULL,
  mlid int(11) NOT NULL,
  auctionid int(11) NOT NULL,
  buyerid int(3) NOT NULL,
  answer tinyint(1) NOT NULL,
  date datetime NOT NULL DEFAULT current_timestamp(),
  description text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create table message_link
CREATE TABLE message_link (
  mlid int(11) NOT NULL,
  auctionid int(11) NOT NULL,
  sellerid int(11) NOT NULL,
  buyerid int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create table type
CREATE TABLE type (
  type_id varchar(3) NOT NULL,
  type_name varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Setting primary keys
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

-- Setting AUTO_INCREMENT values
ALTER TABLE accounts
  MODIFY accountid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

ALTER TABLE auctions
  MODIFY auctionid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

ALTER TABLE category
  MODIFY categoryid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE currency
  MODIFY currencyid int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE file_to_auction
  MODIFY file_id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE message
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

ALTER TABLE message_link
  MODIFY mlid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

/*
-- Adding foreign key constraints (commented out)
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

ALTER TABLE accounts
  ADD CONSTRAINT fk_accounts_whover FOREIGN KEY (whover) REFERENCES accounts (accountid);
*/
COMMIT;

-- Inserting sample data for a student project

START TRANSACTION;

-- Inserting account types
INSERT INTO type (type_id, type_name) VALUES
('101', 'Administrator'),
('222', 'Użytkownik');

-- Inserting currencies (PLN and EUR)
INSERT INTO currency (currencyid, currency_name) VALUES
(1, 'PLN'),
(2, 'EUR');

-- Inserting categories
INSERT INTO category (categoryid, name, in_tree) VALUES
(1, 'Elektronika', 0),
(2, 'Książki', 0),
(3, 'Meble', 0),
(4, 'Ubrania', 0),
(5, 'Sport', 0),
(6, 'Inne', 0);

-- Inserting accounts (10 users)
-- Admin account (accountid 1)
INSERT INTO accounts (accountid, login, password, registerdate, account_type, verified, whover, firstname, lastname, email, phone, address, codezip, city, country) VALUES
(1, 'admin', '$argon2id$v=19$m=65536,t=4,p=1$YWRtaW4$HASH_ADMIN', '2024-10-01', '101', 1, 0, 'Admin', 'Adminowski', 'admin@example.com', '111111111', 'ul. Admina 1', '00-001', 'Warszawa', 'Polska');

-- Moderator account (accountid 2), verified by admin (whover = 1)
INSERT INTO accounts (accountid, login, password, registerdate, account_type, verified, whover, firstname, lastname, email, phone, address, codezip, city, country) VALUES
(2, 'mod', '$argon2id$v=19$m=65536,t=4,p=1$bW9k$HASH_MOD', '2024-10-02', '222', 1, 1, 'Mod', 'Moderator', 'mod@example.com', '222222222', 'ul. Moderacji 2', '00-002', 'Kraków', 'Polska');

-- Other user accounts, verified by moderator (whover = 2)
INSERT INTO accounts (accountid, login, password, registerdate, account_type, verified, whover, firstname, lastname, email, phone, address, codezip, city, country) VALUES
(3, 'Wojciech17', '$argon2id$v=19$m=65536,t=4,p=1$V29qY2hpZWNoMTc$HASH_Wojciech17', '2024-10-03', '222', 1, 2, 'Wojciech', 'Kowalski', 'wojciech17@example.com', '333333333', 'ul. Słoneczna 3', '01-001', 'Poznań', 'Polska'),
(4, 'Zbigniew34', '$argon2id$v=19$m=65536,t=4,p=1$WmJpZ25pZXdCMzQ$HASH_Zbigniew34', '2024-10-04', '222', 1, 2, 'Zbigniew', 'Nowak', 'zbigniew34@example.com', '444444444', 'ul. Kwiatowa 4', '02-002', 'Wrocław', 'Polska'),
(5, 'Stanisław09', '$argon2id$v=19$m=65536,t=4,p=1$U3RhbnNpbGF3MDk$HASH_Stanisław09', '2024-10-05', '222', 1, 2, 'Stanisław', 'Lewandowski', 'stanislaw09@example.com', '555555555', 'ul. Leśna 5', '03-003', 'Gdańsk', 'Polska'),
(6, 'Kazimierz42', '$argon2id$v=19$m=65536,t=4,p=1$S2F6aW1pZXJ6NDI$HASH_Kazimierz42', '2024-10-06', '222', 1, 2, 'Kazimierz', 'Wójcik', 'kazimierz42@example.com', '666666666', 'ul. Ogrodowa 6', '04-004', 'Łódź', 'Polska'),
(7, 'Lech56', '$argon2id$v=19$m=65536,t=4,p=1$TGVjaDU2$HASH_Lech56', '2024-10-07', '222', 1, 2, 'Lech', 'Krawczyk', 'lech56@example.com', '777777777', 'ul. Polna 7', '05-005', 'Lublin', 'Polska'),
(8, 'Mieczysław23', '$argon2id$v=19$m=65536,t=4,p=1$TWllY2h5c3dhMjM$HASH_Mieczysław23', '2024-10-08', '222', 1, 2, 'Mieczysław', 'Kamiński', 'mieczyslaw23@example.com', '888888888', 'ul. Lipowa 8', '06-006', 'Szczecin', 'Polska'),
(9, 'Bolesław88', '$argon2id$v=19$m=65536,t=4,p=1$Qm9sZXNsYXdhODg$HASH_Bolesław88', '2024-10-09', '222', 1, 2, 'Bolesław', 'Zieliński', 'boleslaw88@example.com', '999999999', 'ul. Wiosenna 9', '07-007', 'Katowice', 'Polska'),
(10, 'Janusz77', '$argon2id$v=19$m=65536,t=4,p=1$SmFudXNaNzc$HASH_Janusz77', '2024-10-10', '222', 1, 2, 'Janusz', 'Wiśniewski', 'janusz77@example.com', '101010101', 'ul. Jesienna 10', '08-008', 'Lublin', 'Polska');

-- Inserting auctions

-- Auctions by user 3 (Wojciech17)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(1, 3, 1, 'Laptop Lenovo ThinkPad', 'Używany laptop Lenovo ThinkPad, idealny do nauki i pracy, w dobrym stanie.', 1, 0, '2024-11-01', '2024-11-10', 1, 2, 0, NULL, 800, 1),
(2, 3, 2, 'Kolekcja książek historycznych', 'Zbiór staropolskich książek o historii Polski, ciekawa lektura.', 1, 0, '2024-11-05', '2024-11-15', 1, 2, 0, NULL, 100, 1);

-- Auctions by user 4 (Zbigniew34)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(3, 4, 3, 'Stolik drewniany', 'Solidny stolik wykonany z dębu, idealny do salonu.', 1, 0, '2024-11-02', '2024-11-12', 1, 2, 0, NULL, 150, 1),
(4, 4, 4, 'Kurtka zimowa', 'Ciepła kurtka zimowa, lekko używana, rozmiar M.', 0, 1, '2024-11-06', '2024-11-16', 1, 2, 0, NULL, 200, 1);

-- Auctions by user 5 (Stanisław09)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(5, 5, 5, 'Rower miejski', 'Rower miejski, idealny do codziennych dojazdów, w bardzo dobrym stanie.', 1, 0, '2024-11-03', '2024-11-13', 1, 2, 0, NULL, 400, 1),
(6, 5, 6, 'Zestaw narzędzi', 'Kompletny zestaw narzędzi dla majsterkowicza, praktyczny i funkcjonalny.', 1, 1, '2024-11-07', '2024-11-17', 1, 2, 0, NULL, 250, 1);

-- Auctions by user 6 (Kazimierz42)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(7, 6, 1, 'Smartfon Samsung Galaxy', 'Nowoczesny smartfon Samsung Galaxy, z lekkimi śladami użytkowania.', 1, 0, '2024-11-04', '2024-11-14', 1, 2, 0, NULL, 300, 1),
(8, 6, 3, 'Krzesło biurowe', 'Ergonomiczne krzesło biurowe, wygodne do pracy przy komputerze.', 1, 0, '2024-11-08', '2024-11-18', 1, 2, 0, NULL, 120, 2);

-- Auctions by user 7 (Lech56)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(9, 7, 2, 'Stary podręcznik matematyki', 'Podręcznik matematyki z czasów szkolnych, w dobrym stanie.', 1, 0, '2024-11-05', '2024-11-15', 1, 2, 0, NULL, 80, 1),
(10, 7, 4, 'Eleganckie spodnie', 'Spodnie garniturowe, noszone kilka razy, idealne do pracy.', 1, 0, '2024-11-09', '2024-11-19', 1, 2, 0, NULL, 150, 1);

-- Auctions by user 8 (Mieczysław23)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(11, 8, 5, 'Piłka nożna', 'Oficjalna piłka nożna, używana tylko w lokalnych rozgrywkach.', 1, 0, '2024-11-06', '2024-11-16', 1, 2, 0, NULL, 60, 1),
(12, 8, 6, 'Zestaw do majsterkowania', 'Praktyczny zestaw narzędzi, który sprawdzi się w każdym domu.', 1, 0, '2024-11-10', '2024-11-20', 1, 2, 0, NULL, 180, 1);

-- Auctions by user 9 (Bolesław88)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(13, 9, 1, 'Tablet Android', 'Tablet z systemem Android, idealny do rozrywki i nauki.', 1, 0, '2024-11-07', '2024-11-17', 1, 2, 0, NULL, 220, 1),
(14, 9, 2, 'Komiks superbohaterski', 'Komiks z serii przygód superbohaterów, nowy egzemplarz.', 0, 0, '2024-11-11', '2024-11-21', 1, 2, 0, NULL, 50, 1);

-- Auctions by user 10 (Janusz77)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(15, 10, 3, 'Regał na książki', 'Solidny regał na książki, lekko używany, w dobrym stanie.', 1, 0, '2024-11-08', '2024-11-18', 1, 2, 0, NULL, 100, 1),
(16, 10, 4, 'Koszula elegancka', 'Elegancka koszula, idealna na spotkania biznesowe.', 0, 0, '2024-11-12', '2024-11-22', 1, 2, 0, NULL, 90, 1);

-- Extra unverified auctions
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(17, 3, 5, 'Deskorolka', 'Deskorolka dla młodzieży, używana, ale wciąż sprawna.', 1, 0, '2024-11-10', '2024-11-20', 0, 0, 0, NULL, 70, 1),
(18, 4, 6, 'Głośniki bluetooth', 'Głośniki bluetooth, idealne do imprez, w atrakcyjnej cenie.', 1, 0, '2024-11-11', '2024-11-21', 0, 0, 0, NULL, 130, 1),
(19, 5, 1, 'Kamera sportowa', 'Kamera sportowa nagrywająca w wysokiej rozdzielczości, z kompletem akcesoriów.', 1, 0, '2024-11-12', '2024-11-22', 0, 0, 0, NULL, 200, 1);

-- Inserting message links for each auction

INSERT INTO message_link (mlid, auctionid, sellerid, buyerid) VALUES
(1, 1, 3, 4),
(2, 2, 3, 4),
(3, 3, 4, 5),
(4, 4, 4, 5),
(5, 5, 5, 6),
(6, 6, 5, 6),
(7, 7, 6, 7),
(8, 8, 6, 7),
(9, 9, 7, 8),
(10, 10, 7, 8),
(11, 11, 8, 9),
(12, 12, 8, 9),
(13, 13, 9, 10),
(14, 14, 9, 10),
(15, 15, 10, 3),
(16, 16, 10, 3),
(17, 17, 3, 4),
(18, 18, 4, 5),
(19, 19, 5, 6);

-- Inserting messages for each auction conversation

-- Auction 1 (auctionid = 1, title: 'Laptop Lenovo ThinkPad', price: 800, PLN, buyerid: 4)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(1, 1, 1, 4, 0, '2024-11-01 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(2, 1, 1, 4, 0, '2024-11-01 10:01:00', 'Czy przedmiot "Laptop Lenovo ThinkPad" jest nadal dostępny?'),
(3, 1, 1, 4, 1, '2024-11-01 10:02:00', 'Tak, przedmiot jest dostępny.'),
(4, 1, 1, 4, 0, '2024-11-01 10:03:00', 'Czy mógłby Pan sprzedać za 600 PLN?'),
(5, 1, 1, 4, 1, '2024-11-01 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(6, 1, 1, 4, 1, '2024-11-01 10:05:00', 'Mogę zaproponować cenę 720 PLN.'),
(7, 1, 1, 4, 0, '2024-11-01 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 2 (auctionid = 2, title: 'Kolekcja książek historycznych', price: 100, PLN, buyerid: 4)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(8, 2, 2, 4, 0, '2024-11-05 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(9, 2, 2, 4, 0, '2024-11-05 10:01:00', 'Czy przedmiot "Kolekcja książek historycznych" jest nadal dostępny?'),
(10, 2, 2, 4, 1, '2024-11-05 10:02:00', 'Tak, przedmiot jest dostępny.'),
(11, 2, 2, 4, 0, '2024-11-05 10:03:00', 'Czy mógłby Pan sprzedać za 75 PLN?'),
(12, 2, 2, 4, 1, '2024-11-05 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(13, 2, 2, 4, 1, '2024-11-05 10:05:00', 'Mogę zaproponować cenę 90 PLN.'),
(14, 2, 2, 4, 0, '2024-11-05 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 3 (auctionid = 3, title: 'Stolik drewniany', price: 150, PLN, buyerid: 5)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(15, 3, 3, 5, 0, '2024-11-02 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(16, 3, 3, 5, 0, '2024-11-02 10:01:00', 'Czy przedmiot "Stolik drewniany" jest nadal dostępny?'),
(17, 3, 3, 5, 1, '2024-11-02 10:02:00', 'Tak, przedmiot jest dostępny.'),
(18, 3, 3, 5, 0, '2024-11-02 10:03:00', 'Czy mógłby Pan sprzedać za 113 PLN?'),
(19, 3, 3, 5, 1, '2024-11-02 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(20, 3, 3, 5, 1, '2024-11-02 10:05:00', 'Mogę zaproponować cenę 135 PLN.'),
(21, 3, 3, 5, 0, '2024-11-02 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 4 (auctionid = 4, title: 'Kurtka zimowa', price: 200, PLN, buyerid: 5)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(22, 4, 4, 5, 0, '2024-11-06 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(23, 4, 4, 5, 0, '2024-11-06 10:01:00', 'Czy przedmiot "Kurtka zimowa" jest nadal dostępny?'),
(24, 4, 4, 5, 1, '2024-11-06 10:02:00', 'Tak, przedmiot jest dostępny.'),
(25, 4, 4, 5, 0, '2024-11-06 10:03:00', 'Czy mógłby Pan sprzedać za 150 PLN?'),
(26, 4, 4, 5, 1, '2024-11-06 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(27, 4, 4, 5, 1, '2024-11-06 10:05:00', 'Mogę zaproponować cenę 180 PLN.'),
(28, 4, 4, 5, 0, '2024-11-06 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 5 (auctionid = 5, title: 'Rower miejski', price: 400, PLN, buyerid: 6)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(29, 5, 5, 6, 0, '2024-11-03 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(30, 5, 5, 6, 0, '2024-11-03 10:01:00', 'Czy przedmiot "Rower miejski" jest nadal dostępny?'),
(31, 5, 5, 6, 1, '2024-11-03 10:02:00', 'Tak, przedmiot jest dostępny.'),
(32, 5, 5, 6, 0, '2024-11-03 10:03:00', 'Czy mógłby Pan sprzedać za 300 PLN?'),
(33, 5, 5, 6, 1, '2024-11-03 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(34, 5, 5, 6, 1, '2024-11-03 10:05:00', 'Mogę zaproponować cenę 360 PLN.'),
(35, 5, 5, 6, 0, '2024-11-03 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 6 (auctionid = 6, title: 'Zestaw narzędzi', price: 250, PLN, buyerid: 6)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(36, 6, 6, 6, 0, '2024-11-07 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(37, 6, 6, 6, 0, '2024-11-07 10:01:00', 'Czy przedmiot "Zestaw narzędzi" jest nadal dostępny?'),
(38, 6, 6, 6, 1, '2024-11-07 10:02:00', 'Tak, przedmiot jest dostępny.'),
(39, 6, 6, 6, 0, '2024-11-07 10:03:00', 'Czy mógłby Pan sprzedać za 188 PLN?'),
(40, 6, 6, 6, 1, '2024-11-07 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(41, 6, 6, 6, 1, '2024-11-07 10:05:00', 'Mogę zaproponować cenę 225 PLN.'),
(42, 6, 6, 6, 0, '2024-11-07 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 7 (auctionid = 7, title: 'Smartfon Samsung Galaxy', price: 300, PLN, buyerid: 7)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(43, 7, 7, 7, 0, '2024-11-04 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(44, 7, 7, 7, 0, '2024-11-04 10:01:00', 'Czy przedmiot "Smartfon Samsung Galaxy" jest nadal dostępny?'),
(45, 7, 7, 7, 1, '2024-11-04 10:02:00', 'Tak, przedmiot jest dostępny.'),
(46, 7, 7, 7, 0, '2024-11-04 10:03:00', 'Czy mógłby Pan sprzedać za 225 PLN?'),
(47, 7, 7, 7, 1, '2024-11-04 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(48, 7, 7, 7, 1, '2024-11-04 10:05:00', 'Mogę zaproponować cenę 270 PLN.'),
(49, 7, 7, 7, 0, '2024-11-04 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 8 (auctionid = 8, title: 'Krzesło biurowe', price: 120, EUR, buyerid: 7)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(50, 8, 8, 7, 0, '2024-11-08 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(51, 8, 8, 7, 0, '2024-11-08 10:01:00', 'Czy przedmiot "Krzesło biurowe" jest nadal dostępny?'),
(52, 8, 8, 7, 1, '2024-11-08 10:02:00', 'Tak, przedmiot jest dostępny.'),
(53, 8, 8, 7, 0, '2024-11-08 10:03:00', 'Czy mógłby Pan sprzedać za 90 EUR?'),
(54, 8, 8, 7, 1, '2024-11-08 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(55, 8, 8, 7, 1, '2024-11-08 10:05:00', 'Mogę zaproponować cenę 108 EUR.'),
(56, 8, 8, 7, 0, '2024-11-08 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 9 (auctionid = 9, title: 'Stary podręcznik matematyki', price: 80, PLN, buyerid: 8)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(57, 9, 9, 8, 0, '2024-11-05 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(58, 9, 9, 8, 0, '2024-11-05 10:01:00', 'Czy przedmiot "Stary podręcznik matematyki" jest nadal dostępny?'),
(59, 9, 9, 8, 1, '2024-11-05 10:02:00', 'Tak, przedmiot jest dostępny.'),
(60, 9, 9, 8, 0, '2024-11-05 10:03:00', 'Czy mógłby Pan sprzedać za 60 PLN?'),
(61, 9, 9, 8, 1, '2024-11-05 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(62, 9, 9, 8, 1, '2024-11-05 10:05:00', 'Mogę zaproponować cenę 72 PLN.'),
(63, 9, 9, 8, 0, '2024-11-05 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 10 (auctionid = 10, title: 'Eleganckie spodnie', price: 150, PLN, buyerid: 8)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(64, 10, 10, 8, 0, '2024-11-09 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(65, 10, 10, 8, 0, '2024-11-09 10:01:00', 'Czy przedmiot "Eleganckie spodnie" jest nadal dostępny?'),
(66, 10, 10, 8, 1, '2024-11-09 10:02:00', 'Tak, przedmiot jest dostępny.'),
(67, 10, 10, 8, 0, '2024-11-09 10:03:00', 'Czy mógłby Pan sprzedać za 113 PLN?'),
(68, 10, 10, 8, 1, '2024-11-09 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(69, 10, 10, 8, 1, '2024-11-09 10:05:00', 'Mogę zaproponować cenę 135 PLN.'),
(70, 10, 10, 8, 0, '2024-11-09 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 11 (auctionid = 11, title: 'Piłka nożna', price: 60, PLN, buyerid: 9)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(71, 11, 11, 9, 0, '2024-11-06 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(72, 11, 11, 9, 0, '2024-11-06 10:01:00', 'Czy przedmiot "Piłka nożna" jest nadal dostępny?'),
(73, 11, 11, 9, 1, '2024-11-06 10:02:00', 'Tak, przedmiot jest dostępny.'),
(74, 11, 11, 9, 0, '2024-11-06 10:03:00', 'Czy mógłby Pan sprzedać za 45 PLN?'),
(75, 11, 11, 9, 1, '2024-11-06 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(76, 11, 11, 9, 1, '2024-11-06 10:05:00', 'Mogę zaproponować cenę 54 PLN.'),
(77, 11, 11, 9, 0, '2024-11-06 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 12 (auctionid = 12, title: 'Zestaw do majsterkowania', price: 180, PLN, buyerid: 9)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(78, 12, 12, 9, 0, '2024-11-10 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(79, 12, 12, 9, 0, '2024-11-10 10:01:00', 'Czy przedmiot "Zestaw do majsterkowania" jest nadal dostępny?'),
(80, 12, 12, 9, 1, '2024-11-10 10:02:00', 'Tak, przedmiot jest dostępny.'),
(81, 12, 12, 9, 0, '2024-11-10 10:03:00', 'Czy mógłby Pan sprzedać za 135 PLN?'),
(82, 12, 12, 9, 1, '2024-11-10 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(83, 12, 12, 9, 1, '2024-11-10 10:05:00', 'Mogę zaproponować cenę 162 PLN.'),
(84, 12, 12, 9, 0, '2024-11-10 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 13 (auctionid = 13, title: 'Tablet Android', price: 220, PLN, buyerid: 10)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(85, 13, 13, 10, 0, '2024-11-07 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(86, 13, 13, 10, 0, '2024-11-07 10:01:00', 'Czy przedmiot "Tablet Android" jest nadal dostępny?'),
(87, 13, 13, 10, 1, '2024-11-07 10:02:00', 'Tak, przedmiot jest dostępny.'),
(88, 13, 13, 10, 0, '2024-11-07 10:03:00', 'Czy mógłby Pan sprzedać za 165 PLN?'),
(89, 13, 13, 10, 1, '2024-11-07 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(90, 13, 13, 10, 1, '2024-11-07 10:05:00', 'Mogę zaproponować cenę 198 PLN.'),
(91, 13, 13, 10, 0, '2024-11-07 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 14 (auctionid = 14, title: 'Komiks superbohaterski', price: 50, PLN, buyerid: 10)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(92, 14, 14, 10, 0, '2024-11-11 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(93, 14, 14, 10, 0, '2024-11-11 10:01:00', 'Czy przedmiot "Komiks superbohaterski" jest nadal dostępny?'),
(94, 14, 14, 10, 1, '2024-11-11 10:02:00', 'Tak, przedmiot jest dostępny.'),
(95, 14, 14, 10, 0, '2024-11-11 10:03:00', 'Czy mógłby Pan sprzedać za 38 PLN?'),
(96, 14, 14, 10, 1, '2024-11-11 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(97, 14, 14, 10, 1, '2024-11-11 10:05:00', 'Mogę zaproponować cenę 45 PLN.'),
(98, 14, 14, 10, 0, '2024-11-11 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 15 (auctionid = 15, title: 'Regał na książki', price: 100, PLN, buyerid: 3)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(99, 15, 15, 3, 0, '2024-11-08 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(100, 15, 15, 3, 0, '2024-11-08 10:01:00', 'Czy przedmiot "Regał na książki" jest nadal dostępny?'),
(101, 15, 15, 3, 1, '2024-11-08 10:02:00', 'Tak, przedmiot jest dostępny.'),
(102, 15, 15, 3, 0, '2024-11-08 10:03:00', 'Czy mógłby Pan sprzedać za 75 PLN?'),
(103, 15, 15, 3, 1, '2024-11-08 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(104, 15, 15, 3, 1, '2024-11-08 10:05:00', 'Mogę zaproponować cenę 90 PLN.'),
(105, 15, 15, 3, 0, '2024-11-08 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 16 (auctionid = 16, title: 'Koszula elegancka', price: 90, PLN, buyerid: 3)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(106, 16, 16, 3, 0, '2024-11-12 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(107, 16, 16, 3, 0, '2024-11-12 10:01:00', 'Czy przedmiot "Koszula elegancka" jest nadal dostępny?'),
(108, 16, 16, 3, 1, '2024-11-12 10:02:00', 'Tak, przedmiot jest dostępny.'),
(109, 16, 16, 3, 0, '2024-11-12 10:03:00', 'Czy mógłby Pan sprzedać za 68 PLN?'),
(110, 16, 16, 3, 1, '2024-11-12 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(111, 16, 16, 3, 1, '2024-11-12 10:05:00', 'Mogę zaproponować cenę 81 PLN.'),
(112, 16, 16, 3, 0, '2024-11-12 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 17 (auctionid = 17, title: 'Deskorolka', price: 70, PLN, buyerid: 4)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(113, 17, 17, 4, 0, '2024-11-10 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(114, 17, 17, 4, 0, '2024-11-10 10:01:00', 'Czy przedmiot "Deskorolka" jest nadal dostępny?'),
(115, 17, 17, 4, 1, '2024-11-10 10:02:00', 'Tak, przedmiot jest dostępny.'),
(116, 17, 17, 4, 0, '2024-11-10 10:03:00', 'Czy mógłby Pan sprzedać za 53 PLN?'),
(117, 17, 17, 4, 1, '2024-11-10 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(118, 17, 17, 4, 1, '2024-11-10 10:05:00', 'Mogę zaproponować cenę 63 PLN.'),
(119, 17, 17, 4, 0, '2024-11-10 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 18 (auctionid = 18, title: 'Głośniki bluetooth', price: 130, PLN, buyerid: 5)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(120, 18, 18, 5, 0, '2024-11-11 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(121, 18, 18, 5, 0, '2024-11-11 10:01:00', 'Czy przedmiot "Głośniki bluetooth" jest nadal dostępny?'),
(122, 18, 18, 5, 1, '2024-11-11 10:02:00', 'Tak, przedmiot jest dostępny.'),
(123, 18, 18, 5, 0, '2024-11-11 10:03:00', 'Czy mógłby Pan sprzedać za 98 PLN?'),
(124, 18, 18, 5, 1, '2024-11-11 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(125, 18, 18, 5, 1, '2024-11-11 10:05:00', 'Mogę zaproponować cenę 117 PLN.'),
(126, 18, 18, 5, 0, '2024-11-11 10:06:00', 'Dziękuję, przyjmuję ofertę.');

-- Auction 19 (auctionid = 19, title: 'Kamera sportowa', price: 200, PLN, buyerid: 6)
INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(127, 19, 19, 6, 0, '2024-11-12 10:00:00', 'Dzień dobry, jestem zainteresowany ofertą.'),
(128, 19, 19, 6, 0, '2024-11-12 10:01:00', 'Czy przedmiot "Kamera sportowa" jest nadal dostępny?'),
(129, 19, 19, 6, 1, '2024-11-12 10:02:00', 'Tak, przedmiot jest dostępny.'),
(130, 19, 19, 6, 0, '2024-11-12 10:03:00', 'Czy mógłby Pan sprzedać za 150 PLN?'),
(131, 19, 19, 6, 1, '2024-11-12 10:04:00', 'Przykro mi, ale zaproponowana cena jest zbyt niska.'),
(132, 19, 19, 6, 1, '2024-11-12 10:05:00', 'Mogę zaproponować cenę 180 PLN.'),
(133, 19, 19, 6, 0, '2024-11-12 10:06:00', 'Dziękuję, przyjmuję ofertę.');

COMMIT;
