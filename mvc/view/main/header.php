<?php

    $config = include 'C:/xampp/htdocs/inż/C2C/config/config.php';

    session_start();
    //print_r($_SESSION["logged"]);
    if (!isset($_SESSION["role"])){
        $_SESSION["role"]="guest";
    }

   
 
?>
<!doctype html>
<html class="h-100">
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="description"
          content="Strona stworzona w celach nauki programowania www. Studencki C2C to strona stworzona, aby przećwiczyć tworzenie kodu w HTML|PHP|JavaScript w powiązaniu z SQL.">
    <link rel="icon"
          type="image/png" href="<?php echo $config['baseurl'].'/images/icon.png'; ?>">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

    <link rel="stylesheet" href="<?php echo $config['baseurl'].'/public/css/style.css'; ?>">

    <title>Studencki C2C</title>
    </head>



       <div role="navigation" class="navbar navbar-expand-lg navbar-dark bg-dark">
           <div class="container">
            <a class="navbar-brand" href="<?php echo $config['baseurl'].'/index.php'?>"><img src="<?php echo $config['baseurl'].'/images/icon.png'; ?>" class="bi" width="40" height="40" /></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu" aria-controls="menu" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
               <div class="collapse navbar-collapse text-secondary justify-content-end" id="menu">
        <?php
            if($_SESSION["role"]=="guest"){
                ?>
                   <ul class="navbar-nav">
                        <li class="nav-item">
                            <a href="<?php echo $config['baseurl'].'/mvc/view/main/login.php';?>"><button type="button" class="btn btn-outline-light me-2">Zaloguj</button></a>
                        </li>
                        <li class="nav-item">
                            <a href="<?php echo $config['baseurl'].'/mvc/view/main/register.php'; ?>"><button type="button" class="btn btn-light">Zarejestruj się</button></a>
                        </li>
                    </ul>

        <?php
            }elseif ($_SESSION["role"]=="user"){
        ?>
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="<?php echo $config['baseurl'].'/mvc/view/userauctions.php'?>">Twoje aukcje</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<?php echo $config['baseurl'].'/mvc/view/messagelist.php'?>">Wiadomości</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<?php echo $config['baseurl'].'/mvc/view/userabout.php';?>">Ustawienia</a>
                            </li>
                            <li class="nav-item active">
                                <a href="<?php echo $config['baseurl'].'/mvc/controller/logout.php';?>"><button type="button" class="btn btn-danger">Wyloguj</button></a>
                            </li>
                        </ul>

                <?php
        }elseif ($_SESSION["role"]=="admin"){
        ?>

                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link" href="<?php echo $config['baseurl'].'/mvc/view/userauctions.php';?>">Twoje aukcje</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<?php echo $config['baseurl'].'/mvc/view/messagelist.php'?>">Wiadomości</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<?php echo $config['baseurl'].'/mvc/view/admin.php'?>">Administracja</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<?php echo $config['baseurl'].'/mvc/view/userabout.php';?>">Ustawienia</a>
                                </li>
                                <li class="nav-item active">
                                    <a href="<?php echo $config['baseurl'].'/mvc/controller/logout.php'; ?>"><button type="button" class="btn btn-danger">Wyloguj</button></a>
                                </li>
                            </ul>

                <?php
        }
        ?>
    </div>
  </div>
</div>

<body class="d-flex flex-column h-100">
    <div class="container">
        <br>
        <?php
        $searchbar='';
        echo <<< SEARCHBAR

            <form method='GET' action='?>echo '/mvc/controller/forward.php'; <?php'>
                <table  style="width: 100%; text-align: center;">
                    <tr>
                        <td>
                            <input class="form-control rounded" type='text' name='search' id='search' placeholder="Czego dzisiaj szukasz?" aria-label="Search" value='$searchbar'>
                           
                        </td>
                        <td>
                            <button class="btn" type='submit'>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                </svg>
                                </button>
                            </td>
                    </tr>
                </table>
            </form>
            <br>
        SEARCHBAR;

        ?>




