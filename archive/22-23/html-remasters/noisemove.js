
const Noise = toxi.math.noise.simplexNoise.noise;
let seed = Math.random()*1000;

// alert('CONTROLS\nPress E to adjust object orientation\nPress S to toggle frame screen clear\nPress Space to ( Pause / Play ) animation\nUse T & Y to cycle through the diffrent animation variariations')
//VARS FOR CANVAS AND TIMING EVENTS
let canvas = document.createElement('canvas'),
      context = canvas.getContext('2d'),

      width = canvas.width = window.innerWidth,
      height = canvas.height = window.innerHeight,

      time = -2,

      speed = .9,
      seedSpeed = .03,

      pixSize = 5,

      ogTM = width/pixSize/2,
      tmDiv = 1.5,
      timeMax = ogTM/tmDiv,

      timeForward = false,

      strokeW = 1,


      lightMode = true,
      
      pauseAnimation = false,

      viewWidth = 1,
      viewHeight = height/tmDiv;

context.strokeStyle = 'white';
context.fillStyle = 'white';

context.lineWidth = strokeW;

canvas.style = `display: block;
                position: static;
                top: 0px;
                left: 0px;
                // cursor: none;
                margin:auto;
                background-color: black`;

document.body.style = `margin: 0`;

document.body.appendChild(canvas)

//USER INPUT EVENT LISTENER
document.addEventListener('keydown', userInputEvent, false);

//USER INPUT LOGIC
function userInputEvent(input) {

    switch (input.code) {

        case 'KeyT':
            rombiPick = rombiPick > 0 ? rombiPick-1 : 14;
            // console.log(rombiPick);         
        break;
        case 'KeyY':
            rombiPick = rombiPick < 14 ? rombiPick+1 : 0;
            // console.log(rombiPick);         
        break;
        case 'KeyS':
            lightMode = !lightMode;
        break;
        case 'KeyE':
            tiltWindow = !tiltWindow;
            // console.log(tiltWindow);    
        break;
        case 'Space':
            pauseAnimation = !pauseAnimation;
            if (!pauseAnimation) {
                render()
            }
        break;
        case 'ArrowUp':
            speed = speed < 1 ? speed+.1 : 1;
        break;
        case "ArrowDown":
            speed = speed > .2 ? speed-.1 : .2;
    }

    
    
}

//SET THE CANVAS ORIGIN TO THE MIDDLE OF THE WINDOW
    //   context.translate(width/2, height/2)   

//ANIMATION CYCLE

render()

function renderFrame () {



    context.save()

    // clearFullScreen()

    context.translate(0,height/2-viewHeight/2)
    while (time < timeMax) {
        time += speed;
        createImg(time)
    }
    time = 0;
    // seed = Math.random()*1000
    seed += seedSpeed;
    timeMax = ogTM/tmDiv

    // if(lightMode) clearFullScreen()

    context.restore()

}

function render() {

    renderFrame()

    seedSpeed-=.0001
    // return

    if (!pauseAnimation) {
        setTimeout(window.requestAnimationFrame,  0, render)
    }

}

function createImg(s) { 

    // let mNoise = Noise(seed,seed+.1)*1;
    
    s = -s;

    // context.translate(width/2-viewWidth/2,height/2-viewHeight/2)

    let xCount = 0;
    
    const 
        
        noiseMult = 1.2,

        nRes = time/noiseMult,// (time-timeMax/noiseMult)/timeMax*noiseMult;
        transX = 0;// nRes == 77 ? s/30 : 0,
        offX = (mapNumber(nRes, 2.3, timeMax, 0, width*4)/nRes)+transX,
        offY = (mapNumber(nRes, 2.1, timeMax, 0, height*4)/nRes);

    // console.log(nRes);


    // viewWidth = parseInt(mapNumber(abs(s), 0, timeMax, 1, 50))


    for (let x = 0; x < viewWidth; x+=pixSize) {
        // console.log(x);
        let yCount = 0;

        for (let y = 0; y < viewHeight; y+=pixSize) {

            const
                xPos = xCount;// Math.abs(xCount-viewWidth/2),
                yPos = yCount - viewHeight/8;// Math.abs(yCount-viewHeight/2),
                noiseX = ((xPos)/nRes)+offX+seed,
                noiseY = ((yPos)/nRes)+offY+seed,
                divid = nRes < 40 ? nRes : 40,
                lightMapMin = lightMode ? 100 : -100,
                lightMapMax =  lightMode ? -100: 100,
                light = Math.abs( Math.abs((mapNumber(y-viewHeight/2, -viewHeight/2, viewHeight/2, lightMapMin, lightMapMax))) - ((Math.abs((Noise(noiseX, noiseY)*divid )) % divid)+nRes/1.5)) ,
                color = (Math.abs((Noise(noiseX, noiseY)*divid ) % 10)*divid)-60;

            // console.log(light);
            context.strokeStyle = `hsl(${color}, 50%, ${light}%)`; //Math.random()*100

            context.lineWidth = pixSize;
           
            // console.log(x, y);
            const xLeft = s*pixSize+(width/2) + x 
            const xRight = -s*pixSize+(width/2) + x
            context.beginPath()
            context.moveTo(xLeft+pixSize,y)
            context.lineTo(xLeft+pixSize*2,y)
            context.stroke()
            context.closePath()

            context.beginPath()
            context.moveTo(xRight,y)
            context.lineTo(xRight+pixSize,y)
            context.stroke()
            context.closePath()
            

            yCount++
            
        }

        xCount++
        
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