<?php

include_once '../model/auctionModel.php';
$model = new Auction();

try {
    $stmt = $model -> getAuctionById($_POST["auctionid"]);
    if($stmt){
            $title = $stmt["title"] == $_POST["title"] && !$_POST["title"] ? $stmt["title"] : $_POST["title"];
            $categoryid = $stmt["categoryid"] == $_POST["categoryid"] && !$_POST["categoryid"] ? $stmt["categoryid"] : $_POST["categoryid"];
            $description = $stmt["description"] == $_POST["description"] && !$_POST["description"] ? $stmt["description"] : $_POST["description"];
            $used = isset($_POST["used"]) ? $_POST["used"] : false;
            $price = $stmt["price"] == $_POST["price"] && !$_POST["price"] ? $stmt["price"] : $_POST["price"];
            $currencyid = $stmt["currencyid"] == $_POST["currencyid"] && !$_POST["currencyid"] ? $stmt["currencyid"] : $_POST["currencyid"];
            $auctionid = $stmt["auctionid"] == $_POST["auctionid"] && !$_POST["auctionid"] ? $stmt["auctionid"] : $_POST["auctionid"];

            $stmt = $model -> updateAuction($title, $categoryid, $description, $used, 1, $price, $currencyid, $auctionid);

            header("location: ../view/auctions/userauctions.php");
    }

} catch (PDOException $e) {
    echo "Błąd połączenia: " . $e->getMessage();
}
?>