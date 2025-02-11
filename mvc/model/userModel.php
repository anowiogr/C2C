<?php

require_once 'databaseConnection.php';

class User {
    private $db;

    //Konstruktor obiektu
    public function __construct() {
        $this->db = Database::getInstance();
    }

    // Pobranie listy userów
    public function geAllUser() {
        $query = "SELECT accounts.*, type.type_name,
                  CASE WHEN accounts.verified = 1 THEN 'TAK' ELSE 'NIE' END as verifiedtext
                  FROM accounts
                  LEFT JOIN type ON accounts.account_type = type.type_id
                WHERE accounts.is_deleted = false";
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Pobieranie informacji o userze
    public function getUserById($accountid) {
        $query = "SELECT accounts.*, type.type_name,
                  CASE WHEN accounts.verified = 1 THEN 'TAK' ELSE 'NIE' END as verifiedtext
                  FROM accounts
                  LEFT JOIN type ON accounts.account_type = type.type_id
                WHERE accounts.accountid = :accountid";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':accountid', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    //Weryfikacja usera
    public function veryfiyUser($login, $email){
        $query = "SELECT * FROM accounts WHERE login = :login OR email = :email";
        $stmt = $this->db->prepare($query);
	    $stmt->bindParam(':login', $login);
        $stmt->bindParam(':email', $email);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Dodanie usera
    public function insertUser($firstname, $lastname, $email,$login, $password){
        $query = "INSERT INTO accounts (firstname, lastname, email,login, password, verified)
                VALUES (:firstname, :lastname, :email,:login, :password, 0)";
        $pass = password_hash($password, PASSWORD_ARGON2ID);
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':firstname', $firstname);
        $stmt->bindParam(':lastname', $lastname);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':login', $login);
        $stmt->bindParam(':password', $pass);
        return $stmt->execute();
    }

    // Modyfikowanie usera
    public function updateUser($accountid, $firstname, $lastname, $email, $phone, $address, $codezip, $city, $contury) {
        $query = "UPDATE accounts 
                SET firstname = :firstname, lastname = :lastname, 
                email = :email, phone = :phone, 
                address = :address, codezip = :codezip, 
                city = :city, country = :country 
                WHERE accountid = :accountid";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':firstname', $firstname);
        $stmt->bindParam(':listname', $lastname);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':phone', $phone);
        $stmt->bindParam(':address', $address);
        $stmt->bindParam(':codezip', $codezip);
        $stmt->bindParam(':city', $city);
        $stmt->bindParam(':contury', $contury);
        return $stmt->execute();
    }

    // Oznaczenie usera jako usuniętego
    public function deleteUser($accountid){
        $query = "UPDATE accounts 
                  SET is_deleted = true
                  WHERE accountid = :accountid";
        $stmt = $this->db->prepare($query);  
        $stmt->bindParam(':accountid', $accountid);        
        return $stmt->execute();
    }

    // Zmiana hasła usera
    public function updatePassword($login, $email, $newPassword) {
        $stmt = $this->pdo->prepare("UPDATE accounts SET password = :password WHERE login = :login AND email = :email");
        $hashedPassword = password_hash($newPassword, PASSWORD_ARGON2ID);
        $stmt->bindParam(':password', $hashedPassword);
        $stmt->bindParam(':login', $login);
        $stmt->bindParam(':email', $email);
        return $stmt->execute();
    }
}
?>