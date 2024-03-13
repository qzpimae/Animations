// console.log("rewar");


// VARS FOR CANVAS AND TIMING EVENTS
let   canvas = document.createElement('canvas'),
      context = canvas.getContext('2d'),

      width = canvas.width = window.innerWidth,
      height = canvas.height = window.innerHeight,

      time = 0,
      
      pauseAnimation = false;

context.strokeStyle = 'white';

context.lineWidth = 1;

canvas.style = ` display: block;
            position: static;
            top: 0px;
            left: 0px;
            cursor: none;
            margin:auto`;

canvas.style = `display: block;
                // position: static;
                top: 0px;
                left: 0px;
                cursor: none;
                margin:auto;
                background-color: black`;

document.body.style = `margin: 0`;

document.body.appendChild(canvas)

//USER INPUT EVENT LISTENER
document.addEventListener('keydown', userInputEvent, false);

//USER INPUT LOGIC
function userInputEvent(input) {

    pauseAnimation = !pauseAnimation;

    if (!pauseAnimation) {
        render()
    }
    
}

//SET THE CANVAS ORIGIN TO THE MIDDLE OF THE WINDOW
context.translate(width/2, height/2)

//ANIMAITON CYCLE

console.log("test");


function renderLife() {


}

render()

function render() {

    time+=1;
    console.log(time);

    renderLife();

    if (!pauseAnimation) {
        setTimeout(window.requestAnimationFrame, 30, render)
    }

}



///fun thing
// let mult = time/10
// let lim = time*mult
// let i = 0
// while (lim > 0) {

//     context.fillStyle = i % 2 == 0 ? 'white' : 'black'
//     context.beginPath()
//     context.rect(0-lim/2,0-lim/2,lim,lim)
//     context.fill()        

//     i++
//     lim-=mult
// }

// context.rotate(.1/time)