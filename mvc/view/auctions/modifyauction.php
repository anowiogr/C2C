<?php
include_once '../main/header.php';
include_once "../../model/auctionModel.php";
$model = new Auction();



$account_id = $_SESSION["logged"]["account_id"];


$auction_id = $_GET['auction_id'];

 try {
     $statement = $model -> getAuctionByIdModify($auction_id);
     $auction = $statement->fetch(PDO::FETCH_ASSOC);

    } catch (PDOException $e) {
        echo "Błąd połączenia: " . $e->getMessage();
    }

    if($auction) {
        // Wyświetlanie formularza modyfikacji
?>

        <form method='POST' action='../../controller/modify.php'>
            <table class="table">
                <tbody>
                <tr>
                    <td><label for='title'>Tytuł:</label></td>
                    <td><input class="form-control" type='text' name='title' id='title' <?php echo"value='$auction[title]'";?>  required></td>
                </tr>
                <tr>
                    <td><label for='categoryid'>Kategoria:</label></td>
                    <td>
                        <select class="form-control" name='categoryid' id='categoryid' required>
                            <?php
                            $stmt = $model -> getCategories();
                            $category1 = $stmt->fetchAll();
                            foreach ($category1 as $category){
                                if($category["categoryid"]==$auction["categoryid"]){
                                    echo "<option selected='selected' value='$category[categoryid]'>$category[name]</option>";
                                }else{
                                    echo "<option value='$category[categoryid]'>$category[name]</option>";
                                }
                            }
                            ?>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for='description'>Opis:</label></td>
                    <td><textarea class="form-control" name='description' id='description' required><?php echo $auction["description"];?></textarea></td>
                </tr>
                <tr>
                    <td><label class="form-check-label" for='used'>Używany: </label></td>
                    <td><input class="form-check-input" type='checkbox' name='used' id='used' <?php if($auction["used"]) {echo "checked";} ?> > </td>
                </tr>
                <tr>
                    <td colspan="2">Cena:</td>
                </tr>

                <tr>
                    <td><input class="form-control" type='text' pattern="\d*" name='price' id='price' <?php echo"value='$auction[price]'";?> required></td>
                    <td><select class="form-control" name='currencyid' id='currencyid' required>
                            <?php
                               $stmt = $model -> getCurrencies();
                               $currency1 = $stmt->fetchAll(PDO::FETCH_ASSOC);
                            foreach ($currency1 as $currency){
                                if($currency["currencyid"]==$auction["currencyid"]){
                                    echo "<option selected='selected' value='$currency[currencyid]'>$currency[currency_name]</option>";
                                }else{
                                echo "<option value='$currency[currencyid]'>$currency[currency_name]</option>";
                                }
                            }
                            }
                            ?>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="row col-md-1">
                            <button style="border: 0px;" onclick="history.back()">
                                <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="dark" class="bi bi-arrow-left-short" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M12 8a.5.5 0 0 1-.5.5H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5a.5.5 0 0 1 .5.5z"/>
                                </svg>
                                <!--Wróć do widoku wszystkich aukcji-->
                            </button>
                        </div>
                    </td>
                    <td style="text-align: right;">
                        <input type='hidden' name='auctionid' <?php echo "value=' $auction[auctionid] '";?>> <!-- ID użytkownika, dla którego dodawane jest ogłoszenie-->
                        <button class="btn btn-secondary" type='submit' >Zmień</button>
                    </td>
                </tr>

                </tbody>
            </table>
        </form>

<?php
include_once "../main/footer.php";
?>
