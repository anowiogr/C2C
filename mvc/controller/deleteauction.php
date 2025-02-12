<?php

include_once '../model/auctionModel.php';
$model = new Auction();

try {

    $stmt = $model -> deleteAuction($_GET['auction_id']);

   // header("location: ../view/auctions/userauctions.php");

} catch (PDOException $e) {
    echo "Błąd połączenia: " . $e->getMessage();
}
?>