<?php

$config = include 'C:/xampp/htdocs/inż/C2C/config/config.php';
require '../main/header.php';
require '../../model/auctionModel.php';
$model = new Auction();

$used = false;
$private = true;


$account_id = $_SESSION["logged"]["account_id"];


?>
         <form method='POST' action='../../controller/newauction.php'>
         <table class="table">
            <tbody>
            <tr>
                <td><label for='title'>Tytuł:</label></td>
                <td><input class="form-control" type='text' name='title' id='title' required></td>
            </tr>
            <tr>
                <td><label for='categoryid'>Kategoria:</label></td>
                <td>
                    <select class="form-control" name='categoryid' id='categoryid' required>
                    <?php
                      $stmt = $model -> getCategories();
                      $category1 = $stmt->fetchAll();

                      foreach ($category1 as $category){
                        echo "<option value='$category[categoryid]'>$category[name]</option>";
                      }
                      ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for='description'>Opis:</label></td>
                <td><textarea class="form-control" name='description' id='description' required></textarea></td>
            </tr>
            <tr>
                <td><label class="form-check-label" for='used'>Używany: </label></td>
                <td><input class="form-check-input" type='checkbox' name='used' id='used' > </td>
            </tr>
            <tr>
                <td colspan="2">Cena:</td>
            </tr>

            <tr>
                <td><input class="form-control" type='text' pattern="\d*" name='price' id='price' required></td>
                <td><select class="form-control" name='currencyid' id='currencyid' required>
                        <?php
                        $stmt = $model -> getCurrencies();
                        $currency1 = $stmt->fetchAll(PDO::FETCH_ASSOC);
                        foreach ($currency1 as $currency){
                            echo "<option value='$currency[currencyid]'>$currency[currency_name]</option>";
                        }
                        ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                 <input type='hidden' name='account_id' <?php echo "value=' $account_id '";?>> <!-- ID użytkownika, dla którego dodawane jest ogłoszenie-->
                 <button class="btn btn-secondary" type='submit' name='action' value='add'>Dodaj</button>
                </td>
            </tr>

         </tbody>
         </table>
        </form>



<?php
include_once "../main/footer.php";
?>
