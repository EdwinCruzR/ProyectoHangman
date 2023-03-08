<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultados</title>
    <link rel="stylesheet" href="./css/final.css">
</head>
<body onload=deshabilitaRetroceso()>

<?php

    include("conex_db.php");

    if(!empty($_POST['idVerbo'])){
        $tiempo = $_POST['alTiempo'];
        // echo $tiempo;
        $verboId = $_POST['idVerbo'];
        $tipoVerbo = isset($_POST['typeVerb']) ? $_POST['typeVerb'] : 0 ;
        $verboSimple =isset($_POST['pastverb']) ? mb_strtoupper(trim($_POST['pastverb'])) : 0 ;
        // $uLose = (int)$_POST['lose'];

        $resultado2=mysqli_query($conexion,"SELECT * FROM word WHERE id = '$verboId'");

        while($consultaVerb =  mysqli_fetch_array($resultado2)){
            $idVerb = $consultaVerb['id'];
            $verbo = $consultaVerb['word'];
            $tipo = $consultaVerb['type'];
            $pista = $consultaVerb['clue'];
            $simplePast = strtoupper($consultaVerb['simplepast']);
            $ejemplo = $consultaVerb['example'];
        }
        // echo " = ".$simplePast;

            if($tipo == $tipoVerbo && $verboSimple == $simplePast){
                winner($verbo,$tipo,$simplePast,$ejemplo,$tiempo);
            } else{
                losser($verbo,$tipo,$simplePast,$ejemplo,$tiempo);
            }
        
    } else{

        echo "error"; 
        ?>
        <script>
            console.log("error");
            // document.location.href='index.html';
        </script>
        <?php 
    }



    function losser($verbo,$tipoVerb,$simplePas,$ejemplo,$tiempo){
        ?>
            <div class="conteiner">
            <div class="content">

                <div class= "reswin">
                    <div class = "loswin">
                        <h1 id="youLose">YOU LOSE</h1>
                    </div>
                </div>
                <div class= "tx1">
                    <p>Verbo: 
                    <?php 
                        echo $verbo;
                    ?>
                    </p>
                </div>
                <div class= "tx4">
                    <p>Tipo de verbo: 
                    <?php 
                        if($tipoVerb == "I"){
                            echo "IRREGULAR";
                        }else{
                            echo "REGULAR";
                        }
                    ?>
                    </p>
                </div>
                <div class= "tx5">
                    <p>Verbo en pasado simple: 
                    <?php 
                        echo $simplePas;
                    ?>
                    </p>
                </div>
                <div class= "tx5">
                    <p>Ejemplo: 
                    <?php 
                        echo $ejemplo;
                    ?>
                    </p>
                </div>

                <div class= "tx2">
                    <p>Tu tiempo:
                    <?php 
                        echo $tiempo;
                    ?>
                    </p>
                </div>
                

            </div>
            <div class="statistics">
                <h1>Statistics</h1>
            </div>
            
        </div>
        <div class="action" onclick="actionToggle();">
            <span>+</span>
            <ul>
                <li><h2>DO YOU WANT TO GO BACK TO THE MENU?</h2></li>
                <li><a href="start.html">RETURN</a></li>
            </ul>
        </div>
        <?php
    }


    function winner($verbo,$tipoVerb,$simplePas,$ejemplo,$tiempo)
        {
            ?>
            <div class="conteiner">
                <div class="content">

                    <div class= "reswin">
                        <div class = "loswin">
                            <h1 id="youWin">YOU WIN</h1>
                        </div>
                    </div>
                    <div class= "tx1">
                        <p>Verbo: 
                        <?php 
                            echo $verbo;
                        ?>
                        </p>
                    </div>
                    <div class= "tx4">
                        <p>Tipo de verbo: 
                        <?php 
                            if($tipoVerb == "I"){
                                echo "IRREGULAR";
                            }else{
                                echo "REGULAR";
                            }
                        ?>
                        </p>
                    </div>
                    <div class= "tx5">
                        <p>Verbo en pasado simple: 
                        <?php 
                            echo $simplePas;
                        ?>
                        </p>
                    </div>

                    <div class= "tx5">
                    <p>Ejemplo: 
                    <?php 
                        echo $ejemplo;
                    ?>
                    </p>
                    </div>

                    <div class= "tx2">
                        <p>Tu tiempo:
                        <?php 
                            echo $tiempo;
                        ?>
                        </p>
                    </div>
                    <!-- <div  class= "tiempo">
                        <p id="showTime">Nuevo record: 0 </p>
                    </div>
                    <div class= "tx6"><p>Anterior record: 0</p></div> -->

                </div>
                <div class="statistics">
                    <h1>Statistics</h1>
                </div>
                
            </div>
            <div class="action" onclick="actionToggle();">
                <span>+</span>
                <ul>
                    <li><h2>DO YOU WANT TO GO BACK TO THE MENU?</h2></li>
                    <li><a href="start.html">RETURN</a></li>
                </ul>
            </div>
            <?php

        }


?>
    <script src="./js/final.js" ></script>
    
</body>
</html>