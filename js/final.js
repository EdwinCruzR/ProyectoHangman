
// console.log("tu tiempo fue: " + window.time);

function actionToggle() {
    const action = document.querySelector('.action');
    action.classList.toggle('active')
}

function deshabilitaRetroceso(){ 
    window.location.hash="no-back-button";
    window.location.hash="Again-No-back-button" //chrome 
    window.onhashchange=function(){window.location.hash="no-back-button";}
}


