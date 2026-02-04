for (i=0; i<10; i++){
	console.log(Date.now())
}
console.log(Math.PI)

const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

// Create a 2D grid representing the game board
function createGrid(width, height) {
	let arr = []
	for (i=0;i<width;i++){
		let sub = []
		for (j=0;j<height;j++){
			sub.push(j==Math.round(height/2)&&i!=0?1:0)
		} 
		arr.push(sub)
	}
return arr;
  return Array.from({ length: height }, () =>
    Array.from({ length: width }, (index) => Math.random() < 0.5)
  );
}

// Display the grid in the terminal
function printGrid(grid) {
  console.clear();
  grid.forEach((row) => {
    console.log(row.map((cell) => (cell ? '■' : ' ')).join(''));
  });
}

// Calculate the next generation of the grid
function nextGeneration(grid) {
  const newGrid = grid.map((row) => row.slice()); // Deep copy

  for (let y = 0; y < grid.length; y++) {
    for (let x = 0; x < grid[y].length; x++) {
      const liveNeighbors = countLiveNeighbors(grid, x, y);

      // Apply the rules of the Game of Life
      if (grid[y][x]) {
        if (liveNeighbors < 2 || liveNeighbors > 3) {
          newGrid[y][x] = false;
        }
      } else {
        if (liveNeighbors === 3) {
          newGrid[y][x] = true;
        }
      }
    }
  }

  return newGrid;
}

// Count the number of live neighbors around a cell
function countLiveNeighbors(grid, x, y) {
  let count = 0;
  for (let i = -1; i <= 1; i++) {
    for (let j = -1; j <= 1; j++) {
      if (i === 0 && j === 0) continue; // Skip the cell itself

      const neighborX = (x + i + grid[0].length) % grid[0].length;
      const neighborY = (y + j + grid.length) % grid.length;

      if (grid[neighborY][neighborX]) {
        count++;
      }
    }
  }
  return count;
}

// Start the simulation
function runSimulation(grid, interval) {
  printGrid(grid);

  const timer = setInterval(() => {
    grid = nextGeneration(grid);
    printGrid(grid);
  }, interval);

  rl.question('Press Enter to stop the simulation...', () => {
    clearInterval(timer);
    rl.close();
  });
}

// Set up the game
const width = process.stdout.columns;
const height = process.stdout.rows - 3; // Consider prompt line
const grid = createGrid(width, height);

runSimulation(grid, 100); // Adjust interval for speed
