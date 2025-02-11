<?php

require_once 'Database.php';

class userPasswordController {
    private $pdo;

    public function __construct() {
        $database = new Database();
        $this->pdo = $database->getConnection();
    }

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

   
}

    ?>