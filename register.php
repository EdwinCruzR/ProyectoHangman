<?php 

    if(isset($_POST["registro"])){
        

        
        if(!empty($_POST['nombre']) && !empty($_POST['apellido']) && !empty($_POST['escuela']) && !empty($_POST['email']) && !empty($_POST['password'])){

            $email = $_POST['email'];
            $nombre = $_POST['nombre'];
            $apellido = $_POST['apellido'];
            $escuela = $_POST['escuela'];
            $password = $_POST['password'];
    
    
            $host = "localhost";
            $dbuser = "root";
            $dbpassword = "cbtis150$";
            $dbname = "hangman";
    
            $conn = new mysqli($host,$dbuser,$dbpassword,$dbname);
    
            if(mysqli_connect_error()){
                die('connect error('.mysqli_connect_errno().')'.myslqi_connect_error());
            }else{
                $SELECT = "SELECT email from user where email = ? limit 1";
                $INSERT = "INSERT INTO user (email, password, name, lastname, school)values(?,?,?,?,?)";
    
                $stmt = $conn ->prepare($SELECT);
                $stmt ->bind_param("s",$email);
                $stmt ->execute();
                $stmt ->bind_result($email);
                $stmt ->store_result();
    
                    //apilar datos en la bd
                $rnum = $stmt->num_rows;
    
                if($rnum == 0){
                    //sellar la conexion de base de datos pero que este abierta
                    $stmt ->close();
                        
                    $stmt = $conn->prepare($INSERT);
                    $stmt ->bind_param("sssss", $email,$password,$nombre,$apellido,$escuela);
                    $stmt ->execute();
    
                    ?>
                    <div class = "ok">
                        <h4>Felicidades</h4>
                        <h1 id= "regGD">¡TE HAS REGISTRADO CORRECTAMENTE!</h1>
                        <h4>Vuelve a la página principal y inicia sesión</h4>
                    </div>
                    <?php  
                }else{
                    ?>
                    <div class = "bad">
                        <h4>Error al registrarte</h4>
                        <h1 id= "regBD">ALGUIEN YA REGISTRO ESE EMAIL</h1>

                    </div>
                    <?php 
                }
    
                $stmt -> close();
                $conn -> close();
    
            }
    
        }else{
    
            ?>
            <div class = "bad">
                <h4>error al registrarte</h4>
                <h1 id= "regBD">TODOS LOS DATOS SON OBLIGATORIOS</h1>
            </div>
            <?php 
            die();
        }

    }

?>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleSing.css">
    <!-- <link rel="stylesheet" href="css/styleRegistro.css"> -->
    <title>Hangman</title>
</head>
<body>

    <!-- <div class="titulo">
        <label for="titulo" id="titulo"> HANGMAN GAME </label>
    </div> -->

    <form  method="post" class="form">
        <h2 class="formTitle">Registrate</h2>
        <p class="formParagraph">¿Ya tienes una cuenta? <a href="singUp.html" class="formLink">Inicia Sesión</a></p>
        <div class="formContainer">
            <div class="input-field">
                <input type="text" spellcheck="false" name="nombre" required> 
                <label>Nombre</label>
            </div>
            <div class="input-field"> 
                <input type="text" spellcheck="false" name="apellido" required> 
                <label>Apellido</label>
            </div>
            <div class="input-field">
                <input type="text" spellcheck="false" name="escuela" required> 
                <label>Escuela</label>
            </div>
            <div class="input-field">
                <input type="email" id="email" name="email" required>
                <label>Email</label>
            </div>
            <div class="input-field">
                <input type="password" spellcheck="false" name="password" required> 
                <label>Contraseña</label>
            </div>

            <input type="submit" class="formSubmit" name="registro" value="Resgistrar">
        </div>
    </form>


    <div class="bRegresar">
        <a href="menu.html" class="btnBack">Regresar</a>
    </div>

</body>
</html>