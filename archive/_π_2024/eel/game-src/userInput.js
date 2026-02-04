// Swipe control variables
let touchStartX = 0;
let touchStartY = 0;
let touchEndX = 0;
let touchEndY = 0;

let clicks = 0

document.addEventListener('keydown', keyDownHandler, false);
document.addEventListener('touchstart', handleTouchStart, false);
document.addEventListener('touchend', handleTouchEnd, false);

canvas.onclick = () => {

    clicks++
}

const controlsMsgDes = "desktop: \n| space to start | wasd to move | p/q to pause |"
const controlsMsgMob = "moblie: \n| tap to start | swipe to move |"

// Handle keyboard input for direction
function keyDownHandler(event) {
    switch (event.code) {
        case "Space":
            if (!gameStarted) {
                gameStarted = true;
                // startGame();
            }
            break;
        case "ArrowLeft":
        case "KeyA":
            if (direction !== 'r') direction = 'l';
            break;
        case "ArrowRight":
        case "KeyD":
            if (direction !== 'l') direction = 'r';
            break;
        case "ArrowUp":
        case "KeyW":
            if (direction !== 'd') direction = 'u';
            break;
        case "ArrowDown":
        case "KeyS":
            if (direction !== 'u') direction = 'd';
            break;
        case "KeyP":
        case "KeyQ":
            if (gameStarted) {
                alert('Game Paused\n\nPress Enter, Space, or "Ok" to resume');
            }
            break;
        default:
            break;
    }
}

// Handle touch start and prevent scrolling
function handleTouchStart(event) {
    if (!gameStarted) {
        gameStarted = true;
        // startGame();
    }
    event.preventDefault(); // Prevent default scrolling behavior
    const touch = event.touches[0];
    touchStartX = touch.clientX;
    touchStartY = touch.clientY;
}

// Handle touch end, prevent scrolling, and calculate swipe direction
function handleTouchEnd(event) {
    event.preventDefault(); // Prevent default scrolling behavior
    const touch = event.changedTouches[0];
    touchEndX = touch.clientX;
    touchEndY = touch.clientY;

    handleSwipe();
}

// Prevent default behavior for touch move as well
document.addEventListener('touchmove', function(event) {
    event.preventDefault();
}, { passive: false });

// Function to determine swipe direction
function handleSwipe() {
    const diffX = touchEndX - touchStartX;
    const diffY = touchEndY - touchStartY;

    if (Math.abs(diffX) > Math.abs(diffY)) {
        // Horizontal swipe
        if (diffX > 0 && direction != 'l') {
            // Swipe right
            direction = 'r';
        } else if (direction != 'r'){
            // Swipe left
            direction = 'l';
        }
    } else {
        // Vertical swipe
        if (diffY > 0 && direction != 'u') {
            // Swipe down
            direction = 'd';
        } else if (direction != 'd'){
            // Swipe up
            direction = 'u';
        }
    }
}

// PLAYER MOVEMENT CONTROL
function direction_handling() {
    let currentSnakeHead = snkPos[0];

    switch (direction) {
        case 'd':
            currentSnakeHead.y++;
            break;
        case 'u':
            currentSnakeHead.y--;
            break;
        case 'r':
            currentSnakeHead.x++;
            break;
        case 'l':
            currentSnakeHead.x--;
            break;
        default:
            break;
    }
}



function renderControlsMessage() {

                
    let x = 0;
    let y = 0;

    let fontSize = 10;
    let fonts = ["Arial", "Helvetica", "Verdana", "Tahoma", "Trebuchet MS", "Times New Roman", "Georgia", "Courier New"]
    let fontChoice = fonts[clicks];
    let color = 'white';

    fontChoice = 'Georgia'


    x = canvas.width / 2;
    y = canvas.height / 2;
    fontSize = 40;
    color = "deeppink";//`hsl(${(frames * 50) % 360}, 100%, 70%)`;

    

    context.font = `${fontSize}px ${fontChoice}`;
    context.textAlign = "center";
    context.textBaseline = "middle";

    context.strokeStyle = color;
    
    context.strokeText(controlsMsgDes, x, y-50, canvas.width);
    context.strokeText(controlsMsgMob, x, y+50, canvas.width);

    // context.fillStyle = `black`;
    // context.fillText(message, x, y);
}

