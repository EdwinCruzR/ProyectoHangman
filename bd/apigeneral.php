<?php
/* API general */
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET,POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
include("conexion.php");

//* Devuelve un timestamp del servidor, generado en la base de datos
if (isset($_GET["timestamp"])) {
    $sqlInsert = mysqli_query($conexion, "INSERT INTO timestamps (observ) VALUES('test')");
    $sqlSelect = mysqli_query($conexion, "SELECT * FROM timestamps");
    if (mysqli_num_rows($sqlSelect) > 0) {
        $timestamp = mysqli_fetch_all($sqlSelect, MYSQLI_ASSOC);
        $sqlTruncate = mysqli_query($conexion, "TRUNCATE TABLE timestamps");
        echo json_encode($timestamp);
    } else {
        echo json_encode(["success" => 0]);
    }
    exit();
}
