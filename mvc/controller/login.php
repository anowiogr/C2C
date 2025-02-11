<?php
session_start();

foreach ($_POST as $value){
	if (empty($value)){
		$_SESSION["error"] = "Wypełnij wszystkie dane!";
		echo "<script>history.back();</script>";
		exit();
	}
}
$config = include 'C:/xampp/htdocs/c2c/config/config.php';
require_once $config['baseurl'].'/mvc/model/userModel.php';

try {
	$connect = new userModel();
    $connect -> veryfiyUser($_POST["login"], $_POST["email"]);

	if ($connect->num_rows != 0){

		$user = $connect->fetch_assoc();
		$stmt->close();

        $pass = password_hash($_POST["pass"], PASSWORD_ARGON2ID);

        if($user["verified"]==1) {
            if (password_verify($_POST["pass"], $user["password"])) {
                $_SESSION["logged"]["firstName"] = $user["firstname"];
                $_SESSION["logged"]["lastName"] = $user["lastname"];
                $_SESSION["logged"]["session_id"] = session_id();
                $_SESSION["logged"]["account_id"] = $user["accountid"];
                //echo  session_status();
                $_SESSION["logged"]["account_type"] = $user["account_type"];
                $_SESSION["logged"]["last_activity"] = time();
                //print_r($_SESSION["logged"]);
                header("location: ../logged.php");
            } else {
                $_SESSION["error"] = "Nie udało się zalogować!";
                echo "<script>history.back();</script>";
            }
        }elseif($user["verified"]==0){
            $_SESSION["error"] = "Konto nie zostało zweryfikowane przez administratorów, proszę czekać";
            echo "<script>history.back();</script>";
        }elseif($user["verified"]==2){
            $_SESSION["error"] = "Konto zostało odrzucone przez admina, aby dowiedzieć się dlaczego napisz do nas";
            echo "<script>history.back();</script>";
        }else{
            $_SESSION["error"] = "Nieznany błąd";
            echo "<script>history.back();</script>";
        }

	}else{
        $_SESSION["error"] = "Brak adresu email w bazie!";
        echo "<script>history.back();</script>";
	}
} catch (mysqli_sql_exception $e) {
	$_SESSION["error"] = $e->getMessage();
	echo "error";
	exit();
}