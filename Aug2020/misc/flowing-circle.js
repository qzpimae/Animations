//this file uses the simplex noise algorithm from a library

const Noise = toxi.math.noise.simplexNoise.noise,
      pi = Math.PI,
      sqrt = Math.sqrt,
      pow = Math.pow;
let seed = Math.random()*100;
//VARS FOR CANVAS AND TIMING EVENTS
let canvas = document.createElement('canvas'),
      context = canvas.getContext('2d'),
      width = canvas.width = window.innerWidth,
      height = canvas.height = window.innerHeight,
      time = 0,
      timeMax = Infinity,
      timeForward = true,
      speed = .37,
      clearScreen = true,
      pauseAnimation = false,
      szMlt = .5,
      layers = 2,
      layerMult = 1,
      rotation = 0; 


// context.strokeStyle = 'white';
context.strokeStyle = "rgba(1, 1, 1, 0)";
// context.fillStyle = 'white';

context.lineWidth = 1;

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

//USER INPUT LOGIC
function userInputEvent(input) {
    // console.log(input.code);
    switch (input.code) {
        case 'KeyZ':
        clearScreen = !clearScreen;
        break;
        case 'Space':
            pauseAnimation = !pauseAnimation;
            if (!pauseAnimation) {
                render()
            }
        break;
        case 'ArrowUp':
            speed = speed < 10 ? speed+.01 : 10;
        break;
        case "ArrowDown":
            speed = speed > .002 ? speed-.01 : .002;
        break;
        case 'KeyQ':
            layerMult = layerMult < 50 ? layerMult+.01 : 50;
        break;
        case "KeyA":
            layerMult = layerMult > .005 ? layerMult-.01 : .005;
        break;
        case 'KeyO':
            layers = layers < 100 ? layers+1 : 100;
        break;
        case 'KeyL':
            layers = layers > 1 ? layers-1 : 1;
        break;
        case 'KeyT':
            speed = speed < 10 ? speed+.1 : 10;
        break;
        case 'KeyG':
            speed = speed > .002 ? speed-.1 : .002;
        break;
        case 'KeyD':
            szMlt = szMlt < 10 ? szMlt+.01 : 10;
        break;
        case 'KeyC':
            szMlt = szMlt > .002 ? szMlt-.01 : .002;
        break;

        case 'KeyP':
            rotation += 1;
            break;
        case 'Semicolon': 
            rotation -= 1;
            break;

        case 'Slash':
            time = 0;
            break;
        
        case 'KeyM': 
            console.log(`
            case 'ArrowUp':
            speed = speed < 10 ? speed+.01 : 10;
        break;
        case "ArrowDown":
            speed = speed > .002 ? speed-.01 : .002;
        break;
        case 'KeyQ':
            layerMult = layerMult < 50 ? layerMult+.01 : 50;
        break;
        case "KeyA":
            layerMult = layerMult > .005 ? layerMult-.01 : .005;
        break;
        case 'KeyO':
            layers = layers < 100 ? layers+1 : 100;
        break;
        case 'KeyL':
            layers = layers > 1 ? layers-1 : 1;
        break;
        case 'KeyT':
            speed = speed < 10 ? speed+.1 : 10;
        break;
        case 'KeyG':
            speed = speed > .002 ? speed-.1 : .002;
        break;
        case 'KeyD':
            szMlt = szMlt < 10 ? szMlt+.1 : 10;
        break;
        case 'KeyC':
            szMlt = szMlt > .002 ? szMlt-.1 : .002;
        break;
    }
            `);
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

            
        for (let i = 0; i < layers; i++) {

            //    context.fillStyle = i % 2 != 0 && !clearFullScreen ? '100' : '0'
            //    context.strokeStyle = i % 2 != 0 && !clearFullScreen ? '100' : '0'
               createImg(time+(i*layerMult), i)
            
        }
        if (!pauseAnimation) {
            setTimeout(window.requestAnimationFrame, 0, render)
        }
      }

function createImg(s, b) { 

    context.save();

        context.translate(width/2, height/2)

        context.rotate(rotation/180);

        context.translate(-width/2, -height/2)

        // console.log(!clearScreen)

      
        for (let x = 0; x < width/20+1; x+=.7) {
            
            for (let y = 0; y < height/20+1; y+=.7) {

                const
                noiseX = x/30 + s/50, 
                noiseY = y/30,
                distance = sqrt( pow((x*20)-(width/2), 2) +  pow((y*20)-(height/2), 2) ),
                N1 = Noise(noiseX, noiseY),
                N2 = Noise(noiseY,noiseX),
                radius = 4-distance/300,
                X = x*20+ N1*(2+time/10)+N2*(2+time/10),
                Y = y*20+ N1*(2+time/10)-N2*(2+time/10);

                context.fillStyle =  `hsl(0, 0%, ${(b % 2 != 0 && !clearScreen ? 0: 100)-distance/5}%)`;
                context.beginPath()
                context.arc(X, Y, Math.abs(radius*szMlt), 0, pi*2)
                context.fill()
                        
            }
            
        }


    // context.translate(-width/2, -height/2)

    context.restore();

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