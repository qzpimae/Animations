//this file uses the simplex noise algorithm from a library
// alert('CONTROLS\nPress S to toggle frame screen clear\nPress Space to ( Pause / Play ) animation\nUse O & L to toggle displaying of lines/dots\nUse Up and Down Arrow Keys to change speed of animation')
const Noise = toxi.math.noise.simplexNoise.noise,
      pi = Math.PI,
      sqrt = Math.sqrt,
      pow = Math.pow;

let seed = Math.random()*1000,
    mosPos = {
        x: 1000,
        y: 1000,
    };
//VARS FOR CANVAS AND TIMING EVENTS
let canvas = document.createElement('canvas'),
      context = canvas.getContext('2d'),
      width = canvas.width = window.innerWidth,
      height = canvas.height = window.innerHeight,
      time = 0,
      timeMax = Infinity,
      timeForward = true,
      speed = .5,
      clearScreen = true,
      pauseAnimation = false,
      showLines = true,
      showDots = true,
      isInColor = true,
      noiseAmt = 10,
      scaleSz = 20;

      // square in middle
// const limits = {
//     sX: 16,
//     eX: 55,
//     sY: 5,
//     eY: 40,
// };

// corner to corner
const limits = {
    sX: 0,
    eX: 65,
    sY: 0,
    eY: 40,
};

context.strokeStyle = 'white';
context.fillStyle = 'white';

context.lineWidth = .25;

canvas.style = `display: block;
                position: static;
                top: 0px;
                left: 0px;
                cursor: none;
                margin:auto;
                background-color: black`;

document.body.style = `margin: 0`;

document.body.appendChild(canvas)

//USER INPUT EVENT LISTENER
document.addEventListener('keydown', userInputEvent, false);
canvas.onmousemove = findObjectCoords;

//USER INPUT LOGIC
function userInputEvent(input) {
    switch (input.code) {
        case 'Space':
            pauseAnimation = !pauseAnimation;
            if (!pauseAnimation) {
                render()
            }
        break;
        case 'ArrowUp':
            speed = speed < 4 ? speed+.1 : 4;
        break;
        case "ArrowDown":
            speed = speed > .1 ? speed-.1 : .1;
        break;

        case 'KeyZ':
            speed = speed < 1000 ? speed+.1 : 1000;
        break;
        case "KeyX":
            speed = speed > .1 ? speed-.1 : .1;
        break;
        case 'ArrowLeft':
            noiseAmt = noiseAmt < 1000 ? noiseAmt+.1 : 100;
        break;
        case "ArrowRight":
            noiseAmt = noiseAmt > -10 ? noiseAmt-.1 : -10;
        break;
        case "KeyL":
            showLines = !showLines;
            if (!showDots && !showLines) showDots = true
        break;
        case "KeyO":
            showDots = !showDots;
            if (!showDots && !showLines) showLines = true
        break;
        case "KeyS":
            clearScreen = !clearScreen;
        break;
        case "KeyC":
            isInColor = !isInColor;
        break;
        case "KeyU":
            limits.eY+=5;
        break;
        case "KeyJ":
            limits.eY-=5;
        break;
        case "KeyH":
            limits.eX+=5;
        break;
        case "KeyK":
            limits.eX-=5;
        break;
        }
        
}

//SET THE CANVAS ORIGIN TO THE MIDDLE OF THE WINDOW
    //   context.translate(width/2, height/2)   

//ANIMAITON CYCLE

        render()

        function render() {

        if (timeForward && time < timeMax) {
            time+=speed
        } else if (timeForward && time >= timeMax) {
            setTimeout(()=>{timeForward = false;}, 100)
        } else if (!timeForward && time > 1) {
            time-=speed
        } else if ( time <= 1){
            timeForward = true;
            time = 1.1
            seed = Math.random()  
        }

        if(clearScreen) clearFullScreen()

        // renderMouse()
            
        createImg(time)
        
        if (!pauseAnimation) {
            setTimeout(window.requestAnimationFrame, 0, render)
        }
      }

function createImg(s) { 

    
    points = [];

        for (let x = limits.sX; x < limits.eX; x++) {

            points.push([]);
            
            for (let y = limits.sY; y < limits.eY; y++) {

                const
                distance = sqrt( pow((x*scaleSz)-(mosPos.x), 2) + pow((y*scaleSz)-(mosPos.y), 2) ),
                noiseX = (x/scaleSz + seed ) - s/120-(pow(distance,2)/999999*noiseAmt), 
                noiseY = (y/scaleSz + seed ) + s/120+(pow(distance,2)/999999*noiseAmt),
                N1 = Noise(noiseX, noiseY),
                N2 = Noise(noiseY, noiseX),
                radius = .5+N1+N2 > .3 ? .5+N1+N2 : .3,
                X = x*scaleSz + (N1*scaleSz-N2*scaleSz),
                Y = y*scaleSz + (N1*scaleSz+N2*scaleSz),

                point = {x: X, y: Y, r: radius, dis: distance };

                points[x-limits.sX].push(point)
                        
            }
            
        }

        renderPoints(points)

}

function renderMouse() {
    context.fillStyle = 'white';                  
    context.beginPath()
    context.arc(mosPos.x, mosPos.y, 2, 0, pi*2)
    context.fill()
}

function renderPoints(arr) {

    // const t = Math.ceil(time/scaleSz)
    const saturation = isInColor ? 100 : 0;

    for (let i = 0; i < arr.length; i++) {

        for (let j = 0; j < arr[i].length; j++) {
            
            const p = arr[i][j],
            light = (10*p.r)+50 < 80 ? (10*p.r)+50 : 80,
            pColor = `hsl(${p.dis/3*p.r+144}, ${saturation}%, ${light}%)`;

            if (showLines) {
                const px = 
                    arr[i+1] != undefined 
                    ? arr[i+1][j]   
                    : false;
                const py = 
                    arr[i][j+1] != undefined 
                    ? arr[i][j+1]   
                    : false;
                const pxy = 
                    arr[i+1] != undefined 
                    && arr[i+1][j+1] != undefined 
                    ? arr[i+1][j+1] 
                    : false;

                context.strokeStyle = pColor;                  
                
                if (px||py||pxy) {
                    context.beginPath()
                    context.moveTo(p.x,p.y)
                    if (px) context.lineTo(px.x, px.y)
                    if (py) context.lineTo(py.x, py.y)
                    context.lineTo(p.x,p.y)
                    if (pxy) context.lineTo(pxy.x, pxy.y)
                    context.stroke()
                }
            }

            if (showDots) {
                context.fillStyle = pColor;                  
                context.beginPath()
                context.arc(p.x, p.y, p.r, 0, pi*2)
                context.fill()
                
            }

        }
    }

}

function clearFullScreen() {

    context.save();
    context.setTransform(1, 0, 0, 1, 0, 0);
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.restore();
    
}

function mapNumber (number, min1, max1, min2, max2) {
    return ((number - min1) * (max2 - min2) / (max1 - min1) + min2);
};


function findObjectCoords(mouseEvent) {

    let obj = canvas,
        obj_left = 0,
        obj_top = 0,
        xpos,
        ypos;

while (obj.offsetParent)
{
    obj_left += obj.offsetLeft;
    obj_top += obj.offsetTop;
    obj = obj.offsetParent;
}
if (mouseEvent)
{
    xpos = mouseEvent.pageX;
    ypos = mouseEvent.pageY;
}

xpos -= obj_left;
ypos -= obj_top;

mosPos.x = xpos
mosPos.y = ypos

}