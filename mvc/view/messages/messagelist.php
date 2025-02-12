<?php
include_once "../main/header.php";
include_once "../../model/messageModel.php";
$model = new Message();

if (!isset($_SESSION['logged']['account_id'])||$_SESSION['logged']['account_id']==null) {
    header("Location: ../../../index.php");

}
$account_id = $_SESSION['logged']['account_id'];

try {
    //Zapytanie dla sprzedawanych przedmiotów (naglowek)
    $stmtSell = $model -> getSellMessages($account_id);

    // Zapytanie dla kupowanych (naglowek)
    $stmtBuy = $model -> getBuyMessages($account_id);

} catch (PDOException $e) {
    echo "Błąd połączenia lub aktualizacji bazy danych: " . $e->getMessage();
}


?>

        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="messageBuy-tab" data-bs-toggle="tab" data-bs-target="#buy" type="button" role="tab" aria-controls="buy" aria-selected="true">Kupujesz</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="messageSell-tab" data-bs-toggle="tab" data-bs-target="#sell" type="button" role="tab" aria-controls="sell" aria-selected="false">Sprzedajesz</button>
            </li>
        </ul>

        <div class="tab-content" id="myTabContent">

            <!--WIADOMOŚCI OD UZYTKOWNIKÓW-->
            <div class="tab-pane fade show active" id="buy" role="tabpanel" aria-labelledby="messageBuy-tab">


                <?php
                // Wyświetlanie wiadomości od zainteresowanych (naglowki)
                while ($rowBuy = $stmtBuy->fetch(PDO::FETCH_ASSOC)) {
                echo <<< TABLEMESSLIST
                        <div class="row box p-3">  
                            <br>                          
                                <div class="box-text" >
                                
                                     <div style="width: 50%; float: left; ">
                                        <h3>$rowBuy[login]</h3>
                                        <p>
                                            <i style="font-size: 0.9em">$rowBuy[title]</i>
                                        </p>
                                     </div>
                                     
                                     <div style="overflow: hidden; text-align: right;">
                                     <br>
                                       <a href="messageview.php?aid=$rowBuy[auctionid]&bid=$rowBuy[buyerid]&a=0" class="btn btn-outline-secondary">
                                       <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
                                          <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
                                        </svg>
                                        </a>
                                     </div>
                                     
                                   
                                </div>
                                
                            
                            </div>
             TABLEMESSLIST;
                }
                ?>


            </div>


            <div class="tab-pane fade" id="sell" role="tabpanel" aria-labelledby="messageSell-tab">
                <br />
                <?php
                while ($rowSell = $stmtSell->fetch(PDO::FETCH_ASSOC)) {
                    echo <<< TABLEMESSLIST
                        <div class="row box p-3">  
                            <br>                          
                                <div class="box-text" >
                                
                                     <div style="width: 50%; float: left; ">
                                        <h3>$rowSell[login]</h3>
                                        <p>
                                            <i style="font-size: 0.9em">$rowSell[title]</i>
                                        </p>
                                     </div>
                                     
                                     <div style="overflow: hidden; text-align: right;">
                                     <br>
                                       <a href="messageview.php?aid=$rowSell[auctionid]&bid=$rowSell[buyerid]&a=1" class="btn btn-outline-secondary">
                                       <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
                                          <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
                                        </svg>
                                        </a>
                                     </div>
                                     
                                   
                                </div>
                                
                            
                            </div>
             TABLEMESSLIST;
                }
                ?>
            </div>
        </div>
    </div>

<?php
include_once "../main/footer.php";
?>
