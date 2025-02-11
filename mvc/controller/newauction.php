<?php

include_once '../model/auctionModel.php';
$model = new Auction();

try {
    
$stmt = $model -> addAuction($_POST["title"],$_POST["description"],$_POST["used"],true,$_POST["categoryid"],$_POST["currencyid"],$_POST["price"], $_POST["account_id"]);


header("location: ../view/auctions/userauctions.php");

} catch (PDOException $e) {
    echo "Błąd połączenia: " . $e->getMessage();
}

?>