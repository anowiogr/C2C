<?php

require_once '/model/auctionModel.php';
require_once '/model/userModel.php';

class auctionController {

    private $auctionModel;
    private $userModel;

    public function __construct() {
        $this->auctionModel = new Auction();
        $this->userModel = new User();
    }

    // Pobierz dane o użytkowniku
    public function profile() {
        session_start();
        if (!isset($_SESSION['logged']['account_id'])) {
            header(include 'Location:'.__DIR__.'/../mvc/view/login.php');
            exit();
        }

        $user = $this->userModel->getUserById($_SESSION['logged']['account_id']);

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $updated = $this->userModel->updateUser($_POST);
            $user = $this->userModel->getUserById($_SESSION['logged']['account_id']);
        }

        include __DIR__ . '/../mvc/view/user_profile.php';
    }

    // Zweryfikuj dane rejestracji
    public function validateRegistration($data) {
        $errors = [];

        foreach ($data as $value) {
            if (empty($value)) {
                $errors[] = "Wypełnij wszystkie dane!";
            }
        }

        if (!isset($data['terms'])) {
            $errors[] = "Zatwierdź regulamin!";
        }

        if ($data["pass1"] !== $data["pass2"]) {
            $errors[] = "Hasła są różne!";
        }

        if ($data["email1"] !== $data["email2"]) {
            $errors[] = "Adresy email są różne!";
        }

        return $errors;
    }

    // Zweryfikuj dane dot. hasła
    public function validatePasswordUpdate($data) {
        $errors = [];

        foreach ($data as $value) {
            if (empty($value)) {
                $errors[] = "Wypełnij wszystkie dane!";
            }
        }

        if ($data["pass1"] !== $data["pass2"]) {
            $errors[] = "Hasła nie są identyczne!";
        }

        return $errors;
    }

    //Pokaż aukcje usera
    public function showUserAuctions($accountId) {
        $user = $this->userModel->getUserById($accountId);
        $activeAuctions = $this->auctionModel->getUserActiveAuctions($accountId);
        $inactiveAuctions = $this->auctionModel->getUserInactiveAuctions($accountId);
        include __DIR__ . '/../mvc/view/user_auctions.php';
    }
}

?>