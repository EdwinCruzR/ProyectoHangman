<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Querys</title>
</head>

<body>
    <main>
        <?php

        $email = $_POST['email'];
        $nombre = $_POST['nombre'];
        $apellido = $_POST['apellido'];
        $escuela = $_POST['escuela'];
        $password = $_POST['password'];

        $mysqli = new mysqli("localhost", "root", "cbtis150$", "hangman");
        if ($mysqli->connect_errno) {
            echo "Falló al conectar a MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
        }
        echo $mysqli->host_info . "<br/>";
        $query = "INSERT INTO `hangman`.`user` (`email`, `password`, `name`, `lastname`, `school`) VALUES ('$email', '$password', '$nombre', '$apellido', '$escuela');";

        if (mysqli_query($mysqli, $query)) {
            echo "Registro agregado satisfactoriamente.";
        } else {
            echo "Error: " . $query . "<br>" . mysqli_error($mysqli);
        }
        mysqli_close($mysqli);
        ?>
    </main>
</body>

</html>