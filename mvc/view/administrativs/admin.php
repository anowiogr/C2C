<?php

require_once __DIR__."/../main/header.php";
require_once __DIR__."/../../model/administrativeModel.php";
require_once __DIR__."/../../model/auctionModel.php";

$administratorPanel = new Administrative();

?>

    <ul class="nav nav-tabs" id="myTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="auctiontab" data-bs-toggle="tab" data-bs-target="#auction" type="button" role="tab" aria-controls="auction" aria-selected="true">Aukcje - weryfikacja</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="newusertab" data-bs-toggle="tab" data-bs-target="#newuser" type="button" role="tab" aria-controls="newuser" aria-selected="false">Konta - weryfikacja </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="activeusertab" data-bs-toggle="tab" data-bs-target="#activeuser" type="button" role="tab" aria-controls="activeuser" aria-selected="false">Konta </button>
        </li>
    </ul>

    <div class="tab-content" id="myTabContent">

        <div class="tab-pane fade show active" id="auction" role="tabpanel" aria-labelledby="auction"><br>

<?php

        // Pobranie wszystkich aukcji z podstawowymi informacjami
        $auctions = $administratorPanel -> getUnverifiedAuctions();    
        foreach ($auctions as $auction) {

            echo <<< TABLELISTA
                <div class="row box p-3">
                    <img class="aimg" src=__DIR__."/images/nofoto.jpg" />
                    
                    <div class="box-text" >
                    
                         <div style="width: 50%; float: left; ">
                            <h3>
                                <a class="atitle link-dark" style="text-decoration: none;" href="auction.php?auction_id=$auction[auctionid]">$auction[title]</a>
                            </h3>
                         </div>
                         
                         <div style="overflow: hidden; text-align: right;">
                         <h3>$auction[price]</h3>$auction[currency_name]<br>
                           <a href="scripts/modauction.php?auction_id=$auction[auctionid]&verifyed=true&id=$account_id" class="btn btn-success">Zatwierdź</a><!--wartość na 1-->
                           <a  href="scripts/modauction.php?auction_id=$auction[auctionid]&verifyed=false&id=$account_id" class="btn btn-danger">Odrzuć</a> <!--wartość na 2-->
                         </div><div class="ainfo" style="text-align: left;" >$auction[city],  Data wystawienia: $auction[date_start] </div>
                       
                    </div>
                    
                
                </div>
            TABLELISTA;

        }
    ?>
                    </div>
                    <div class="tab-pane fade" id="newuser" role="tabpanel" aria-labelledby="newusertab">
                        <br>
                        <?php
                        $users = $administratorPanel -> getNewUsers(0);      
                        echo "<h5>Oczekujące</h5>";

                        foreach ($users as $newUser) {

                                echo <<< TABLELISTAU
                            <div class="row box p-3">  
                            <br>                          
                                <div class="box-text" >
                                
                                     <div style="width: 50%; float: left; ">
                                        <h3>$newUser[login]</h3>
                                        <p>
                                            $newUser[firstname] $newUser[lastname]
                                            <br>
                                            <i style="font-size: 0.9em">$newUser[email]</i>
                                        </p>
                                     </div>
                                     
                                     <div style="overflow: hidden; text-align: right;">
                                       <p style="font-size: 0.7em;" > Data rejestracji: $newUser[registerdate] </p>
                                       <a href="scripts/moduser.php?accountid=$newUser[accountid]&verifyed=true&id=$account_id" class="btn btn-success">Zatwierdź</a><!--wartość na 1-->
                                       <a  href="scripts/moduser.php?accountid=$newUser[accountid]&verifyed=false&id=$account_id" class="btn btn-danger">Odrzuć</a> <!--wartość na 2-->
                                     </div>
                                     
                                   
                                </div>
                                
                            
                            </div>
                        TABLELISTAU;
                        }
                        ?>
                        <br><hr>
                        <h5>Odrzucone</h5>
                        <?php
                        // Pobranie wszystkich odrzuconych userów
                        $users = $administratorPanel -> getNewUsers(2);      
                        foreach ($users as $newUser) {

                            echo <<< TABLELISTAU
                            <div class="row box p-3">  
                            <br>                          
                                <div class="box-text" >
                                
                                     <div style="width: 50%; float: left; ">
                                        <h3>$newUser[login]</h3>
                                        <p>
                                            $newUser[firstname] $newUser[lastname]
                                            <br>
                                            <i style="font-size: 0.9em">$newUser[email]</i>
                                        </p>
                                     </div>
                                     
                                     <div style="overflow: hidden; text-align: right;">
                                       <p style="font-size: 0.7em;" > Data rejestracji: $newUser[registerdate] </p>
                                     </div>
                                     
                                   
                                </div>
                                
                            
                            </div>
                        TABLELISTAU;
                        }
                        ?>

                    </div>
            <div class="tab-pane fade" id="activeuser" role="tabpanel" aria-labelledby="activeuser">
                <?php

                        // Pobranie wszystkich nowych userów
                        $users = $administratorPanel -> getNewUsers(1);
                        foreach ($users as $newUser) {

                                echo <<< TABLELISTAU
                            <div class="row box p-3">  
                            <br>                          
                                <div class="box-text" >
                                
                                     <div style="width: 50%; float: left; ">
                                        <h3>$newUser[login]</h3>
                                        <p>
                                            $newUser[firstname] $newUser[lastname]
                                            <br>
                                            <i style="font-size: 0.9em">$newUser[email]</i>
                                        </p>
                                     </div>
                                     
                                     <div style="overflow: hidden; text-align: right;">
                                       <p style="font-size: 0.7em;" > Data rejestracji: $newUser[registerdate] </p>
                                     </div>
                                     
                                   
                                </div>
                                
                            
                            </div>
                        TABLELISTAU;
                        }
                        ?>
            </div>


    </div>

 <?php

require_once __DIR__."/../main/footer.php";
?>
