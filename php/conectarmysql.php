<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conexión a mysql</title>
</head>

<body>
    <main>
        <?php
        $mysqli = new mysqli("localhost", "hangman", "", "hangman");
        // Si no ha creado usuario de base ed datos y no ha puesto contraseña de root
        // para el servidor localhost:
        // $mysqli = new mysqli("localhost", "root", "", "hangman");
        if ($mysqli->connect_errno) {
            echo "Fallo al conectar a MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
        }
        echo $mysqli->host_info . "\n";
        $consulta = "select * from word where id = 1";
        $resultado = mysqli_query($mysqli, $consulta);
        echo "<br>La selección devolvió " . mysqli_num_rows($resultado) . " filas.";
        $word = $resultado->fetch_array();
        echo "<br>" . $word["word"];
        echo "<br>" . $word["simplepast"];
        echo "<br>" . $word["clue"];
        // en realidad para arena se necesitan todas las palabras e ingresarlas a un
        // arreglo de objetos en javascript para jugar como en el programa de c++
    
        mysqli_close($mysqli);
        ?>
        <script>
            let palabra = "<?php echo $word["word"] ?>";
            console.log(palabra);
        </script>
    </main>
</body>

</html>