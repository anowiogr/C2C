<?php
  session_start();
  $config = include '../../../config/config.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta name="description"
        content="Strona stworzona w celach nauki programowania www. Studencki C2C to strona stworzona, aby przećwiczyć tworzenie kodu w HTML|PHP|JavaScript w powiązaniu z SQL.">
  <link rel="icon"
        type="image/png" href="../../../images/icon.png">

  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">

  <link rel="stylesheet" href="../../../public/plugins/fontawesome-free/css/all.min.css">

  <link rel="stylesheet" href="../../../public/plugins/icheck-bootstrap/icheck-bootstrap.min.css">

  <link rel="stylesheet" href="../../../public/dist/css/adminlte.min.css">

  <title>Studencki C2C</title>
 </head>

<body class="hold-transition login-page">
<div class="login-box">
	<?php
	if (isset($_SESSION["error"])){
		echo <<< ERROR
        <div class="callout callout-danger">
          <h5>Błąd!</h5>
          <p>$_SESSION[error]</p>
        </div>
ERROR;
		unset($_SESSION["error"]);
	}

	if (isset($_SESSION["success"])){
		echo <<< ERROR
        <div class="callout callout-success">
          <h5>Info</h5>
          <p>$_SESSION[success]</p>
        </div>
ERROR;
		unset($_SESSION["success"]);
	}
	?>
  <!-- /.login-logo -->
  <div class="card card-outline card-secondary">
    <div class="card-header text-center">
      <a href="../../../index.php" class="h1"><b>Studencki</b>C2C</a>
    </div>
    <div class="card-body">
      <form action="../../controller/login.php" method="post">
        <div class="input-group mb-3">
          <input class="form-control" placeholder="Podaj login lub email" name="email">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" placeholder="Podaj hasło" name="pass">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">

          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-secondary btn-block">Zaloguj</button>
          </div>
          <!-- /.col -->
        </div>
      </form>

     <p class="mb-1">
        <a href="./forgot-password.php">Zapomniałem hasła</a>
      </p>
      <p class="mb-0">
        <a href="./register.php" class="text-center">Stwórz nowe konto</a>
      </p>
    </div>
    <!-- /.card-body -->
  </div>
  <!-- /.card -->
</div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="../../../public/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../../public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../../public/dist/js/adminlte.min.js"></script>
</body>
</html>