<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET,POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
include("conexion.php");

//* Lectura de todos los usuarios
if (isset($_GET["usrLeer"])) {
    $query = "SELECT * FROM users ORDER by lastname, name ASC";
    $sqlUsuarios = mysqli_query($conexion, $query);
    if (mysqli_num_rows($sqlUsuarios) > 0) {
        $listaUsuarios = mysqli_fetch_all($sqlUsuarios, MYSQLI_ASSOC);
        echo json_encode($listaUsuarios);
    } else {
        echo json_encode([["success" => 0]]);
    }
}
