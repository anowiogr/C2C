<?php

require_once 'databaseConnection.php';

class Message {
    private $db;

    //Konstruktor obiektu
    public function __construct() {
        $this->db = Database::getInstance();
    }

    // Pobranie wszystkich wiadomości dla użytkownika
    // - dla ofert sprzedaży

     public function getSellMessages($account_id) {
        $query = "SELECT DISTINCT m.auctionid, m.buyerid, x.accountid as seller, a.login, x.title
                  FROM message m
                  LEFT JOIN auctions x ON m.auctionid = x.auctionid
                  LEFT JOIN accounts a ON m.buyerid = a.accountid
                  WHERE m.answer != 0 AND x.accountid = :accountid";
        $stmt = $this->db->prepare($query);
        $stmt->bindValue(':accountid', $account_id);
        $stmt->execute();
        return $stmt;
    }

    // -dla ofert kupna
    public function getBuyMessages($account_id) {
        $query = "SELECT DISTINCT m.auctionid, m.buyerid, x.accountid as seller, a.login, x.title
                  FROM message m
                  LEFT JOIN auctions x ON m.auctionid = x.auctionid
                  LEFT JOIN accounts a ON m.buyerid = a.accountid
                  WHERE m.answer != 0 AND x.accountid <> :accountid";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':accountid', $account_id);
        $stmt->execute();
        return $stmt;

    }

    // Pobranie całej konwersacji
     public function getMessages($auctionid, $buyerid) {
        $query = "SELECT id, answer, date, description FROM message 
                  WHERE auctionid = :auctionid AND buyerid= :buyerid;";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':auctionid', $auctionid);
        $stmt->bindParam(':buyerid', $buyerid);
        $stmt->execute();
        return $stmt;
    }


    // Wysłanie wiadomości
    public function sendMessage($auctionid, $buyerid, $description, $answer) {
        $query = "INSERT INTO message (auctionid, buyerid, description, answer, date) 
                  VALUES (:auctionid, :buyerid, :description, :answer, NOW())";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':auctionid', $auctionid);
        $stmt->bindParam(':buyerid', $buyerid);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':answer', $answer);
        $stmt->execute();
    }

    //Pobranie tytułu wiadomości
    public function messageTitle($auctionid){
        $query = "SELECT title FROM auctions WHERE auctionid = :auctionId";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':auctionId', $auctionid, PDO::PARAM_INT);
        $stmt->execute();
        $auction = $stmt->fetch(PDO::FETCH_ASSOC); 
    }
   
}

?>
