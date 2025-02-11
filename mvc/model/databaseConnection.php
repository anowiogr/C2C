<?php

class Database {

    private static $instance = null;

    private $pdo;

    private function __construct() {

        $config = require __DIR__ . '/../../config/config.php';

        $dsn = "mysql:host={$config['host']};dbname={$config['dbname']};charset=utf8mb4";
        
        try {
            $this->pdo = new PDO($dsn, $config['user'], $config['password'], [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false
            ]);
        } catch (PDOException $e) {

            die("Błąd połączenia z bazą danych: " . $e->getMessage());

        }
    }

    public static function getInstance() {
        if (!self::$instance) {
            self::$instance = new Database();
        }
        return self::$instance->pdo;
    }

}
