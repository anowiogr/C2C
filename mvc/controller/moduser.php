<?php

include_once '../model/userModel.php';
$model = new User();

try {
  
        if($_GET["verifyed"] == "true"){
            $veryfied = 1;
        } else {
            $veryfied = 2;
        }
        $stmt = $model -> veryfiyUserByAdmin($veryfied , $_GET["id"], $_GET["accountid"]);
       
        header("location: ../view/administrativs/admin.php");

} catch (PDOException $e) {
    echo "Błąd połączenia: " . $e->getMessage();
}

?>