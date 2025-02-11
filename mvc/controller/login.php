<?php
session_start();

foreach ($_POST as $value){
	if (empty($value)){
		$_SESSION["error"] = "Wypełnij wszystkie dane!";
		echo "<script>history.back();</script>";
		exit();
	}
}
$config = include 'C:/xampp/htdocs/inż/c2c/config/config.php';
include_once '../model/userModel.php';

try {
	$model = new User();
    $connect = $model -> veryfiyUser($_POST["email"], $_POST["email"]);

	if ($connect){

		$user = $connect;

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
                header("location: ./logged.php");
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