<?php

require_once 'databaseConnection.php';

class Auction {
    private $db;

    // Konstruktor obiektu
    public function __construct() {
        $this->db = Database::getInstance(); 
    }

    // Pobranie wszystkich aukcji
   public function getAllAuction($selled = 0, $veryfied = 1){
    $query = "SELECT * FROM auctions WHERE selled = :selled AND veryfied = :veryfied";
    $stmt = $this->db->query($query);
    $stmt->bindParam(':selled', $selled, PDO::PARAM_INT);
    $stmt->bindParam(':veryfied', $veryfied, PDO::PARAM_INT);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
   }

   // Pobranie wszystkich aukcji
   public function getBannerAuction(){
    $query = "SELECT title, auctionid FROM auctions WHERE selled = 0 AND veryfied = 1 ORDER BY auctionid DESC LIMIT 4";
    $stmt = $this->db->query($query);
    return $stmt;
   }

    // Pobierz kategorie z bazy danych
    public function getCategories() {
    $query = "SELECT categoryid, name FROM category";
    $stmt = $this->db->query($query);
    $stmt->execute();
	return $result = $stmt->get_result();

    }

    // Pobierz waluty z bazy danych
    public function getCurrencies() {
    $query = "SELECT * FROM currency";
    $stmt = $this->db->query($query);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

   // Pobieranie danych pojedynczej aukcji
   public function getAuctionById($auctionid) {
    $stmt = $this->db->prepare("SELECT a.*, u.login, u.phone, c.currency_name FROM auctions a
                                LEFT JOIN accounts u ON a.accountid = u.accountid
                                LEFT JOIN currency c ON a.currencyid = c.currencyid
                                WHERE a.auctionid = :auctionid");
    $stmt->bindParam(':auctionid', $auctionid, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Wyszukiwanie listy po frazie

    // Dodawanie nowej aukcji
    public function addAuction($title, $categoryid, $description, $used, $private, $price, $currencyid, $accountid) {
        $query = "INSERT INTO auctions (title, categoryid, description, used, private, price, currencyid, accountid) 
                  VALUES (:title, :categoryid, :description, :used, :private, :price, :currencyid, :accountid)";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':title', $title);
        $stmt->bindParam(':categoryid', $categoryid);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':used', $used, PDO::PARAM_BOOL);
        $stmt->bindParam(':private', $private, PDO::PARAM_BOOL);
        $stmt->bindParam(':price', $price);
        $stmt->bindParam(':currencyid', $currencyid);
        $stmt->bindParam(':accountid', $accountid);
        $stmt->execute();
    }

    // Modyfikowanie aukcji
    public function updateAuction($title, $categoryid, $description, $used, $private, $price, $currencyid, $accountid, $auctionid) {
        $query = "UPDATE auctions 
                  SET title = :title, categoryid = :categoryid, 
                  description = :description, used = :used, 
                  private = :private, price = :price, 
                  currencyid = :currencyid, accountid = :accountid 
                  WHERE auctionid = :auctionid;";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':title', $title);
        $stmt->bindParam(':categoryid', $categoryid);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':used', $used, PDO::PARAM_BOOL);
        $stmt->bindParam(':private', $private, PDO::PARAM_BOOL);
        $stmt->bindParam(':price', $price);
        $stmt->bindParam(':currencyid', $currencyid);
        $stmt->bindParam(':accountid', $accountid);
        $stmt->bindParam(':auctionid', $auctionid);
        $stmt->execute();
    }

    // Usuwanie aukcji
    public function deleteAuction($auctionid) {
        $query = "DELETE FROM auctions WHERE auctionid = :auctionid";
            $stmt = $pdo->prepare($query);
            $stmt->bindParam(':auctionid', $auctionId);
            $stmt->execute();
        header("Location: ../view/userauctions.php");
    }


}

?>