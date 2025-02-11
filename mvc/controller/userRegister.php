<?php
session_start();
include_once '../model/userModel.php';

$model = new User();

foreach ($_POST as $value){
	if (empty($value)){
		$_SESSION["error"] = "Wypełnij wszystkie dane!";
		echo "<script>history.back();</script>";
		exit();
	}
}


$error = 0;
if (!isset($_POST["terms"])){
	$error = 1;
	$_SESSION["error"] = "Zatwierdź regulamin!";
}

if ($_POST["pass1"] != $_POST["pass2"]){
	$error = 1;
	$_SESSION["error"] = "Hasła są różne!";
}

if ($_POST["email1"] != $_POST["email2"]){
	$error = 1;
	$_SESSION["error"] = "Adresy email są różne!";
}



if ($error != 0){
	echo "<script>history.back();</script>";
	exit();
}

try {

    $stmt = $model -> insertUser($_POST["firstName"], $_POST["lastName"], $_POST["email1"],$_POST["nick"], $_POST["pass1"]);

	if ($stmt){
		$_SESSION["success"] = "Zostałeś zarejestrowany, poczekaj na weryfikację administratora";
		header("location: ../../");
	}
} catch (mysqli_sql_exception $e) {
		$_SESSION["error"] = $e->getMessage();
		echo "<script>history.back();</script>";
		exit();
}













