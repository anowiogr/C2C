<?php
session_start();
//var_dump($_GET["categoryid"]);
if(isset($_GET["categoryid"]) && $_GET["categoryid"]<>null){
    $_SESSION["filter"]["categoryid"] = $_GET["categoryid"];
    header('Location: ../view/auctions/auction.php');
}

if(isset($_GET["search"])){
        $_SESSION["filter"]["search"] = $_GET["search"];
    header('Location: ../view/auctions/auction.php');
}
?>