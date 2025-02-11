-- phpMyAdmin SQL Dump  -- generowany z phpMyAdmin
-- version 5.2.0  -- wersja narzędzia
-- https://www.phpmyadmin.net/  -- adres projektu
--
-- Host: 127.0.0.1  -- adres hosta bazy danych
-- Wersja serwera: 10.4.27-MariaDB  -- wersja serwera bazy danych
-- Wersja PHP: 8.2.0  -- wersja PHP

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO"; -- ustawiany tryb SQL, wyłączający automatyczne przypisywanie wartości zerowych
START TRANSACTION; -- rozpoczęcie transakcji
SET time_zone = "+00:00"; -- ustawiana strefa czasowa na UTC

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */; -- zachowywany poprzedni zestaw znaków klienta
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */; -- zachowywany poprzedni zestaw znaków wyników
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */; -- zachowywany poprzedni porządek zestawów znaków
/*!40101 SET NAMES utf8mb4 */; -- ustawiany zestaw znaków na utf8mb4

-- 
-- Baza danych: `c2c`  -- wskazywana baza danych
-- 

-- --------------------------------------------------------

-- Struktura tabeli dla tabeli `accounts`  -- definicja struktury tabeli accounts

CREATE TABLE `accounts` ( -- tworzenie tabeli accounts
  `accountid` int(11) NOT NULL, -- identyfikator konta
  `login` varchar(100) NOT NULL, -- nazwa użytkownika
  `password` varchar(250) NOT NULL, -- hasło konta
  `registerdate` date NOT NULL DEFAULT current_timestamp(), -- data rejestracji konta
  `account_type` varchar(3) NOT NULL DEFAULT '222', -- typ konta (np. administrator, użytkownik)
  `verified` tinyint(1) NOT NULL, -- status weryfikacji konta
  `whover` int(3) NOT NULL, -- dodatkowe pole informacyjne
  `firstname` varchar(50) DEFAULT NULL, -- imię użytkownika
  `lastname` varchar(150) DEFAULT NULL, -- nazwisko użytkownika
  `email` varchar(250) DEFAULT NULL, -- adres e-mail użytkownika
  `phone` varchar(9) DEFAULT NULL, -- numer telefonu użytkownika
  `address` varchar(200) DEFAULT NULL, -- adres zamieszkania użytkownika
  `codezip` varchar(6) DEFAULT NULL, -- kod pocztowy użytkownika
  `city` varchar(50) DEFAULT NULL, -- miasto użytkownika
  `country` varchar(50) DEFAULT NULL  -- kraj użytkownika
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; -- tabela accounts utworzona z silnikiem InnoDB i zestawem znaków utf8mb4

-- Zrzut danych tabeli `accounts`  -- wstawienie danych do tabeli accounts

INSERT INTO `accounts` (`accountid`, `login`, `password`, `registerdate`, `account_type`, `verified`, `whover`, `firstname`, `lastname`, `email`, `phone`, `address`, `codezip`, `city`, `country`) VALUES
(1, 'Gandalf', '$argon2id$v=19$m=65536,t=4,p=1$MGpNTmV5V3gxeEpnbmwuRA$4EAcazJJNXYstsdtmz3UPJPZi+ngwKWMOcRWACWGGaM', '2023-02-01', '101', 1, 0, 'Gandalf', 'Szary', 'gandalf@example.com', '123456789', 'Mroczna Dolina 1', '12-345', 'Minas Tirith', 'Gondor'),
(2, 'Frodo', '$argon2id$v=19$m=65536,t=4,p=1$MGpNTmV5V3gxeEpnbmwuRA$4EAcazJJNXYstsdtmz3UPJPZi+ngwKWMOcRWACWGGaM', '2023-02-15', '222', 1, 0, 'Frodo', 'Baggins', 'frodo@example.com', '987654321', 'Hobbiton 2', '98-765', 'Shire', 'Middle-earth'),
(3, 'Yennefer', '$argon2id$v=19$m=65536,t=4,p=1$MGpNTmV5V3gxeEpnbmwuRA$4EAcazJJNXYstsdtmz3UPJPZi+ngwKWMOcRWACWGGaM', '2023-03-06', '222', 2, 4, 'Yennefer', 'z Vengerbergu', 'yennefer@example.com', '555555555', 'Wyzima 3', '54-321', 'Redania', 'Księstwo Redanii'),
(4, 'Geralt', '$argon2id$v=19$m=65536,t=4,p=1$MGpNTmV5V3gxeEpnbmwuRA$4EAcazJJNXYstsdtmz3UPJPZi+ngwKWMOcRWACWGGaM', '2023-04-14', '101', 1, 0, 'Geralt', 'z Rivii', 'geralt@example.com', '777777777', 'Kaer Morhen 4', '01-234', 'Temeria', 'Królestwo Temerii'),
(5, 'MikeW', '$argon2id$v=19$m=65536,t=4,p=1$NkxzSEhHQVkyblFlRWRrZw$ZhSvsxgQsVLjuwJCQcet8AmVJIbX9+dZzJGWavYzroc', '2023-06-14', '222', 0, 0, 'Mike', 'Wazowski', 'mike@wazowski.com', NULL, NULL, NULL, NULL, NULL); -- dane wstawione do tabeli accounts

-- --------------------------------------------------------

-- Struktura tabeli dla tabeli `auctions`  -- definicja struktury tabeli auctions

CREATE TABLE `auctions` ( -- tworzenie tabeli auctions
  `auctionid` int(11) NOT NULL, -- identyfikator aukcji
  `accountid` int(11) NOT NULL, -- identyfikator właściciela aukcji (konto)
  `categoryid` int(11) NOT NULL, -- identyfikator kategorii aukcji
  `title` varchar(100) DEFAULT NULL, -- tytuł aukcji
  `description` text DEFAULT NULL, -- opis aukcji
  `used` tinyint(1) DEFAULT 0, -- wskaźnik stanu przedmiotu (0 - nowy, 1 - używany)
  `private` tinyint(1) DEFAULT 0, -- wskaźnik prywatności aukcji (0 - publiczna, 1 - prywatna)
  `date_start` date DEFAULT current_timestamp(), -- data rozpoczęcia aukcji
  `date_end` date DEFAULT NULL, -- data zakończenia aukcji
  `veryfied` int(1) NOT NULL DEFAULT 0, -- status weryfikacji aukcji
  `whover` int(3) NOT NULL, -- dodatkowe pole informacyjne
  `selled` tinyint(1) DEFAULT 0, -- wskaźnik zakończenia aukcji (0 - nie sprzedana, 1 - sprzedana)
  `buyerid` int(11) DEFAULT NULL, -- identyfikator kupującego
  `price` double DEFAULT NULL, -- cena aukcji
  `currencyid` int(10) NOT NULL  -- identyfikator waluty aukcji
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; -- tabela auctions utworzona z silnikiem InnoDB i zestawem znaków utf8mb4

-- Zrzut danych tabeli `auctions`  -- wstawienie danych do tabeli auctions

INSERT INTO `auctions` (`auctionid`, `accountid`, `categoryid`, `title`, `description`, `used`, `private`, `date_start`, `date_end`, `veryfied`, `whover`, `selled`, `buyerid`, `price`, `currencyid`) VALUES
(1, 1, 1, 'Miecz Glamdring', 'Potężny miecz używany przez Gandalfa w walce ze złem.', 0, 0, '2023-06-01', '2023-06-10', 1, 0, 0, NULL, 100, 2),
(2, 2, 2, 'Jeden Pierścień', 'Tajemniczy pierścień o ogromnej mocy.', 1, 0, '2023-06-02', '2023-06-11', 1, 0, 0, NULL, 200, 1),
(3, 3, 3, 'Amulet Yennefer', 'Magiczny amulet zwiększający moc czarów. xD', 0, 0, '2023-06-03', '2023-06-12', 2, 4, 0, NULL, 150, 1),
(4, 4, 4, 'Medalion Wiedźmina', 'Tajemniczy medalion dający wiedźminowi nadnaturalne zdolności.', 1, 1, '2023-06-04', '2023-06-13', 2, 4, 0, NULL, 120, 2),
(5, 1, 1, 'Kawa Gandalfa', '1,2,3 i jest', 0, 1, '2023-06-13', '0000-00-00', 1, 4, 0, NULL, 10, 4),
(11, 4, 6, 'Strój Wiedźmina', 'Najnowszy model, kompletny. Niezbędny każdemu Wiedźminowi', 1, 1, '2023-06-13', '2023-06-13', 1, 4, 0, NULL, 30, 1),
(17, 4, 7, 'Płotka', 'Mały przebieg, podzespoły sprawne, silnik na owies, stan bardzo dobry.', 0, 0, '2023-06-13', '0000-00-00', 0, 0, 0, NULL, 1200, 1),
(19, 4, 1, 'Dorożka dwukonna', 'Do renowacji', 1, 1, '2023-06-14', '0000-00-00', 2, 4, 0, NULL, 250, 2),
(20, 4, 4, 'Napój życia', 'Poprawia gojenie ran.', 0, 1, '2023-06-14', '2023-06-14', 1, 4, 0, NULL, 12, 3); -- dane wstawione do tabeli auctions

-- --------------------------------------------------------

-- Struktura tabeli dla tabeli `category`  -- definicja struktury tabeli category

CREATE TABLE `category` ( -- tworzenie tabeli category
  `categoryid` int(11) NOT NULL, -- identyfikator kategorii
  `name` varchar(100) DEFAULT NULL, -- nazwa kategorii
  `in_tree` int(11) DEFAULT NULL  -- wskaźnik przynależności do drzewa kategorii
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; -- tabela category utworzona z silnikiem InnoDB i zestawem znaków utf8mb4

-- Zrzut danych tabeli `category`  -- wstawienie danych do tabeli category

INSERT INTO `category` (`categoryid`, `name`, `in_tree`) VALUES
(1, 'Motoryzacja', 0),
(3, 'Praca', 0),
(4, 'Zdrowie i Uroda', 0),
(5, 'Elektronika', 0),
(6, 'Moda', 0),
(7, 'Zwierzęta', 0),
(8, 'Wypożyczalnia', 0),
(9, 'Sport', 0),
(10, 'Hobby', 0); -- dane wstawione do tabeli category

-- --------------------------------------------------------

-- Struktura tabeli dla tabeli `currency`  -- definicja struktury tabeli currency

CREATE TABLE `currency` ( -- tworzenie tabeli currency
  `currencyid` int(10) NOT NULL, -- identyfikator waluty
  `currency_name` varchar(20) NOT NULL  -- nazwa waluty
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; -- tabela currency utworzona z silnikiem InnoDB i zestawem znaków utf8mb4

-- Zrzut danych tabeli `currency`  -- wstawienie danych do tabeli currency

INSERT INTO `currency` (`currencyid`, `currency_name`) VALUES
(1, 'złoto'),
(2, 'srebro'),
(3, 'miedź'),
(4, 'diament'); -- dane wstawione do tabeli currency

-- --------------------------------------------------------

-- Struktura tabeli dla tabeli `file_to_auction`  -- definicja struktury tabeli file_to_auction

CREATE TABLE `file_to_auction` ( -- tworzenie tabeli file_to_auction
  `file_id` int(11) NOT NULL, -- identyfikator pliku
  `auctionid` int(11) NOT NULL, -- identyfikator powiązanej aukcji
  `filename` varchar(255) NOT NULL, -- nazwa pliku
  `file_path` varchar(255) NOT NULL  -- ścieżka do pliku
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; -- tabela file_to_auction utworzona z silnikiem InnoDB i zestawem znaków utf8mb4

-- --------------------------------------------------------

-- Struktura tabeli dla tabeli `message`  -- definicja struktury tabeli message

CREATE TABLE `message` ( -- tworzenie tabeli message
  `id` int(11) NOT NULL, -- identyfikator wiadomości
  `mlid` int(11) NOT NULL, -- identyfikator powiązania wiadomości
  `auctionid` int(11) NOT NULL, -- identyfikator aukcji powiązanej z wiadomością
  `buyerid` int(3) NOT NULL, -- identyfikator kupującego
  `answer` tinyint(1) NOT NULL, -- wskaźnik odpowiedzi (0 - wiadomość pierwotna, 1 - odpowiedź)
  `date` datetime NOT NULL DEFAULT current_timestamp(), -- data wysłania wiadomości
  `description` text DEFAULT NULL  -- treść wiadomości
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; -- tabela message utworzona z silnikiem InnoDB i zestawem znaków utf8mb4

-- Zrzut danych tabeli `message`  -- wstawienie danych do tabeli message

INSERT INTO `message` (`id`, `mlid`, `auctionid`, `buyerid`, `answer`, `date`, `description`) VALUES
(1, 1, 1, 1, 0, '2023-06-06 00:00:00', 'Czy miecz Glamdring nadal jest dostępny?'),
(2, 2, 1, 1, 1, '2023-06-07 00:00:00', 'Tak, miecz Glamdring jest wciąż dostępny. Czy jesteś zainteresowany zakupem?'),
(3, 3, 1, 1, 0, '2023-06-07 00:00:00', 'Tak, jestem zainteresowany. Czy mogę obejrzeć miecz przed zakupem?'),
(4, 4, 1, 1, 1, '2023-06-08 00:00:00', 'Oczywiście, możemy umówić się na spotkanie. Gdzie mogę Cię spotkać?'),
(5, 5, 2, 2, 0, '2023-06-06 00:00:00', 'Czy ten Jeden Pierścień jest oryginalny?'),
(6, 6, 2, 1, 1, '2023-06-07 00:00:00', 'Tak, ten Pierścień jest oryginalny i posiada potężne moce. Czy chcesz go kupić?'),
(7, 7, 2, 4, 0, '2023-06-07 00:00:00', 'Tak, jestem zainteresowany. Czy mogę go przetestować przed zakupem?'),
(8, 8, 2, 3, 1, '2023-06-08 00:00:00', 'Niestety, nie można przetestować tego Pierścienia. Ale mogę zapewnić Cię, że jest w doskonałym stanie.'),
(9, 9, 3, 2, 0, '2023-06-06 00:00:00', 'Czy amulet Yennefer jest nadal dostępny?'),
(10, 10, 3, 1, 1, '2023-06-07 00:00:00', 'Tak, amulet Yennefer jest nadal dostępny. Czy chciałbyś go zakupić?'),
(11, 11, 3, 4, 0, '2023-06-07 00:00:00', 'Tak, jestem zainteresowany. Czy mogę obejrzeć amulet osobiście?'),
(12, 12, 3, 3, 1, '2023-06-08 00:00:00', 'Oczywiście, możemy się spotkać. Gdzie chciałbyś się spotkać?'),
(13, 13, 4, 2, 0, '2023-06-06 00:00:00', 'Czy medalion Wiedźmina jest wciąż dostępny?'),
(14, 14, 4, 1, 1, '2023-06-07 00:00:00', 'Tak, medalion Wiedźmina jest nadal dostępny. Czy jesteś zainteresowany zakupem?'),
(15, 15, 4, 4, 0, '2023-06-07 00:00:00', 'Tak, jestem zainteresowany. Czy mogę obejrzeć medalion przed zakupem?'),
(16, 16, 4, 3, 1, '2023-06-08 00:00:00', 'Oczywiście, możemy umówić się na spotkanie. Gdzie chciałbyś się spotkać?'),
(22, 0, 11, 4, 1, '2023-06-13 00:00:00', 'Dzień dobry jestem zainteresowany produktem'); -- dane wstawione do tabeli message

-- --------------------------------------------------------

-- Struktura tabeli dla tabeli `message_link`  -- definicja struktury tabeli message_link

CREATE TABLE `message_link` ( -- tworzenie tabeli message_link
  `mlid` int(11) NOT NULL, -- identyfikator powiązania wiadomości
  `auctionid` int(11) NOT NULL, -- identyfikator aukcji powiązanej z wiadomością
  `sellerid` int(11) NOT NULL, -- identyfikator sprzedawcy
  `buyerid` int(11) NOT NULL  -- identyfikator kupującego
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; -- tabela message_link utworzona z silnikiem InnoDB i zestawem znaków utf8mb4

-- Zrzut danych tabeli `message_link`  -- wstawienie danych do tabeli message_link

INSERT INTO `message_link` (`mlid`, `auctionid`, `sellerid`, `buyerid`) VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, 3, 3, 1),
(4, 4, 4, 1),
(5, 1, 1, 2),
(6, 2, 2, 1),
(7, 3, 3, 4),
(8, 4, 4, 3),
(9, 1, 1, 2),
(10, 2, 2, 1),
(11, 3, 3, 4),
(12, 4, 4, 3),
(13, 1, 1, 2),
(14, 2, 2, 1),
(15, 3, 3, 4),
(16, 4, 4, 3); -- dane wstawione do tabeli message_link

-- --------------------------------------------------------

-- Struktura tabeli dla tabeli `type`  -- definicja struktury tabeli type

CREATE TABLE `type` ( -- tworzenie tabeli type
  `type_id` varchar(3) NOT NULL, -- identyfikator typu konta
  `type_name` varchar(20) NOT NULL  -- nazwa typu konta
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; -- tabela type utworzona z silnikiem InnoDB i zestawem znaków utf8mb4

-- Zrzut danych tabeli `type`  -- wstawienie danych do tabeli type

INSERT INTO `type` (`type_id`, `type_name`) VALUES
('101', 'Administrator'),
('222', 'Użytkownik'); -- dane wstawione do tabeli type

-- Indeksy dla zrzutów tabel  -- definiowanie indeksów

-- Indeksy dla tabeli `accounts`
ALTER TABLE `accounts` ADD PRIMARY KEY (`accountid`); -- dodanie klucza głównego dla tabeli accounts

-- Indeksy dla tabeli `auctions`
ALTER TABLE `auctions` ADD PRIMARY KEY (`auctionid`); -- dodanie klucza głównego dla tabeli auctions

-- Indeksy dla tabeli `category`
ALTER TABLE `category` ADD PRIMARY KEY (`categoryid`); -- dodanie klucza głównego dla tabeli category

-- Indeksy dla tabeli `currency`
ALTER TABLE `currency` ADD PRIMARY KEY (`currencyid`); -- dodanie klucza głównego dla tabeli currency

-- Indeksy dla tabeli `file_to_auction`
ALTER TABLE `file_to_auction` ADD PRIMARY KEY (`file_id`), ADD KEY `auctionid` (`auctionid`); -- dodanie klucza głównego i indeksu dla tabeli file_to_auction

-- Indeksy dla tabeli `message`
ALTER TABLE `message` ADD PRIMARY KEY (`id`), ADD KEY `auctionid` (`auctionid`); -- dodanie klucza głównego i indeksu dla tabeli message

-- Indeksy dla tabeli `message_link`
ALTER TABLE `message_link` ADD PRIMARY KEY (`mlid`), ADD KEY `auctionid` (`auctionid`), ADD KEY `sellerid` (`sellerid`), ADD KEY `buyerid` (`buyerid`); -- dodanie klucza głównego i indeksów dla tabeli message_link

-- Indeksy dla tabeli `type`
ALTER TABLE `type` ADD PRIMARY KEY (`type_id`); -- dodanie klucza głównego dla tabeli type

-- AUTO_INCREMENT dla zrzuconych tabel  -- ustawienie wartości AUTO_INCREMENT

-- AUTO_INCREMENT dla tabeli `accounts`
ALTER TABLE `accounts` MODIFY `accountid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12; -- ustawienie AUTO_INCREMENT dla tabeli accounts

-- AUTO_INCREMENT dla tabeli `auctions`
ALTER TABLE `auctions` MODIFY `auctionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24; -- ustawienie AUTO_INCREMENT dla tabeli auctions

-- AUTO_INCREMENT dla tabeli `category`
ALTER TABLE `category` MODIFY `categoryid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11; -- ustawienie AUTO_INCREMENT dla tabeli category

-- AUTO_INCREMENT dla tabeli `currency`
ALTER TABLE `currency` MODIFY `currencyid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5; -- ustawienie AUTO_INCREMENT dla tabeli currency

-- AUTO_INCREMENT dla tabeli `file_to_auction`
ALTER TABLE `file_to_auction` MODIFY `file_id` int(11) NOT NULL AUTO_INCREMENT; -- ustawienie AUTO_INCREMENT dla tabeli file_to_auction

-- AUTO_INCREMENT dla tabeli `message`
ALTER TABLE `message` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24; -- ustawienie AUTO_INCREMENT dla tabeli message

-- AUTO_INCREMENT dla tabeli `message_link`
ALTER TABLE `message_link` MODIFY `mlid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17; -- ustawienie AUTO_INCREMENT dla tabeli message_link

-- Ograniczenia dla zrzutów tabel  -- definiowanie ograniczeń kluczy obcych

-- Ograniczenia dla tabeli `file_to_auction`
ALTER TABLE `file_to_auction` ADD CONSTRAINT `file_to_auction_ibfk_1` FOREIGN KEY (`auctionid`) REFERENCES `auctions` (`auctionid`) ON DELETE CASCADE; -- dodanie ograniczenia klucza obcego dla tabeli file_to_auction

-- Ograniczenia dla tabeli `message`
ALTER TABLE `message` ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`auctionid`) REFERENCES `auctions` (`auctionid`) ON DELETE CASCADE; -- dodanie ograniczenia klucza obcego dla tabeli message

-- Ograniczenia dla tabeli `message_link`
ALTER TABLE `message_link` ADD CONSTRAINT `message_link_ibfk_1` FOREIGN KEY (`auctionid`) REFERENCES `auctions` (`auctionid`) ON DELETE CASCADE, ADD CONSTRAINT `message_link_ibfk_2` FOREIGN KEY (`sellerid`) REFERENCES `accounts` (`accountid`), ADD CONSTRAINT `message_link_ibfk_3` FOREIGN KEY (`buyerid`) REFERENCES `accounts` (`accountid`); -- dodanie ograniczeń klucza obcego dla tabeli message_link

COMMIT; -- zatwierdzenie transakcji

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */; -- przywrócenie poprzedniego zestawu znaków klienta
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */; -- przywrócenie poprzedniego zestawu znaków wyników
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */; -- przywrócenie poprzedniego porządku zestawu znaków
