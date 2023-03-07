<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Objetos</title>
</head>

<body>
    <main>
        <?php
        class Palabra
        {
            private $palabra;
            private $pasado;
            public function __construct($palabra, $pasado)
            {
                $this->palabra = $palabra;
                $this->pasado = $pasado;
            }

            public function __toString()
            {
                return "El verbo es:" . $this -> palabra . " y su pasado es: " . $this -> pasado;
            }

            public function getPasado()
            {
                return $this->pasado;
            }
        }

        $mipalabra = new Palabra("PLAY", "PLAYED");
        //print_r($mipalabra);
        echo $mipalabra;

        echo "<br>" . $mipalabra->getPasado();
        
        ?>
    </main>
</body>

</html>