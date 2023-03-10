<?php
        include("conex_db.php");
        $consulta="SELECT * FROM word";

        $resultado=mysqli_query($conexion,$consulta);

        $vidas = 3;

        # RRM nuevo comentario prueba

        # code...
        # se importa el verbo
        $numFilas =mysqli_num_rows($resultado);

        $verbRand = rand(1,$numFilas);
        $resultado2=mysqli_query($conexion,"SELECT * FROM word WHERE id = '$verbRand'");
        while($consultaVerb =  mysqli_fetch_array($resultado2)){
            $idVerb = $consultaVerb['id'];
            $erased = $consultaVerb['erased'];
            $verbo = $consultaVerb['word'];
            $tipo = $consultaVerb['type'];
            $pista = $consultaVerb['clue'];
            $simplePast = $consultaVerb['simplepast'];
            $ejemplo = $consultaVerb['example'];
        }

        ?>
            <!-- inicia el juego html -->


            <!DOCTYPE html>
            <html lang="es">
            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>hangman</title>
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <!-- boostrap -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
                crossorigin="anonymous"></script>
                <link rel="stylesheet" href="css/game.css">
            </head>
            <body>
                <div class="container">
                    <img src="./img/baseH.png" width="700" height="500" class="baseH">
                    <img src="./img/head.png" width="700" height="500" class="headH">
                    <img src="./img/body.png" width="700" height="500" class="bodyH">
                    <img src="./img/ArmL.png" width="700" height="500" class="armLH">
                    <img src="./img/ArmR.png" width="700" height="500" class="armRH">
                    <img src="./img/LegL.png" width="700" height="500" class="legLH">
                    <img src="./img/LegR.png" width="700" height="500" class="legRH">
                </div>


                <div class = "colortemp">
                    <h1 id= "tiempo">00:00:00</h1>
                </div>

                <div class="clue">
                    <h2 id="showClue"></h2>
                </div>
                <div class="words">
                    <!-- <h2 id="showLetters">run</h2> -->
                    <h2 id="showLines"></h2>
                    <!-- <h2 id="showLines" class="" ></h2> -->
                </div>

                <div class="tries">
                    <h2 id = "showTries"></h2>
                </div>

                <form action="resultados.php" method="post" class="form" id="formularioGral" >
                <!-- <form method="post" class="form" id="formularioGral" > -->
                        <div class="input-verb-i" >
                            <label class="containerC1">
                                <input type="radio" id="check1" checked="checked" name="typeVerb" value="R" class="check1" required>
                                <div class="checkmark"></div>
                                Regular
                            </label>
                            <label class="containerC2">
                                <input type="radio" id="check2" name="typeVerb" class="check2" value="I" required>
                                <div class="checkmark"></div>
                                Irregular
                            </label>
                        </div>
                        <div class="input-past-verb">
                            <input style="text-transform:uppercase" class="pastverb" type="text" spellcheck="false" name="pastverb" placeholder="Enter the verb in past" autocomplete="off" spellcheck="false" required> 
                        </div>
                        
                        <!-- <input type="hidden" name="lose" value="-1"> -->
                        <input id="alTiempo" type="hidden" name="alTiempo" value="00:00:00">
                        <input type="hidden" name="idVerbo" value="<?php echo $idVerb;?>">
                        <input type="submit" class="formSubmit" name="aceptar" value="ACCEPT">
                </form>

                <div id="divbtns" class="divbtns">
                
                </div>
                <!-- <div class="action" onclick="actionToggle();"> -->
                <div class="action" onclick="actionToggle();">
                    <span>+</span>
                    <ul>
                        <li><h2>DO YOU WANT TO GIVE UP?</h2></li>
                        <li><a onclick="surrenderAct();">SURRENDER</a></li>
                    </ul>
                </div>


                <!-- Button trigger modal -->



                <script type="text/javascript">
                    window.idDVerbo = "<?php echo $idVerb ?>";
                    window.erasedBD = "<?php echo $erased ?>";
                    window.verboBD = "<?php echo $verbo ?>";
                    window.tipoVerb = "<?php echo $tipo ?>";
                    window.pistaVerb = "<?php echo $pista ?>";
                    window.simplePverb = "<?php echo $simplePast ?>";
                    window.ejempVerb = "<?php echo $ejemplo ?>";
                    // Justo aquí estamos pasando la variable ----^
                </script>
            <!-- <script type="text/javascript" src="./js/game.js"></script> -->


    <!--Y ya podemos incluir otros scripts ;)-->

    <script src="./js/game.js"></script>




</body>
</html>