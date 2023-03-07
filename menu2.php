<?php
    include("conex_db.php");
    session_start();
    $nombre = $_SESSION['name'];

?>
<!DOCTYPE html>
<html lang="es" dir="ltr">

<head>
    <meta charset="UTF-8">
    <!-- <title> Animated Share Button | CodingLab </title>  -->
    <link rel='stylesheet' href='https://unicons.iconscout.com/release/v2.1.9/css/unicons.css'>
    <link rel="stylesheet" href="css/menu2.css">
    <title>Hangman game</title>
</head>

<body>
    <div class="titulo">
        <label for="titulo" id="tituloHG"> HANGMAN GAME </label>
    </div>

    <div class="bRegresar">
        <a href="index.html" class="btnBack">Cerrar Sesión</a>
    </div>

    <div class="usuario">
        <h3>
        <i class="uil uil-user"></i>
            <?php
                echo $nombre;
            ?>
        </h3>
    </div>

    <div class="bPalabras">
        <a href="menuPalabra.html" class="btnPalabras">Palabras</a>
    </div>

    <div class="bSala">
        <a href="menuSala.php" class="btnSala">Salas</a>
    </div>
    
    <div class="bInforme">
        <a href="menuInforme.html" class="btnInforme">Informe</a>
    </div>

</body>

</html>

