<?php

include_once '../model/auctionModel.php';
include_once '../model/messageModel.php';
$modelAuction = new Auction();
$modelMessage = new Message();

try {

    $stmt = $modelAuction -> buyAuction($buyerid, $_GET['auction_id']);
    $msg = $modelMessage -> sendMessage($_GET['auction_id'], $buyerid, 'Kupiono przedmiot aukcji', 0);

    header("location: ../view/auctions/auction.php");

} catch (PDOException $e) {
    echo "Błąd połączenia: " . $e->getMessage();
}
?>