// INITAL VARIABLE DECLARATION FOR CANVAS ELEMENT
var canvas = document.getElementById("canvas");
    context = canvas.getContext("2d"),
    
    snakeBlockSize = 20,  // the size of grid blocks
    gameSpaceWidth = Math.floor(window.innerWidth / snakeBlockSize) * snakeBlockSize,    // adjusted width to fit grid
    gameSpaceHeight = Math.floor(window.innerHeight / snakeBlockSize) * snakeBlockSize,  // adjusted height to fit grid
    
    canvas.width = gameSpaceWidth,
    canvas.height = gameSpaceHeight,

    ticks = 0,  // measures how many frames have occurred since start of game
    trailTimer = 0,  // determines if a trail is left behind the snake
    starSpeedTimer = 0,  // determines if stars speed up for power-ups
    
    snkPos = [],  // this array will contain the snake's positions on the grid
    localHighScore = 0,  // tracks the player's high score
    food_positions = [],  // holds the positions of food/power-ups
    trail_positions = [],  // holds trail positions
    direction = '';  // the direction the snake moves
    
    let Stars = [],  // stores the current stars on the screen
    gameStarted = false,  // boolean to indicate game state
    score, scoreInc,
    shownScore = false,  // boolean to control score display updates
    speed = 0,  // speed of snake (ms wait between frames)
    powerupsOnScreen = 0,  // tracks the number of power-ups on screen
    darkmode = false,
    disableSnakeHead = true;

// Adjust canvas on page load and resize
function adjustCanvasSize() {
    gameSpaceWidth = Math.floor(window.innerWidth / snakeBlockSize) * snakeBlockSize;
    gameSpaceHeight = Math.floor(window.innerHeight / snakeBlockSize) * snakeBlockSize;
    canvas.width = gameSpaceWidth;
    canvas.height = gameSpaceHeight;

    context.beginPath();
    context.rect(0, 0, gameSpaceWidth, gameSpaceHeight);
    context.fillStyle = 'black';
    context.fill();
}

// Load high scores on page load
load_latest_hs();

// Load images for snake and power-ups
let snakeHeadImg = new Image();
snakeHeadImg.src = "pacman";

let star1Img = new Image();
star1Img.src = 'star1.png';

let star2Img = new Image();
star2Img.src = 'star2.png';

// Call adjustCanvasSize on load and resize
window.addEventListener('load', adjustCanvasSize);
window.addEventListener('resize', adjustCanvasSize);

// Ensure power-up positions align with grid
function generateFoodPosition() {
    let x = Math.floor(Math.random() * (gameSpaceWidth / snakeBlockSize)) * snakeBlockSize;
    let y = Math.floor(Math.random() * (gameSpaceHeight / snakeBlockSize)) * snakeBlockSize;
    return { x, y };
}
