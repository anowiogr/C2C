<?php
include_once "../main/header.php";
include_once "../../model/userModel.php";
include_once "../../model/auctionModel.php";
$model = new User();
$auctionmodel = new Auction();

if (isset($_GET['account_id'])) {
    $accountId = $_GET['account_id'];
} elseif (isset($_SESSION['logged']['account_id'])) {
    $accountId = $_SESSION['logged']['account_id'];
} else {

    header('Location: ../../../index.php');
    exit();
}
try {
    if($accountId){
        echo "<div><a href='addauction.php' class='button'><button class='btn btn-secondary'>Dodaj ogłoszenie</button></a></div><br>";
    }

    // Pobranie wszystkich ogłoszeń użytkownika
    $statement = $auctionmodel -> getAllAuction4User($accountId);
    $auctions = $statement->fetchAll(PDO::FETCH_ASSOC);
    if ($auctions) {
        foreach ($auctions as $auction) {
            if($auction["veryfied"]==0){
                $info="OCZEKUJE NA WERYFIKACJĘ";
            }else{
                $info="";
            }
            echo <<< TABLELISTA
                <div class="row box p-3">
                    <img class="aimg" src="../../../images/nofoto.jpg" />
                    
                    <div class="box-text" >
                    <div style="text-align: right; font-size: 0.6em;">Data wystawienia: $auction[date_start] </div>
                         <div style="width: 50%; float: left; ">
                            <h3>
                                <a class="link-dark" style="text-decoration: none;" href="auction.php?auction_id=$auction[auctionid]">$auction[title]</a>
                            </h3>
                         </div>
                         <span class="text-danger">$info</span>
                         <div style="overflow: hidden; text-align: right;">
                     
                            <a href="modifyauction.php?auction_id=$auction[auctionid]" class="btn btn-primary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                                  <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                                </svg>
                            </a>
                           <a href="../../controller/deleteauction.php?auction_id=$auction[auctionid]" class="btn btn-danger">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3-fill" viewBox="0 0 16 16">
                              <path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5Zm-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5ZM4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06Zm6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528ZM8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5Z"/>
                            </svg>
                           </a>
                         </div> 
                    </div>
                    
                </div>
                
                <br>
            TABLELISTA;
        }

        echo "<hr><h4>NIEAKTYWNE</h4>";

            // Pobranie nieaktywnych ogłoszeń użytkownika
            $statement = $auctionmodel -> getAllAuction4UserUnactive($accountId);
            $auctions = $statement->fetchAll(PDO::FETCH_ASSOC);

    if ($auctions) {
        foreach ($auctions as $auction) {
            if($auction["veryfied"]==2){
                $info="ODRZUCONE";
            }else{
                $info="";
            }
            echo <<< TABLELISTA
                <div class="row box p-3">
                    
                    <img class="aimg" src="../../../images/nofoto.jpg" />
                    
                    <div class="box-text" >
                    <div style="text-align: right; font-size: 0.6em;">Data wystawienia: $auction[date_start] </div> 
                         <div style="width: 50%; float: left; ">
                          
                            <h3>
                                <a class="atitle link-dark" style="text-decoration: none;" href="auction.php?auction_id=$auction[auctionid]">$auction[title]</a>
                            </h3>
                         </div>
                         <span class="text-secondary">$info</span>
                         <div style="overflow: hidden; text-align: right;">
                            
                         </div>
                       
                    </div>
                </div>
                
                <br>
            TABLELISTA;
        }
    }

    } else {
        echo "<p class='text-secondary p-3'><i>Nie masz jeszcze żadnych ogłoszeń, dodaj ogłoszenie i zarabiaj!</i></p>";

    }
} catch (PDOException $e) {
    echo "Błąd połączenia: " . $e->getMessage();
}

require '../main/footer.php';
?>
