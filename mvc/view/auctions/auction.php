<?php
include_once "../main/header.php";
include_once "../../model/auctionModel.php";
$model = new Auction();

try {

    if(isset($_SESSION['info']) && $_SESSION['info']<> null){

        echo "<div class='alert alert-success' role='alert'>$_SESSION[info]</div>";
        $_SESSION['info']=null;
    }

    if (isset($_GET['auction_id'])) {
        $auctionId = $_GET['auction_id'];
        
        // Pobranie informacji o wybranej aukcji
        $auction = $model -> getAuctionById($auctionId);

        //Pobieraj link do obrazka aukcji
        $foto = "..\..\..\images\nofoto.jpg";

        if ($auction) {
            ?>
                <div class="row col-md-1">
                    <button style="border: 0px;" onclick="goBack()">
                        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="dark" class="bi bi-arrow-left-short" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M12 8a.5.5 0 0 1-.5.5H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5a.5.5 0 0 1 .5.5z"/>
                        </svg>
                        <!--Wróć do widoku wszystkich aukcji-->
                    </button>
                </div>
                <br><br>
                <div class="row col-md-11">
                    <div class="col-md-6">
                        <img class="fill" src="<?php echo '..\..\..\images\nofoto.jpg';?>" />
                    </div>

                    <div class="p-3 mb-2 col-md-6" style="text-align: right;">
                        <h4>
                            <b>Sprzedający:</b> <?php echo $auction["login"]; ?><br><br>
                            <b>Telefon:</b> <?php echo ($_SESSION["role"]=="guest" ?  "Zaloguj się aby zobaczyć nr telefonu" : $auction['phone']); ?> <br><br>
                        </h4>
                        <a class='btn btn-secondary' <?php echo "href='../messages/newmessage.php?auction_id=$auctionId'"; ?> >
                        <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-send' viewBox='0 0 16 16'>
                            <path d='M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576 6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z'/>
                        </svg> Napisz wadomość </a>

                        <?php
                        if($_SESSION["role"]<>"guest"){
                         echo   <<< BUTTONBUY
                         <a class='btn btn-danger' <?php echo "href='../../controller/buyauction.php?auction_id=$auctionId'"; ?>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bag" viewBox="0 0 16 16">
                        <path d="M8 1a2.5 2.5 0 0 1 2.5 2.5V4h-5v-.5A2.5 2.5 0 0 1 8 1m3.5 3v-.5a3.5 3.5 0 1 0-7 0V4H1v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4zM2 5h12v9a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1z"/>
                        </svg> Kupuję </a>
                        BUTTONBUY;
                        }
                        ?>

                        <br><br><br>
                        <h2><?php echo $auction["price"]." ".$auction["currency_name"]; ?></h2>

                    </div>

                    <div>
                        <p style="text-align: right; font-size: 0.8em;">Data wystawienia: <?php echo $auction["date_start"]; ?></p>
                        <h1><i><?php echo $auction["title"]; ?></i></h1>
                        <br>
                        <span>
                            <?php echo $auction["description"]; ?>
                            <br><br>
                            <?php
                            echo "Używany: ";
                            echo ($auction['used'] ?
                                '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-toggle-on" viewBox="0 0 16 16">
                                  <path d="M5 3a5 5 0 0 0 0 10h6a5 5 0 0 0 0-10H5zm6 9a4 4 0 1 1 0-8 4 4 0 0 1 0 8z"/>
                                </svg>' :
                                '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-toggle-off" viewBox="0 0 16 16">
                                  <path d="M11 4a4 4 0 0 1 0 8H8a4.992 4.992 0 0 0 2-4 4.992 4.992 0 0 0-2-4h3zm-6 8a4 4 0 1 1 0-8 4 4 0 0 1 0 8zM0 8a5 5 0 0 0 5 5h6a5 5 0 0 0 0-10H5a5 5 0 0 0-5 5z"/>
                                </svg>');
                            ?>                            
                        </span>
                    </div>
                </div><br><br>
            <?php

        } else {
            echo "Aukcja o podanym ID nie istnieje.";
        }
    } else {

        // Pobranie przefiltrowanych aukcji z podstawowymi informacjami
        if(isset($_SESSION["filter"]["search"])&& $_SESSION["filter"]["search"]<>null&& $_SESSION["filter"]["search"]<>''){

            $searchbar="'%".$_SESSION["filter"]["search"]."%'";
            print_r($searchbar."<br>");

            $stmt = $model -> getAuctionBySearch($searchbar);

            $_SESSION["filter"]["search"]=null;

        } elseif(isset($_SESSION["filter"]["categoryid"])&& $_SESSION["filter"]["categoryid"]<>null) {

            $categoryid = $_SESSION["filter"]["categoryid"];
            //print_r($categoryid . "<br>");

            $stmt = $model -> getAuctionByCategory($categoryid);

            $_SESSION["filter"]["categoryid"]=null;

           // $auctions = $stmt->fetchAll(PDO::FETCH_ASSOC);

        } else {
            $stmt = $model -> getAllAuction();
            $auctions = $stmt->fetchAll(PDO::FETCH_ASSOC);
        }

        foreach ($auctions as $auction) {
            echo <<< TABLELISTA
                <div class="row box p-3">
                    <img class="aimg" src="../../../images/nofoto.jpg" />
                    
                    <div class="box-text" >
                    
                         <div style="width: 50%; float: left; ">
                            <h3>
                                <a class="atitle link-dark" style="text-decoration: none;" href="auction.php?auction_id=$auction[auctionid]">$auction[title]</a>
                            </h3>
                         </div>
                         
                         <div style="overflow: hidden; text-align: right;">
                         <h3>$auction[price]</h3>$auction[currency_name]
                         </div>
                      <div class="ainfo" style="text-align: left;" >$auction[city],  Data wystawienia: $auction[date_start] </div>   
                    </div>
                    
                
                </div>
            TABLELISTA;

        } echo "<br>";
    }

} catch (PDOException $e) {
    die("Błąd połączenia lub tworzenia bazy danych: " . $e->getMessage());
}

require '../main/footer.php';
?>
