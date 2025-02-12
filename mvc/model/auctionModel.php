<?php

require_once 'databaseConnection.php';

class Auction {
    private $db;

    // Konstruktor obiektu
    public function __construct() {
        $this->db = Database::getInstance(); 
    }

    // Pobranie wszystkich aukcji
   public function getAllAuction(){
    $query = "SELECT * FROM auctions a
                LEFT JOIN accounts u ON a.accountid = u.accountid 
                LEFT JOIN currency c ON a.currencyid = c.currencyid
                WHERE a.selled = 0 AND a.veryfied = 1";
    $stmt = $this->db->query($query);
    $stmt->execute();
    return $stmt;
   }

   // Pobranie aukcji do banneru
   public function getBannerAuction(){
    $query = "SELECT title, auctionid FROM auctions WHERE selled = 0 AND veryfied = 1 ORDER BY auctionid DESC LIMIT 4";
    $stmt = $this->db->query($query);
    return $stmt;
   }

     // Pobranie wszystkich aukcji aktualnych
   public function getAllAuction4User($accountId){
    $query = "SELECT auctions.*, accounts.accountid, category.name AS category_name, auctions.veryfied
              FROM auctions
              INNER JOIN accounts ON auctions.accountid = accounts.accountid
              LEFT JOIN category ON auctions.categoryid = category.categoryid
              WHERE accounts.accountid = :accountid AND auctions.veryfied <> 2 AND auctions.selled = 0";
    $stmt = $this->db->prepare($query);
    $stmt->bindParam(':accountid', $accountId);
    $stmt->execute();
    return $stmt;
   }

    // Pobranie wszystkich aukcji aktualnych
    public function getAllAuction4UserUnactive($accountId){
        $query = "SELECT auctions.*, accounts.accountid, category.name AS category_name, auctions.veryfied
                  FROM auctions
                  INNER JOIN accounts ON auctions.accountid = accounts.accountid
                  LEFT JOIN category ON auctions.categoryid = category.categoryid
                  WHERE accounts.accountid = :accountid AND auctions.veryfied = 2 AND auctions.selled = 0";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':accountid', $accountId);
        $stmt->execute();
        return $stmt;
    }

    // Pobierz kategorie z bazy danych
    public function getCategories() {
    $query = "SELECT categoryid, name FROM category";
    $stmt = $this->db->query($query);
    $stmt->execute();
	return $stmt;

    }

    // Pobierz waluty z bazy danych
    public function getCurrencies() {
    $query = "SELECT * FROM currency";
    $stmt = $this->db->query($query);
    $stmt->execute();
    return $stmt;
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
    public function getAuctionBySearch($searchbar) {
    $query = "SELECT * FROM auctions a
                                LEFT JOIN accounts u ON a.accountid = u.accountid 
                                LEFT JOIN currency c ON a.currencyid = c.currencyid
                                WHERE a.selled = 0 AND a.veryfied = 1 
                                AND a.title LIKE :searchbar
                                OR a.description LIKE :searchbar";
    $stmt = $this->db->prepare($query);
    $stmt->bindParam(':searchbar', $searchbar);
    $stmt->execute();
    return $stmt;
    }

    // Wyszukiwanie listy po frazie
    public function getAuctionByCategory($searchbar) {
        $query = "SELECT * FROM auctions a
                                LEFT JOIN accounts u ON a.accountid = u.accountid 
                                LEFT JOIN currency c ON a.currencyid = c.currencyid
                                WHERE a.selled = 0 AND a.veryfied = 1 
                                AND a.categoryid = :categoryid";
    $stmt = $this->db->prepare($query);
    $stmt->bindParam(':categoryid', $categoryid);
    $stmt->execute();
    return $stmt;
    }

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