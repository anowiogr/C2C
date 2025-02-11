<?php

session_start();


    foreach ($_POST as $value) {
        if (empty($value)) {
            $_SESSION["error"] = "Wypełnij wszystkie dane!";
            echo "<script>history.back();</script>";
            exit();
        }
    }

require_once '../model/userModel.php';
$model = new User();

try {


    if($_POST["pass1"]==$_POST["pass2"]){

        $stmt = $model -> updatePassword( $_POST["login"],$_POST["email"],$_POST["pass1"]);

        $_SESSION["succes"] = "Hasło zostało zmienione";
        header("location: ../view/main/login.php");


    } else {
        $_SESSION["error"] = "Hasła nie są identyczne!";
        echo "<script>history.back();</script>";
    }

} catch (mysqli_sql_exception $e) {
	$_SESSION["error"] = $e->getMessage();
	echo "error";
    echo $_SESSION["error"];
	exit();
}


?>
