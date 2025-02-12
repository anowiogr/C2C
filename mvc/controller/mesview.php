<<?php
session_start();
include_once '../model/messageModel.php';
//print_r($_POST);
$model = new Message();
try {

    $stmt = $model -> sendMessage($_POST["auctionid"], $_POST["buyerid"], $_POST["description"], $_POST["answer"]);

    header("location: ../view/messages/messageview.php?aid=$_POST[buyerid]&bid=$_POST[buyerid]");

} catch (PDOException $e) {
    echo "Błąd połączenia: " . $e->getMessage();
}


?>