<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleRegistro.css">
    <title>Hangman: Creando</title>
</head>

<body>
    <main>
    <div class="bRegresar">
        <a href="javascript:history.back()" class="btnBack">Regresar</a>
    </div>
    
    <?php 

    include("conex_db.php");


    if(!empty($_POST['nombre']) && !empty($_POST['descripcion']) && !empty($_POST['vidas']) && !empty($_POST['pista']) && !empty($_POST['feedback']) && !empty($_POST['TiempoIni']) && !empty($_POST['TiempoFin']) && !empty($_POST['general'])){
        
        
        $nombre = $_POST['nombre'];
        $descripcion = $_POST['descripcion'];

        if((int)$_POST['vidas'] == -1){
            $vidas = (int)$_POST['vidas'];
        }else{
            $vidas = (int)$_POST['vidasNum'];
        }

        if((int)$_POST['pista'] == 1){
            $pista = (int)$_POST['pistaDespues'];
        }else{
            $pista = (int)$_POST['pista'];
        }

        $userID = (int)$_POST['usuarioID'];

        $retroalimentacion = (int)$_POST['feedback'];
        $randomPalab = (int)$_POST['random'];
        $salaAbierta = (int)$_POST['salaAbierta'];
        $fechaIni = (int)$_POST['TiempoIni'];

        $horaIni = $_POST['horaIni'];

        $horaFinish = (int)$_POST['TiempoFin'];

        $horaFin = $_POST['horaFin'];

        $general = (int)$_POST['general'];

        $permitted_chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        function generate_string($input, $strength = 6) {
            $input_length = strlen($input);
            $random_string = '';
            for($i = 0; $i < $strength; $i++) {
                $random_character = $input[mt_rand(0, $input_length - 1)];
                $random_string .= $random_character;
            }
            return $random_string;
        }
        //$roomcode = "a";
        $roomcode = substr(str_shuffle($permitted_chars), 5, 6);
        //$roomcode = generate_string($permitted_chars);
        echo gettype($roomcode);
        $var = NULL;

        $consulta = "INSERT INTO room (roomname, description, lives, clue, clueafter, feedback, random, isopen, hasstartdatetime, startdatetime, hasenddatetime, enddatetime, isgeneral, roomcode, user_id) 
        VALUES ('$nombre','$descripcion','$vidas','$pista','$pista','$retroalimentacion','$randomPalab','$salaAbierta','$fechaIni','$fechaIni == 1 ? $horaIni:$var',$horaFinish,'$horaFinish == 1 ? $horaFin:$var',
        $general,'$roomcode',$userID)";

        $resultado = mysqli_query($conexion,$consulta);
            if ($resultado) {
                
                echo "\n¡Se creo correctamente la sala!\n"; 
                echo "TU CODIGO DE SALA ES:\n";
                echo $roomcode;
                

            } else {
                echo "error";
            }
        
    }else{

        ?>
        <div class = "bad">
            <h4>error al registrarte</h4>
            <h1 id= "regBD">TODOS LOS DATOS SON OBLIGATORIOS</h1>
        </div>
        <?php 
    }

?>

    </main>
</body>

</html>