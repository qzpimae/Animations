// Swipe control variables
let touchStartX = 0;
let touchStartY = 0;
let touchEndX = 0;
let touchEndY = 0;

document.addEventListener('keydown', keyDownHandler, false);
document.addEventListener('touchstart', handleTouchStart, false);
document.addEventListener('touchend', handleTouchEnd, false);

// Handle keyboard input for direction
function keyDownHandler(event) {
    switch (event.code) {
        case "Space":
            if (!gameStarted) {
                gameStarted = true;
                startGame();
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
        startGame();
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
        if (diffX > 0) {
            // Swipe right
            direction = 'r';
        } else {
            // Swipe left
            direction = 'l';
        }
    } else {
        // Vertical swipe
        if (diffY > 0) {
            // Swipe down
            direction = 'd';
        } else {
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
