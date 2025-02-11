<?php

class Administrative {
    private $db;

    // Konstruktor obiektu
    public function __construct() {
        $this->db = Database::getInstance(); 
    }

    // Sprawdź uprawnienia usera
    public function checkAdmin($accountid) {
        $query = "SELECT account_type FROM accounts WHERE accountid = :accountid";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':accountid', $this->accountid, PDO::PARAM_INT);
        $stmt->execute();
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

    }

    // Pobierz wszystkie niezweryfikowane aukcje
    public function getUnverifiedAuctions() {
        $query = "SELECT 
                    a.auctionid, a.title, a.selled, u.firstname, u.lastname, u.city, a.date_start, a.price, c.currency_name
                  FROM auctions a
                  LEFT JOIN accounts u ON a.accountid = u.accountid 
                  LEFT JOIN currency c ON a.currencyid = c.currencyid
                  WHERE a.veryfied = 0";
        $stmt = $this->db->query($query);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Pobierz wszystkich nowych
    public function getNewUsers($status = 0) {
        $query = "SELECT * FROM `accounts` WHERE `verified` = :status";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':status', $status, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>
