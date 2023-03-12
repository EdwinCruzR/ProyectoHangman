
<?php 
include("conex_db.php");

    if(isset($_POST["enviar"])){

        if(!empty($_POST['email']) && !empty($_POST['password'])){
            session_start();
            $_SESSION['cuenta'] = "0";

            $email=$_POST['email'];
            $password=$_POST['password'];
            $consulta="SELECT*FROM user where email='$email' and password='$password'";
            $resultado=mysqli_query($conexion,$consulta);
    
            $filas=mysqli_num_rows($resultado);
    
            if($filas){
                $_SESSION['email'] = htmlentities($_POST["email"]);
                $_SESSION['password'] = htmlentities($_POST["password"]);
                $_SESSION['cuenta'] = "1";
            
                ?>
                    <div class = "ok">
                        <h4>Felicidades 
    
                        <?php
                            while($consultaNom =  mysqli_fetch_array($resultado)){
                                echo $consultaNom['name'];
                                $id = $consultaNom['id'];
                                $name = $consultaNom['name'];
                                $lastName = $consultaNom['lastname'];
                            }
                            $_SESSION['id'] = $id;
                            $_SESSION['name'] = $name;
                            $_SESSION['lastName'] = $lastname;
                            

                        ?>
                        </h4>
                        <h1 id= "regGD">¡HAS INICIADO SESIÓN CORRECTAMENTE!</h1>
                    </div>
                        
                    <script>location.href ="menu2.php";</script>
                <?php
    
            }else{
    
                ?>
                <div class = "bad">
                    <h4>Error al iniciar sesión</h4>
                    <h1 id= "regBD">ERROR DE AUTENTIFICACION</h1>
                </div>
                <?php
            }
            mysqli_free_result($resultado);
            mysqli_close($conexion);
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
    <title>Hangman</title>
</head>
<body>



    <form method="post" class="form" >
        <h2 class="formTitle">Inicia Sesión</h2>
        <p class="formParagraph">¿Aún no tiene una cuenta? <a href="register.php" class="formLink">Registrate</a></p>
        <div class="formContainer">
            <div class="input-field">
                <input type="email" name="email" required>
                <label>Email</label>
            </div>
            
            <div class="input-field">
                <input type="password" spellcheck="false" name="password" required>
                <label>Contraseña</label>
            </div>

            <a href="#" class="formLink">¿Olvidaste tu contraseña?</a>
            <input type="submit" class="formSubmit" name="enviar">
        </div>
        
    </form>


    <div class="bRegresar">
        <a href="index.html" class="btnBack">Regresar</a>
    </div>

</body>
</html>