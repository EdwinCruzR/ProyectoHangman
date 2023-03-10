<?php
/* API general */
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET,POST");
header("Content-Type: application/json; charset=UTF-8");
//header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$servidor = "65.99.225.56";
$usuario = "cbtised3_hangman";
$contrasenia      = "vGVWQ_Ljlm*K";
$nombreBaseDatos = "cbtised3_hangman";

$conexion = new mysqli($servidor, $usuario, $contrasenia, $nombreBaseDatos);


// Test de lectura de todos los usuarios
$query = "SELECT * FROM users ORDER by lastname ASC";
$sqlUsuarios = mysqli_query($conexion, $query);
if (mysqli_num_rows($sqlUsuarios) > 0) {
    $listaUsuarios = mysqli_fetch_all($sqlUsuarios, MYSQLI_ASSOC);
    echo json_encode($listaUsuarios);
} else {
    echo json_encode([["success" => 0]]);
}




/* if (isset($_GET["consultar"])) {
    $sqlProductos = mysqli_query($conexionBD, "SELECT * FROM productos WHERE id=" . $_GET["consultar"]);
    if (mysqli_num_rows($sqlProductos) > 0) {
        $productos = mysqli_fetch_all($sqlProductos, MYSQLI_ASSOC);
        echo json_encode($productos);
    } else {
        echo json_encode(["success" => 0]);
    }
    exit();
}

if (isset($_GET["borrar"])) {
    $sqlProductos = mysqli_query($conexionBD, "DELETE FROM productos WHERE id=" . $_GET["borrar"]);
    if ($sqlProductos) {
        echo json_encode(["success" => 1]);
    } else {
        echo json_encode(["success" => 0]);
    }
    exit();
}

if (isset($_GET["insertar"])) {
    $data = json_decode(file_get_contents("php://input"));
    $nombre = $data->nombre;
    $precio = (float) $data->precio;
    $sqlProductos = mysqli_query($conexionBD, "INSERT INTO productos(nombre,precio) VALUES('$nombre','$precio') ");
    echo json_encode(["success" => 1]);
    exit();
}

if (isset($_GET["actualizar"])) {
    $datos = json_decode(file_get_contents("php://input"));
    $id = (int) $datos->id;
    $nombre = $datos->nombre;
    $precio = (float) $datos->precio;
    $sqlProductos = mysqli_query($conexionBD, "UPDATE productos SET nombre='$nombre',precio='$precio' WHERE id='$id'");
    echo json_encode(["success" => 1]);
    exit();
}

if (isset($_GET["leer"])) {
    $sqlProductos = mysqli_query($conexionBD, "SELECT * FROM productos ORDER by nombre ASC");
    if (mysqli_num_rows($sqlProductos) > 0) {
        $productos = mysqli_fetch_all($sqlProductos, MYSQLI_ASSOC);
        echo json_encode($productos);
    } else {
        echo json_encode([["success" => 0]]);
    }
}
 */
?>
