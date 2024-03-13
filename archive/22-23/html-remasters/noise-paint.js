
const p = [...Array(512)].map(() => Math.floor(Math.random() * 255));

let seed = Math.random();

// alert('CONTROLS\nPress R to toggle object rotation\nPress S to toggle frame screen clear\nPress O to ( Hide / Show ) circles\nPress P to ( Hide / Show ) lines\nPress Space to ( Pause / Play ) animation\nUse T & Y to cycle through the diffrent animation variariations')
//VARS FOR CANVAS AND TIMING EVENTS
let canvas = document.createElement('canvas'),
      context = canvas.getContext('2d'),

      width = canvas.width = window.innerWidth,
      height = canvas.height = window.innerHeight,
      timeMax = 400,
      
      time = timeMax,

      strokeW = 1,

      pauseAnimation = false,

      tiltWindow = true,

      colorIndex = 0,

      angleMult = 1,

      startColor = Math.random() * 360,
      
      greyScale = true,
      

      isLight = true;

context.strokeStyle = 'white';
context.fillStyle = 'white';

context.lineWidth = strokeW;

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

    switch (input.code) {
        case 'KeyG':
            greyScale = !greyScale;
            break;

        case 'KeyE':

            tiltWindow = !tiltWindow;
            clearFullScreen()
    
            break;
        case 'Space':

            pauseAnimation = !pauseAnimation;

            if (!pauseAnimation) render()

            // if (!pauseAnimation) {
            //     render()
            //     time = timeMax;  
            //     clearFullScreen(); 
            //     seed = Math.random(); 
            //     startColor = Math.random() * 360; 
            //     pauseAnimation = false; 
            // }
            
            break;
    }
    
}

//SET THE CANVAS ORIGIN TO THE MIDDLE OF THE WINDOW
      context.translate(width/2, height/2)

//ANIMAITON CYCLE

        render()

        function resetAnimation () {
            isLight = !isLight
            time = timeMax;  
            // clearFullScreen(); 
            seed = Math.random(); 
            startColor = Math.random() * 360; 
            pauseAnimation = false; 
            angleMult = (Math.random() * 1.5) + .1;
            console.log(angleMult);
            render()
        }

        function render() {
            if (time > 1) {
                createImg(time)
                time-=.4
            } else if ( time <= 1){
                pauseAnimation = true;
                    setTimeout(()=> { 
                        resetAnimation();
                    }, 2000)
            }
        if (!pauseAnimation) {
            setTimeout(window.requestAnimationFrame, 0, render)
        }

      }

function createImg(s) { 

    let 
        mNoise = perlin2D(s/333+seed,s/333+seed)*11*(1+seed/10),
        // Noise(s/333+seed,s/333+seed)*11*(1+seed/10),

        light = isLight ? 100 : 0,//Math.sin(time/timeMax/4) * 100;
        //greyScale ? mapNumber(time, 0, timeMax, 0, 100) : mapNumber(time-40, 0, timeMax, 50, 90),
        
        alpha = mapNumber(time, 0, timeMax, 1, 0),
        color = `hsla(
            ${greyScale ? 0 : s*3+startColor}, 
            ${greyScale ? 0 : 70}%, 
            ${light}%,
            ${alpha})`;

            // console.log(color)

    if (!isLight) alpha *= -1;
    context.lineWidth = isLight ? .1 : .5;
    
    context.strokeStyle = color;//greyScale ? `hsla(0, 0%, ${light}%)` : `hsl(${s*3+startColor}, 70%, ${light}%, ${alpha})`

    context.save()

    if (tiltWindow) context.rotate(Math.PI/2);
            mNoise/=2;
            seven_meta_cubes(s, (mNoise)/2)
            seven_meta_cubes(s, (mNoise+Math.PI)/2)
            seven_meta_cubes(s, -(mNoise)/2)
            seven_meta_cubes(s, -(mNoise+Math.PI)/2)

    context.restore()
}

function seven_meta_cubes(s, a) {

    let m = 6.93;

    context.save()

        context.translate(-s*m/4*1.07, 0)
        createRombi({size: s, angle: a})
        context.translate(s*m/4*1.07, 0)
        createRombi({size: s*1.5, angle: a*2})
        context.translate(s*m/4*1.07, 0)
        createRombi({size: s, angle: a})
        
    context.restore()

    context.save()

        context.translate(-s*m/8*1.0714, -s*m*Math.sqrt(3)/8*1.2)
        createRombi({size: s, angle: a})
        context.translate(0, s*3*1.2)
        createRombi({size: s, angle: a})
        
    context.restore()

    context.save()

        context.translate(s*m/8*1.0714, -s*m*Math.sqrt(3)/8*1.2)
        createRombi({size: s, angle: a})
        context.translate(0, s*3*1.2)
        createRombi({size: s, angle: a})
        
    context.restore()

}

function createRombi(rombiObj) {
    const {size, angle} = rombiObj;
    context.save()

    if (angle) context.rotate(angle * angleMult);

    context.beginPath()
    context.arc(0,0,size,0,Math.PI*2)

    context.save()
        context.beginPath()
        context.moveTo(size/2,0);
        context.lineTo(0,-size)
        context.lineTo(-size/2,0)
        context.lineTo(0,size)
        context.lineTo(size/2,0)
            context.stroke()
    context.restore()

    context.restore()
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


///PERLIN NOISE (written with chat-gpt)
//
//
//
////
//
//
//
//
//
//
//
//
//
////
//
//
//
//
//
//
//
//
//
////
//
//
//
//
//
//
//
//
//
////
//
//
//
//
//
//






function fade(t) {
    return t * t * t * (t * (t * 6 - 15) + 10);
  }
  
  function lerp(t, a, b) {
    return a + t * (b - a);
  }
  
  function grad(hash, x) {
    const h = hash & 1;
    return h === 0 ? x : -x;
  }
  
  function grad2(hash, x, y) {
    const h = hash & 7;
    const u = h < 4 ? x : y;
    const v = h < 4 ? y : x;
    return (h & 1 ? -u : u) + (h & 2 ? -2.0 * v : 2.0 * v);
  }
  
  
  function perlin2D(x, y) {
    const X = Math.floor(x) & 255;
    const Y = Math.floor(y) & 255;
    x -= Math.floor(x);
    y -= Math.floor(y);
    const fadeX = fade(x);
    const fadeY = fade(y);
  
    const a = p[X] + Y;
    const b = p[X + 1] + Y;
  
    return lerp(fadeY, lerp(fadeX, grad(p[a], x), grad(p[b], x - 1)),
                        lerp(fadeX, grad(p[a + 1], x - 1), grad(p[b + 1], x - 1)));
  }