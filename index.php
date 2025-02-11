<?php

// header
include_once "mvc/view/main/header.php";
include_once 'mvc/model/auctionModel.php';
$model = new Auction();

if(isset($_SESSION["success"]) && $_SESSION["success"]<>null){
    echo "<div class='alert alert-success' role='alert'>$_SESSION[success]</div>";
    $_SESSION["success"]=null;
}
?>

<div id="myCarousel" class="carousel slide mb-6" data-bs-ride="carousel" data-bs-theme="dark">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="3" aria-label="Slide 4"></button>
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="4" aria-label="Slide 5"></button>

    </div>
    <div class="carousel-inner">

        <div class="carousel-item active p-3">
            <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="var(--bs-secondary-color)"/></svg>
            <div class="container">
                <div class="carousel-caption">
                    <h1>KUPUJ I SPRZEDAWAJ JAK LUBISZ</h1>
                    <p class="opacity-75">Studencki OLX to super sprawa dla każdego początkującego przedsięciorcy, już dziś zaloguj się i zarób hajsik na cokolwiek chcesz :)</p>
                </div>
            </div>
        </div>    
        <?php

            $auctions = $model -> getBannerAuction();
            while($auction = $auctions->fetch(PDO::FETCH_ASSOC)) {
                $title = htmlspecialchars($auction['title']);
                $auctionid = (int) $auction['auctionid'];
                echo <<< TABLEAUCTION
                <div class="carousel-item p-3">
                    <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="var(--bs-secondary-color)"/></svg>
                    <div class="container">
                        <div class="carousel-caption" padding="10%">

                            <h1>{$title}</h1>

                            <p><a class="btn btn-lg btn-secondary" href="mvc/view/auctions/auction.php?auction_id={$auctionid}">Zobacz ofertę</a></p>
                            
                        </div>
                    </div>
                </div>
        TABLEAUCTION;
            }
        
        ?>

    </div>
</div>



<div class="row p-4 text-center">
<?php
    $category= $model->getCategories();
    while ($categories = $category->fetch(PDO::FETCH_ASSOC)) {
        $name = htmlspecialchars($categories['name']);
        $categoryid = (int) $categories['categoryid'];
        echo <<< TABLECATEGORY
            <div class="col-lg-4">
                <a class="text-dark" style="text-decoration: none;" href="mvc/controller/forward.php?categoryid={$categoryid}">
                    <svg class="bd-placeholder-img rounded-circle" width="60" height="60" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="var(--bs-secondary-color)"></rect></svg>
                    <h2 class="fw-normal">{$name}</h2>
                </a>
            </div>
            
        TABLECATEGORY;
        echo '<br>';
    }
?>
</div>
<?php
//stopka
include_once "mvc/view/main/footer.php";

?>
