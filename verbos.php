<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleRegistro.css">
    <title>Hangman: Verbos</title>
</head>
<body>
    <main>
    <div class="bRegresar">
        <a href="javascript:history.back()" class="btnBack">Regresar</a>
    </div>
    <?php
        include("conex_db.php");
        $consulta="SELECT * FROM word";

        $resultado=mysqli_query($conexion,$consulta);
        $numFilas =mysqli_num_rows($resultado);

        $verbRand = rand(1,$numFilas);
        $resultado2=mysqli_query($conexion,"SELECT * FROM word WHERE id = $verbRand");
        while($consultaVerb =  mysqli_fetch_array($resultado2)){
            $datosW = array(
                'id' => $consultaVerb['id'],
                'word' => $consultaVerb['word'],
                'type' => $consultaVerb['type'],
                'level' => $consultaVerb['level'],
                'clue' => $consultaVerb['clue'],
                'simplepast' => $consultaVerb['simplepast'],
                'example' => $consultaVerb['example']
            );
        }
        echo json_encode($datosW);
        
        mysqli_free_result($resultado);
        mysqli_close($conexion);
        ?>
    </main>
</body>
</html>