<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Arrays</title>
</head>

<body>
    <main>

        <?php
        $arrEntero = [
            "01" => 100,
            "02" => -14,
            "03" => 1,
            "04" => 0,
        ]; // nosotros creamos las keys strings, pueden ser enteros

        $arrEntero2 = [
            "omega" => 100,
            "delta" => -14,
            "beta" => 1,
            "alfa" => 0,
        ];


        echo $arrEntero["03"];

        $arr2 = ['A', 'B', 'C', 'D']; // se crean los keys enteros desde el 0
        echo $arr2[0];

        sort($arrEntero);
        echo $arrEntero[0];
        echo "<BR>" . count($arrEntero);
        print_r(array_values($arr2));

        ksort($arrEntero2); // se ordena el arreglo por key
        echo "<hr>";
        foreach ($arrEntero2 as $key => $val) { // se recorre el arreglo y se obtiene en cada iteración la key y su valor asociado
            echo "$key = $val <br/>";
        }
        echo "<br/> $arrEntero2[omega]";
        
        echo "<hr>";
        $keys = array_keys($arrEntero2);
        foreach ($keys as $key => $val) {
            echo "$key = $val <br/>";
        }
        echo "<br/> $keys[0]";
        
        echo "<hr>";
        foreach ($arr2 as $value) { // se recorre el arreglo y se usa cada valor (non el key)
            echo $value . "<br/>";
        }

        ?>
    </main>
</body>

</html>