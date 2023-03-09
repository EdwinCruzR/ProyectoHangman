const surrender= document.getElementById('#btn-surrender');
const showWord= document.querySelectorAll(".showWord");
const figure = document.querySelectorAll('.figure-part');
const showClue = document.querySelectorAll('.showClue');
const showIntentos = document.querySelectorAll('.showTries');

// console.log("el id es:" + window.idDVerbo);
// console.log("el verbo es:" + window.verboBD);
// console.log("el tipo es:" + window.tipoVerb);
// console.log("el pista es:" + window.pistaVerb);
// console.log("el simple past es:" + window.simplePverb);
// console.log("el ejemplo es:" + window.ejempVerb);

// const verbo = "run";
// const verboPAST = "ran";
const clue = window.pistaVerb;

let encontrado = 0;
let intentos = 6 ;
let tiempo;
let wordSTR = window.verboBD;
let wordARR= wordSTR.split('');
// console.log(wordARR);
let cadena2 = new String() ;
let cadena = new String();
let cadenaClue = new String();
let cadenaTop = new String();
let cadenaIntentos = new String();
let arrdash = wordSTR.replace(/./g, "_").split("");
// console.log(arrdash);

// cadena = document.getElementById('showLines').innerHTML= " "+ arrdash;
document.getElementById('showLines').innerHTML="";
    arrdash.forEach(ltr => {
        document.getElementById('showLines').innerHTML+=ltr;
    });


// for (let i = 0; i < wordSTR.length; i++) {
//     cadena = document.getElementById('showLines').innerHTML= " "+ arrdash;
// }
cadenaIntentos = document.getElementById('showTries').innerHTML=  "Tries: " + intentos;

function showLetter(numero) {
    if(numero == wordSTR.length){
        // console.log("se ha completado la palabre, wiiiiii");
        document.querySelector(".containerC1").style.visibility = "visible";
        document.querySelector(".containerC2").style.visibility = "visible";
        document.querySelector(".input-verb-i").style.visibility = "visible";
        document.querySelector(".input-past-verb").style.visibility = "visible";  
        document.querySelector(".formSubmit").style.visibility = "visible";
        //mostrar una alerta con aceptar o algo asi y cuando acepte que mande al YOU WIN O LOSE
        // verificar que si lo que ingreso es correcto o no
    }
}

function evaluar(letra) {
    let resto = true;
    for (let i = 0; i < wordSTR.length; i++) {
        if(wordARR[i] == letra){
            resto = false;
            // console.log("encontrado :D");
        }
    }
    return resto;

}


function iniciar() {
    crearBotones("divbtns");
    
}

function crearBotones(divid) {
    // console.log("Se creará el alfabeto en botones y se agregarán al div con id divid");
    let contenedor = document.getElementById(divid);
    let alfabeto = new String("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
    let alfabetoArr = alfabeto.split('');

    alfabetoArr.forEach(letra => {
        let boton = document.createElement("input");
        boton.type = "button";
        boton.id = letra;
        boton.value = letra;
        boton.className = "btns";
        boton.onclick = function (e) {
            clic(e);
        };
        contenedor.appendChild(boton);
    });
}

let tempoStart = "0";

function clic(e) { 
    tempoStart++;

    if(tempoStart == 1){
        tem();
    }

    if(evaluar(e.target.id)){
        intentos--;
        switch (intentos) {
            case 0:
                document.querySelector(".legRH").style.visibility = "visible";
                window.tiempo = document.getElementById("tiempo").innerHTML ;
                document.getElementById("alTiempo").value = document.getElementById("tiempo").innerHTML;
                frmL= document.getElementById("formularioGral");
                frmL.submit();
                // document.location.href='resultados.php';

                break;
            case 1:
                document.querySelector(".legLH").style.visibility = "visible";
                break;
            case 2:
                document.querySelector(".armRH").style.visibility = "visible";
                break;
            case 3:
                document.querySelector(".armLH").style.visibility = "visible";
                break;
            case 4:
                document.querySelector(".bodyH").style.visibility = "visible";
                break;
            case 5:
                document.querySelector(".headH").style.visibility = "visible"; 
                break;
        }
    } else {
        let i = 0;
        wordARR.forEach(ltr => {
            if(e.target.id == ltr){
                // console.log("entro");
                encontrado++;
                arrdash[i] = ltr;
                // console.log (arrdash);
                
            }
            i++;
        });
        document.getElementById('showLines').innerHTML="";
        arrdash.forEach(ltr => {
            
            document.getElementById('showLines').innerHTML+=ltr;
        });
        console.log (arrdash);
        showLetter(encontrado);
    }


    cadenaIntentos = document.getElementById('showTries').innerHTML= "Tries: " + intentos;

    if(intentos == 3){
        cadenaClue = document.getElementById('showClue').innerHTML= "Clue: " + clue;
    }

    if(intentos==0){
        fin();
    }

    let contenedor = document.getElementById("divbtns");
    // console.log("Se pulsó: " + e.target.id);
    let borraboton = document.getElementById(e.target.id);

    // showLetter(e.target.id); aqui mostramos letra
    contenedor.removeChild(borraboton);
}

window.addEventListener(onload, iniciar());

function tem(){
    setTimeout(() => {
        // console.log("hola hola");
    }, 1000);

    let i = 0;
    let segundos = 00;
    let minutos = 00;
    let horas = 00;
    let segst = new String();
    let mint = new String();
    let hrst = new String();
    tiempo = setInterval(() => {
        i++;
        // console.log(i);
        segundos = i;
        if(segundos == 60){
        minutos++;
        segundos = 0;
        i = 0;
        }
        if(minutos == 60){
            horas++;
            minutos = 0; 
            }
            if(segundos <= 9){
                segst = "0"+segundos.toString();
            }else{
                segst = segundos.toString();
            }
        
            if(minutos <= 9){
                mint = "0"+minutos.toString();
            }else{
                mint = minutos.toString();
            }

            if(horas <= 9){
                hrst = "0"+horas.toString();
            }else{
                hrst = horas.toString();
            }
        
        
        document.getElementById("tiempo").innerHTML = hrst+":"+mint+":"+segst;
        cadena2= hrst+":"+mint+":"+segst;
        
    

    }, 1000);
}

function actionToggle() {
    const action = document.querySelector('.action');
    action.classList.toggle('active')
}

function surrenderAct() {
    frmL= document.getElementById("formularioGral");
    frmL.submit();
}

function fin(){
    clearInterval(tiempo);
}
