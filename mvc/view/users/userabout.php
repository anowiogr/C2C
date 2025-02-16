<?php
require '../main/header.php';
require '../../model/userModel.php';
$model = new User();

if (!isset($_SESSION['logged']['account_id'])) {
    header('Location: ../../../login.php');
    exit();
}

try {
    $accountId = $_SESSION['logged']['account_id'];

    // Pobranie istniejących informacji o użytkowniku
    $statement = $model -> getUserById($accountId);
    $user = $statement->fetch(PDO::FETCH_ASSOC);

    if ($user) {

        echo <<<TABLELUSER
            <table class="table">
            <thead>
                 <tr>
                    <th scope="col"><h2>Informacje o użytkowniku</h2></th>
                    <th scope="col"><h2>Zmień dane użytkownika</h2></th>
                </tr>
            </thead>
           
            <tr>
                <td>
                    <b>Login:</b> $user[login]
                    <br>
                    <b>Typ konta:</b> $user[type_name]
                    <br>
                    <b>Zweryfikowany:</b> $user[verifiedtext]
                    <br>
                </td>
                <td>
                    <form method='POST' action=''>
                    <div class="form-row">
                        <label for='firstname'>Imię:</label>
                        <input class="form-control" type='text' name='firstname' id='firstname' value='$user[firstname]' maxlength='50' placeholder='Max 50 znaków' required><br>

                        <label for='lastname'>Nazwisko:</label>
                        <input class="form-control"type='text' name='lastname' id='lastname' value='$user[lastname]' maxlength='150' placeholder='Max 150 znaków' required><br>

                    <label for='email'>Email:</label>
                    <input class="form-control" type='email' name='email' id='email' value='$user[email]' maxlength='250' placeholder='Wprowadź poprawny email' required><br>
                    
                    <label for='phone'>Telefon:</label>
                    <input class="form-control" type='tel' name='phone' id='phone' value='$user[phone]' pattern='[0-9]{9}' placeholder='Numer telefonu (9 cyfr)' required><br>
                    
                    <label for='address'>Adres:</label>
                    <input class="form-control" type='text' name='address' id='address' value='$user[address] ' maxlength='200' placeholder='Max 200 znaków' required><br>
                    
                    <label for='codezip'>Kod pocztowy:</label>
                    <input class="form-control" type='text' name='codezip' id='codezip' value='$user[codezip]' pattern='[0-9]{2}-[0-9]{3}' placeholder='Kod pocztowy (XX-XXX)' required><br>
                    
                    <label for='city'>Miasto:</label>
                    <input class="form-control" type='text' name='city' id='city' value='$user[city]' maxlength='50' placeholder='Max 50 znaków' required><br>
                    
                    <label for='country'>Kraj:</label>
                    <input class="form-control" type='text' name='country' id='country' value='$user[country]' maxlength='50' placeholder='Max 50 znaków' required><br>
                    
                    <input type='hidden' name='account_id' value='$accountId'>
                    </div>
                    <button class="btn btn-danger" type='submit'>Zapisz zmiany</button>
                    </form>
                </td>
            </tr>
            </table>
        TABLELUSER;



        // Aktualizacja danych użytkownika
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $firstname = $_POST['firstname'];
            $lastname = $_POST['lastname'];
            $email = $_POST['email'];
            $phone = $_POST['phone'];
            $address = $_POST['address'];
            $codezip = $_POST['codezip'];
            $city = $_POST['city'];
            $country = $_POST['country'];

           

            try {
                $updateStatement = $model -> updateUser($accountId, $firstname, $lastname, $email, $phone, $address, $codezip, $city, $country);
                $errorMessage = '';
                echo "<div class='alert alert-success' role='alert'>Dane zostały zaktualizowane.</div>";
            } catch (PDOException $e) {
                $errorMessage = $e->getMessage();
            }

            if ($errorMessage !== '') {
                echo "<div class='alert alert-danger' role='alert'>Błąd: " . $errorMessage . "</div>";
            }
        }
    } else {
        echo "<div class='alert alert-danger' role='alert'>Nie znaleziono użytkownika o podanym ID.</div>";
    }
} catch (PDOException $e) {
    echo "Błąd połączenia: " . $e->getMessage();
}

require '../main/footer.php';
?>
