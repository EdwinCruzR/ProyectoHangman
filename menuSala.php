<?php
    include("conex_db.php");
    session_start();
    $nombre = $_SESSION['name'];

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel='stylesheet' href='https://unicons.iconscout.com/release/v2.1.9/css/unicons.css'>
    <link rel="stylesheet" href="css/menuSala.css">
    <title>Hangman Game</title>
</head>
<body>
    <div class="page">
        <header tabindex="0">Salas</header>
        <div id="nav-container">
            <div class="bg"></div>
            <div class="button" tabindex="0">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </div>
            <div id="nav-content" tabindex="0">
            <ul>
                <!-- <li><a href="menuSala.html">Regresar</a></li> -->
                <li><a href="#crearSala">Crear Salas</a></li>
                <li><a href="#consultar">Consultar Salas</a></li>
                <li><a href="#editar">Editar Salas</a></li>
                <li><a href="#eliminar">Eliminar Salas</a></li>
                <li><a href="#informe">Informe Salas</a></li>
                <li class="small"><a href="menu2.php">Regresar</a><!-- <a href="#0">Instagram</a> --></li>
            </ul>
            </div>
        </div>
        <main>
            
            <div class="content">
            <h2>Personaliza tus<span>: Salas</span></h2>
            <p>En este espacio vas a poder personalizar una sala, ya sea, crear una sala, consultar una sala, editar una sala, eliminar una sala e informe de la sala. </p>
            <!-- <small><strong>NB!</strong> Use a browser that supports :focus-within</small> -->
            </div>
            <hr>
            <div class="usuario">
                <h3>
                <i class="uil uil-user"></i>
                    <?php
                        $nombre
                    ?>
                </h3>
            </div>
            <div id="crearSala" class="crearSala">
            <h1>Crear Salas</h1>

            <!-- ===================================== -->

            <form action="crearSala.php" class="from-crear" method="post">
                <div class="formContainer">
                    <div class="input-field">
                        <input type="text" spellcheck="false" name="nombre" required> 
                        <label>Nombre de la sala</label>
                    </div>
                    <div class="input-field"> 
                        <input type="text" spellcheck="false" name="descripcion" required> 
                        <label>Descripción de la sala</label>
                    </div>
                    <div class="input-YN">
                        <h3>¿Vidas ilimitadas?</h3>
                        <input type="radio" spellcheck="false" name="vidas" value="-1" required> 
                        <label>Si</label>
                        <input type="radio" spellcheck="false" name="vidas" value="6" required> 
                        <label>No</label>
                    </div>
                    <div class="input-field">
                        <input type="number" name="vidasNum" min="1" max="100">
                        <label>Numero de vidas</label>
                    </div>
                    <div class="input-YN">
                        <h3>¿Mostrar pistas?</h3>
                        <input type="radio" spellcheck="false" name="pista" value="1" required> 
                        <label>Si</label>
                        <input type="radio" spellcheck="false" name="pista" value="0" required> 
                        <label>No</label> <br>
                        <label>¿Cuantos errores para mostrarlo?</label>
                        <input type="number"  name="pistaDespues" min="1" max="5">
                    </div>
                    <div class="input-YN">
                        <h3>¿Mostrar retroalimentacion?</h3>
                        <input type="radio" spellcheck="false" name="feedback" value="1" required> 
                        <label>Si</label>
                        <input type="radio" spellcheck="false" name="feedback" value="0" required> 
                        <label>No</label>
                    </div>
                    <div class="input-YN">
                        <h3>¿Orden de palabras aleatorio?</h3>
                        <input type="radio" spellcheck="false" name="random" value="1" required> 
                        <label>Si</label>
                        <input type="radio" spellcheck="false" name="random" value="0" required> 
                        <label>No</label>
                    </div>
                    <div class="input-YN">
                        <h3>¿Sala abierta?</h3>
                        <input type="radio" spellcheck="false" name="salaAbierta" value="1" required> 
                        <label>Si</label>
                        <input type="radio" spellcheck="false" name="salaAbierta" value="0" required> 
                        <label>No</label>
                    </div>
                    <div class="input-YN">
                        <h3>¿Tiene fecha hora inicio?</h3>
                        <input type="radio" spellcheck="false" name="TiempoIni" value="1" required> 
                        <label>Si</label>
                        <input type="radio" spellcheck="false" name="TiempoIni" value="10" required> 
                        <label>No</label>
                    </div>
                    <div class="input-field">
                        <input type="time" spellcheck="false" name="horaIni"> 
                        <label>Fecha/hora inicio</label>
                    </div>
                    <div class="input-YN">
                        <h3>¿Tiene fecha hora fin?</h3>
                        <input type="radio" spellcheck="false" name="TiempoFin" required> 
                        <label>Si</label>
                        <input type="radio" spellcheck="false" name="TiempoFin" required> 
                        <label>No</label>
                    </div>
                    <div class="input-field">
                        <input type="time" spellcheck="false" name="horaFin" > 
                        <label>Fecha/hora fin</label>
                    </div>
                    <div class="input-YN">
                        <h3>¿Es general? (Todos los verbos)</h3>
                        <input type="radio" spellcheck="false" name="general" value="1" required> 
                        <label>Si</label>
                        <input type="radio" spellcheck="false" name="general" value="0" required> 
                        <label>No</label>
                    </div>
                    <!-- <div class="input-field">
                        <h3>Palabras a incluir</h3>
                        <input type="selectbox"  name="palabras" required>
                    </div>
                    <div class="input-field">
                        <input type="text" spellcheck="false" name="creador" required> 
                        <label>Nombre del creador</label>
                    </div> -->
                    <!-- añadir esto a los demas en lugar de url -->
                    <input type="hidden" name="usuarioID" value="<?php echo $userID;?>" />
                    <input type="submit" class="formSubmit" name="Crear" value="Crear">
                </div>
            </form>


            <!-- ====================================== -->

            </div>
            <hr>
            <div id="consultar" class="consultar">
            <h1>Consultar Salas</h1>
            <form class="formConsultar">
                <div class="formContainer">
                    <div class="input-field">
                        <!-- <input type="text" spellcheck="false" name="nombre" required>  -->
                        <label>Id</label>
                    </div>
                    <div class="input-field"> 
                        <!-- <input type="text" spellcheck="false" name="apellido" required>  -->
                        <label>Codigo</label>
                    </div>
                    <div class="input-field">
                        <!-- <input type="text" spellcheck="false" name="escuela" required>  -->
                        <label>BotonQR</label>
                    </div>
                    <div class="input-field">
                        <!-- <input type="email" id="email" name="email" required> -->
                        <label>Nombre</label>
                    </div>
                    <div class="input-field">
                        <!-- <input type="password" spellcheck="false" name="password" required>  -->
                        <label>Descripcion</label>
                    </div>
                    <div class="input-field">
                        <input type="button" spellcheck="false" name="lista" value="Lista de palabras" required> 
                    </div>
                    <div class="input-field">
                        <input type="button" spellcheck="false" name="editar" value="Editar" required> 
                    </div>
                    <div class="input-field">
                        <input type="button" spellcheck="false" name="eliminar" value="Eliminar" required> 
                    </div>
                    <input type="submit" class="formSubmit" name="consultar" value="Consultar">
                </div>
            </form>
            </div>
            <hr>
            <div id="editar" class="editar">
            <h1>Editar Salas</h1>
            </div>
            <hr>
            <div id="eliminar" class="elimarSala">
            <h1>Eliminar Salas</h1>
            </div>
            <hr>
            <div id="informe" class="informeSala">
            <h1>Informe Salas</h1>
            </div>
            <hr>
        </main>
    </div>
</body>
</html>