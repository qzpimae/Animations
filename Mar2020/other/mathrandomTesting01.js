
//trying to figure out myself how to create random points that exclude a circle in the center of the screen with a given radius

let canvas = document.getElementById('canvas'),
      context = canvas.getContext('2d'),

      width = canvas.width = window.innerWidth,
      height = canvas.height = window.innerHeight;

      render()
      function render() {

          scale_from_center()
        //   clearFullScreen()

        //   rotate_about_the_center()

          ranCircle()


          setTimeout(window.requestAnimationFrame, 30, render)
      }


    function clearFullScreen() {

        context.save();
        context.setTransform(1, 0, 0, 1, 0, 0);
        context.clearRect(0, 0, canvas.width, canvas.height);
        context.restore();
        
    }

    function ranCircle() {

        context.save()

        context.translate(width/2, height/2)

        for (let i = 0; i < 1000; i++) {

                let radius = i/4;

                let randomX = (Math.random() * Math.cos(i)) *radius,
                    randomY = (Math.random() * Math.sin(i)) * radius,

                    x = width / randomX,
                    y = height / randomY;
            
                context.beginPath()

                context.moveTo(x,y)

                context.lineTo(x+1,y+1)

                context.strokeStyle = 'black'

                context.stroke()
                
        }

        context.restore()

    }

    function rotate_about_the_center() {


        context.translate(width/2, height/2)

        context.rotate(.01)
        context.translate(-width/2, -height/2)

    }

    function scale_from_center() {
        // context.save()
        context.translate(width/2, height/2)
        context.scale(1.01,1.01)
        context.translate(-width/2, -height/2)

        // context.restore()
    }