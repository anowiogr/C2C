-- Rozpoczęcie transakcji
START TRANSACTION;

-- Usunięcie istniejących tabel (w kolejności uwzględniającej ograniczenia kluczy obcych)
DROP TABLE IF EXISTS file_to_auction;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS message_link;
DROP TABLE IF EXISTS auctions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS currency;
DROP TABLE IF EXISTS type;

-- ------------------------------------------------------------------------------
-- Utworzenie tabeli typu użytkowników
-- ------------------------------------------------------------------------------
CREATE TABLE type (
  type_id varchar(3) NOT NULL,
  type_name varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ------------------------------------------------------------------------------
-- Utworzenie tabeli kategorii
-- ------------------------------------------------------------------------------
CREATE TABLE category (
  categoryid int(11) NOT NULL,
  name varchar(100) DEFAULT NULL,
  in_tree int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ------------------------------------------------------------------------------
-- Utworzenie tabeli walut
-- ------------------------------------------------------------------------------
CREATE TABLE currency (
  currencyid int(10) NOT NULL,
  currency_name varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ------------------------------------------------------------------------------
-- Utworzenie tabeli użytkowników
-- ------------------------------------------------------------------------------
CREATE TABLE accounts (
  accountid int(11) NOT NULL,
  login varchar(100) NOT NULL,
  password varchar(250) NOT NULL,
  registerdate date NOT NULL DEFAULT CURRENT_TIMESTAMP(),
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

-- ------------------------------------------------------------------------------
-- Utworzenie tabeli aukcji
-- ------------------------------------------------------------------------------
CREATE TABLE auctions (
  auctionid int(11) NOT NULL,
  accountid int(11) NOT NULL,
  categoryid int(11) NOT NULL,
  title varchar(100) DEFAULT NULL,
  description text DEFAULT NULL,
  used tinyint(1) DEFAULT 0,
  private tinyint(1) DEFAULT 0,
  date_start date DEFAULT CURRENT_TIMESTAMP(),
  date_end date DEFAULT NULL,
  veryfied int(1) NOT NULL DEFAULT 0,
  whover int(3) NOT NULL,
  selled tinyint(1) DEFAULT 0,
  buyerid int(11) DEFAULT NULL,
  price double DEFAULT NULL,
  currencyid int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ------------------------------------------------------------------------------
-- Utworzenie tabeli plików przypisanych do aukcji
-- ------------------------------------------------------------------------------
CREATE TABLE file_to_auction (
  file_id int(11) NOT NULL,
  auctionid int(11) NOT NULL,
  filename varchar(255) NOT NULL,
  file_path varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ------------------------------------------------------------------------------
-- Utworzenie tabeli powiązań wiadomości (konwersacji) dla aukcji
-- ------------------------------------------------------------------------------
CREATE TABLE message_link (
  mlid int(11) NOT NULL,
  auctionid int(11) NOT NULL,
  sellerid int(11) NOT NULL,
  buyerid int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ------------------------------------------------------------------------------
-- Utworzenie tabeli wiadomości
-- ------------------------------------------------------------------------------
CREATE TABLE message (
  id int(11) NOT NULL,
  mlid int(11) NOT NULL,
  auctionid int(11) NOT NULL,
  buyerid int(11) NOT NULL,
  answer tinyint(1) NOT NULL,
  date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  description text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ------------------------------------------------------------------------------
-- Wstawienie przykładowych danych do tabeli "type"
-- Administrator (101), użytkownik (222).
-- ------------------------------------------------------------------------------
INSERT INTO type (type_id, type_name) VALUES
('101', 'Administrator'),
('222', 'Użytkownik');

-- ------------------------------------------------------------------------------
-- Wstawienie przykładowych danych do tabeli "category"
-- ------------------------------------------------------------------------------
INSERT INTO category (categoryid, name, in_tree) VALUES
(1, 'Motoryzacja', 0),
(3, 'Praca', 0),
(4, 'Zdrowie i Uroda', 0),
(5, 'Elektronika', 0),
(6, 'Moda', 0),
(7, 'Zwierzęta', 0),
(8, 'Wypożyczalnia', 0),
(9, 'Sport', 0),
(10, 'Hobby', 0);

-- ------------------------------------------------------------------------------
-- Wstawienie przykładowych danych do tabeli "currency"
-- ------------------------------------------------------------------------------
INSERT INTO currency (currencyid, currency_name) VALUES
(1, 'PLN'),
(2, 'EUR');

-- ------------------------------------------------------------------------------
-- Wstawienie przykładowych danych do tabeli "accounts"
-- ------------------------------------------------------------------------------
INSERT INTO accounts (accountid, login, password, registerdate, account_type, verified, whover, firstname, lastname, email, phone, address, codezip, city, country) VALUES
(1, 'admin', '$argon2id$v=19$m=65536,t=4,p=1$ADMIN$HASH', '2024-10-01', '101', 1, 1, 'Admin', 'Istrator', 'admin@example.com', '111111111', 'Adres admina', '00-001', 'Miasto', 'Polska'),
(2, 'mod', '$argon2id$v=19$m=65536,t=4,p=1$MOD$HASH', '2024-10-01', '222', 1, 1, 'Mod', 'Erator', 'mod@example.com', '222222222', 'Adres modera', '00-002', 'Miasto', 'Polska'),
(3, 'Geralt47', '$argon2id$v=19$m=65536,t=4,p=1$GERALT47$HASH', '2024-10-02', '222', 1, 2, 'Geralt', 'Z Rivii', 'geralt47@example.com', '333333333', 'Wiedźmińska 1', '01-001', 'Novigrad', 'Polska'),
(4, 'Yennefer82', '$argon2id$v=19$m=65536,t=4,p=1$YENNEFER82$HASH', '2024-10-03', '222', 1, 2, 'Yennefer', 'z Vengerbergu', 'yennefer82@example.com', '444444444', 'Magiczna 2', '01-002', 'Oxenfurt', 'Polska'),
(5, 'Ciri15', '$argon2id$v=19$m=65536,t=4,p=1$CIRI15$HASH', '2024-10-04', '222', 1, 2, 'Ciri', 'Niespodziewana', 'ciri15@example.com', '555555555', 'Książęca 3', '01-003', 'Lindenvale', 'Polska'),
(6, 'Triss99', '$argon2id$v=19$m=65536,t=4,p=1$TRISS99$HASH', '2024-10-05', '222', 1, 2, 'Triss', 'Merigold', 'triss99@example.com', '666666666', 'Czarodziejów 4', '01-004', 'Rivia', 'Polska'),
(7, 'Dandelion33', '$argon2id$v=19$m=65536,t=4,p=1$DANDELION33$HASH', '2024-10-06', '222', 1, 2, 'Dandelion', 'Poetycki', 'dandelion33@example.com', '777777777', 'Melodyjna 5', '01-005', 'Oxenfurt', 'Polska'),
(8, 'Eskel07', '$argon2id$v=19$m=65536,t=4,p=1$ESKEL07$HASH', '2024-10-07', '222', 1, 2, 'Eskel', 'Wiedźmin', 'eskel07@example.com', '888888888', 'Strażnicza 6', '01-006', 'Kaer Morhen', 'Polska'),
(9, 'Vesemir56', '$argon2id$v=19$m=65536,t=4,p=1$VESEMIR56$HASH', '2024-10-08', '222', 1, 2, 'Vesemir', 'Stary', 'vesemir56@example.com', '999999999', 'Mentorów 7', '01-007', 'Novigrad', 'Polska'),
(10, 'Lambert68', '$argon2id$v=19$m=65536,t=4,p=1$LAMBERT68$HASH', '2024-10-09', '222', 1, 2, 'Lambert', 'Bystry', 'lambert68@example.com', '101010101', 'Szlachetna 8', '01-008', 'Rivia', 'Polska');

-- ------------------------------------------------------------------------------
-- Wstawienie przykładowych aukcji
-- ------------------------------------------------------------------------------
-- Aukcje zakończone (auctionid 1-4)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(1, 3, 8, 'Stary miecz', 'Używany, ale sprawny miecz, idealny dla początkującego wojownika.', 1, 0, '2024-10-05', '2024-10-10', 1, 2, 1, 4, 50, 1),
(2, 4, 10, 'Księga zaklęć', 'Interesująca książka o magii i zaklęciach.', 1, 0, '2024-10-05', '2024-10-10', 1, 2, 1, 5, 60, 1),
(3, 5, 3, 'Miecz przygody', 'Miecz idealny dla podróżników i bohaterów.', 1, 0, '2024-10-05', '2024-10-10', 1, 2, 1, 6, 70, 1),
(4, 6, 7, 'Mikstura lecznicza', 'Skuteczna mikstura na drobne rany.', 1, 0, '2024-10-05', '2024-10-10', 1, 2, 1, 7, 80, 1);

-- Aukcje otwarte (auctionid 5-20)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(5, 3, 1, 'Stara zbroja', 'Solidna, lekko zużyta zbroja, odpowiednia do ochrony.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 40, 1),
(6, 3, 3, 'Ręcznie robiony nóż', 'Unikatowy nóż, idealny dla kolekcjonera.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 30, 1),
(7, 4, 4, 'Eliksir młodości', 'Rzadki eliksir, który przywraca energię i młodość.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 55, 1),
(8, 4, 5, 'Stary zegarek', 'Klasyczny zegarek, który wciąż działa precyzyjnie.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 45, 1),
(9, 5, 6, 'Skórzana kurtka', 'Stylowa kurtka, używana, ale w dobrym stanie.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 65, 1),
(10, 5, 7, 'Torebka podróżnicza', 'Praktyczna torebka, idealna na krótkie wypady.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 35, 1),
(11, 6, 8, 'Zestaw magicznych eliksirów', 'Komplet eliksirów, używanych, ale wciąż skutecznych.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 75, 1),
(12, 6, 9, 'Stara piłka', 'Nośna piłka, idealna do treningów.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 25, 1),
(13, 7, 10, 'Zestaw instrumentów', 'Mały zestaw instrumentów, idealny dla amatora.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 50, 1),
(14, 7, 1, 'Kolekcjonerskie auto', 'Mini model samochodu, rzadki okaz.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 80, 1),
(15, 8, 3, 'Zestaw narzędzi', 'Kompletny zestaw narzędzi, używany, w dobrym stanie.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 45, 1),
(16, 8, 4, 'Vintage okulary', 'Stare, ale modnie wyglądające okulary.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 30, 1),
(17, 9, 5, 'Retro radio', 'Działa, ale wymaga drobnego remontu.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 40, 1),
(18, 9, 6, 'Zegarek vintage', 'Klasyczny zegarek, w stylowym wydaniu.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 50, 1),
(19, 10, 7, 'Plakat z motywem zwierząt', 'Oryginalny plakat, idealny do pokoju studenckiego.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 20, 2),
(20, 10, 8, 'Stara książka', 'Interesująca książka, używana, z nutką nostalgii.', 1, 0, '2024-11-01', '2024-11-30', 1, 2, 0, NULL, 30, 1);

-- Aukcje niezweryfikowane (auctionid 21-23, wystawione przez użytkownika 3)
INSERT INTO auctions (auctionid, accountid, categoryid, title, description, used, private, date_start, date_end, veryfied, whover, selled, buyerid, price, currencyid) VALUES
(21, 3, 9, 'SmartBand', 'Przypomina by wstać', 1, 0, '2024-11-15', '2024-12-15', 0, 2, 0, NULL, 15, 1),
(22, 3, 10, 'Czajnik', 'Czajnik elektryczny', 1, 0, '2024-11-15', '2024-12-15', 0, 2, 0, NULL, 25, 1),
(23, 3, 3, 'Budzik', 'Analogowy budzik, już nie zaśpisz na zajęcia.', 1, 0, '2024-11-15', '2024-12-15', 0, 2, 0, NULL, 20, 1);

-- ------------------------------------------------------------------------------
-- Wstawienie przykładowej korespondencji dla aukcji zakończonych
-- ------------------------------------------------------------------------------
-- Aukcja 1 
INSERT INTO message_link (mlid, auctionid, sellerid, buyerid) VALUES
(1, 1, 3, 4);

INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(1, 1, 1, 4, 0, '2024-10-10 09:00:00', 'Dzień dobry, czy "Stary miecz" jest jeszcze dostępny?'),
(2, 1, 1, 4, 1, '2024-10-10 09:05:00', 'Tak, przedmiot jest dostępny.'),
(3, 1, 1, 4, 0, '2024-10-10 09:10:00', 'Czy mogę kupić za 37.50 zł zamiast 50 zł?'),
(4, 1, 1, 4, 1, '2024-10-10 09:15:00', 'Proszę wybaczyć, ale cena jest za niska. Proponuję 45.00 zł.'),
(5, 1, 1, 4, 0, '2024-10-10 09:20:00', 'Dziękuję, zgadzam się na proponowaną cenę i chcę kupić.');

-- Aukcja 2 
INSERT INTO message_link (mlid, auctionid, sellerid, buyerid) VALUES
(2, 2, 4, 5);

INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(6, 2, 2, 5, 0, '2024-10-10 10:00:00', 'Dzień dobry, czy "Księga zaklęć" jest jeszcze dostępna?'),
(7, 2, 2, 5, 1, '2024-10-10 10:05:00', 'Tak, przedmiot jest dostępny.'),
(8, 2, 2, 5, 0, '2024-10-10 10:10:00', 'Czy mogę kupić za 45.00 zł zamiast 60 zł?'),
(9, 2, 2, 5, 1, '2024-10-10 10:15:00', 'Proszę wybaczyć, ale cena jest za niska. Proponuję 54.00 zł.'),
(10, 2, 2, 5, 0, '2024-10-10 10:20:00', 'Dziękuję, zgadzam się na proponowaną cenę i chcę kupić.');

-- Aukcja 3 
INSERT INTO message_link (mlid, auctionid, sellerid, buyerid) VALUES
(3, 3, 5, 6);

INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(11, 3, 3, 6, 0, '2024-10-10 11:00:00', 'Dzień dobry, czy "Miecz przygody" jest jeszcze dostępny?'),
(12, 3, 3, 6, 1, '2024-10-10 11:05:00', 'Tak, przedmiot jest dostępny.'),
(13, 3, 3, 6, 0, '2024-10-10 11:10:00', 'Czy mogę kupić za 52.50 zł zamiast 70 zł?'),
(14, 3, 3, 6, 1, '2024-10-10 11:15:00', 'Proszę wybaczyć, ale cena jest za niska. Proponuję 63.00 zł.'),
(15, 3, 3, 6, 0, '2024-10-10 11:20:00', 'Dziękuję, zgadzam się na proponowaną cenę i chcę kupić.');

-- Aukcja 4 
INSERT INTO message_link (mlid, auctionid, sellerid, buyerid) VALUES
(4, 4, 6, 7);

INSERT INTO message (id, mlid, auctionid, buyerid, answer, date, description) VALUES
(16, 4, 4, 7, 0, '2024-10-10 12:00:00', 'Dzień dobry, czy "Mikstura lecznicza" jest jeszcze dostępna?'),
(17, 4, 4, 7, 1, '2024-10-10 12:05:00', 'Tak, przedmiot jest dostępny.'),
(18, 4, 4, 7, 0, '2024-10-10 12:10:00', 'Czy mogę kupić za 60.00 zł zamiast 80 zł?'),
(19, 4, 4, 7, 1, '2024-10-10 12:15:00', 'Proszę wybaczyć, ale cena jest za niska. Proponuję 72.00 zł.'),
(20, 4, 4, 7, 0, '2024-10-10 12:20:00', 'Dziękuję, zgadzam się na proponowaną cenę i chcę kupić.');

-- ------------------------------------------------------------------------------
-- Dodanie indeksów i kluczy głównych dla wszystkich tabel
-- ------------------------------------------------------------------------------
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

-- ------------------------------------------------------------------------------
-- Ustawienie AUTO_INCREMENT dla tabel
-- ------------------------------------------------------------------------------
ALTER TABLE accounts
  MODIFY accountid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE auctions
  MODIFY auctionid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

ALTER TABLE category
  MODIFY categoryid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE currency
  MODIFY currencyid int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE file_to_auction
  MODIFY file_id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE message
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

ALTER TABLE message_link
  MODIFY mlid int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
-- /*
-- ------------------------------------------------------------------------------
-- Dodanie ograniczeń kluczy obcych (FOREIGN KEY)
-- ------------------------------------------------------------------------------
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
-- */
-- Zakończenie transakcji
COMMIT;
