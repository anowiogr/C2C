<?php

include_once '../model/auctionModel.php';
$model = new Auction();

try {
    //var_dump($_GET["verifyed"]);
        if($_GET["verifyed"] == "true"){
            $veryfied = 1;
        } else {
            $veryfied = 2;
        }
        $stmt = $model -> veryfyAuction($veryfied , $_GET["id"], $_GET["auction_id"]);
       
        header("location: ../view/administrativs/admin.php");

} catch (PDOException $e) {
    echo "Błąd połączenia: " . $e->getMessage();
}

?>