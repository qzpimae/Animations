
//INITIAL VARIABLE DECLERATIONS

const slider = document.getElementById('slider');

let canvas = document.getElementById("canvas"),
    context = canvas.getContext("2d"),
    time = 11;
    
const width = canvas.width = window.innerWidth,       //width of the canvas
      height = canvas.height = window.innerHeight,   //height of the canvas
      size = 48.1;                                  //determins size of each square

   //SETUP

   context.translate(200, height/4)

    //ANIMATION CYCLE
    
    animate()
    function animate() {
        clear()

        time++

        create(time) 

        

        setTimeout(window.requestAnimationFrame, 0, (animate));
    }

    // FUNCTIONS

    function make_circle(x, y, color, size){

        context.beginPath()
        context.arc(x, y,  size, 0, 2 * Math.PI)

        context.strokeStyle = 'hsl('+color+', 100%, 50%)'
        context.stroke()

        
    }

    function create(variable) {

        let jMax;

        console.log(variable);

        if(variable < 200) {
            jMax = variable
        } else { 
            jMax = (variable - 200) *4;
        }

        
        context.save()

        for (let j = jMax; j > 23; j--) {

            context.translate(j/4,-j/10);

            context.rotate(Math.PI/j*1.9)
            let curClr = j * 2,
            size = (j) + 0;

            for (let i = -13; i < 10; i++) {
                
                make_circle(i/i*i, i*i, curClr, size);
                
            }
        }

        context.restore()
    }

    function clear() { 
        context.save();
        context.setTransform(1, 0, 0, 1, 0, 0);
        context.clearRect(0, 0, canvas.width, canvas.height);
        context.restore();
    }