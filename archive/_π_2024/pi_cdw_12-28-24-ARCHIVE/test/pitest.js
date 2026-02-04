const testDiv = document.getElementById("pitest");
const canvas = document.getElementById("piCan");
const context = canvas.getContext('2d');

context.translate(canvas.width/2, canvas.height/2)
context.rotate(Math.PI)



const pi = "31415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132823066470938446095505822317253594081284811174502841027019385211055596446229489549303819644288109756659334461284756482337867831652712019091456485669234603486104543266482133936072602491412737245870066063155881748815209209628292540917153643678925903600113305305488204665213841469519415116094330572703657595919530921861173819326117931051185480744623799627495673518857527248912279381830119491298336733624406566430860213949463952247371907021798609437027705392171762931767523846748184676694051320005681271452635608277857713427577896091736371787214684409012249534301465495853710507922796892589235420199561121290219608640344181598136297747713099605187072113499999983729780499510597317328160963185950244594553469083026425223082533446850352619311881710100031378387528865875332083814206171776691473035982534904287554687311595628638823537875937519577818577805321712268066130019278766111959092164201989";


const urlParams = new URLSearchParams(window.location.search);

const safeMode = parseInt(urlParams.get('safe')) || 0;

// Index of the digit currently being checked
let curDigit = 0;

// Display message
const piMsg = document.createElement("p");
const displayMsg = "How much of π do you know";
let maxDigit = 0;
piMsg.innerText = displayMsg + "? Find out below";

// display correct digits of pi
const piDis = document.createElement("p");
piDis.innerText = "*";
piDis.id = "piDis";

const piPad = document.createElement("div");
piPad.id = "piPad";

for (let i = 1; i <= 9; i++) {
  const numIn = document.createElement("button");
  numIn.innerText = i;
  numIn.onclick = () => handleButtonClick(i);
  piPad.appendChild(numIn);
}

const zeroButton = document.createElement("button");
zeroButton.innerText = "0";
zeroButton.onclick = () => handleButtonClick(0);
piPad.appendChild(zeroButton);

// keyboard inputs
document.addEventListener("keydown", (event) => {
  const key = event.key; 
  if (!isNaN(key) && key >= 0 && key <= 9) {
    handleButtonClick(parseInt(key)); // call the same function used for buttons
  }
});


function handleButtonClick(num) {
  // console.log(num);
  if (num == pi[curDigit]) {
    const inTxt = piDis.innerText;
    piDis.innerText = inTxt == "*" ? "3." : piDis.innerText + num;
    curDigit++;
    piMsg.innerText = displayMsg + ": " + curDigit;
    renderPiCircle()
    if (curDigit > maxDigit) {
      maxDigit++;
    } 
  } else if (!safeMode) {
    piDis.innerText = "*";
    curDigit = 0;
  }
}

function renderPiCircle () {
  
  
    if (curDigit===1) {
      context.fillStyle = 'black'
    } else context.fillStyle =`hsla(0,0%,0%, 0.25)`
    context.fillRect(-canvas.width, -canvas.height, canvas.width*2, canvas.height*2);
    
    // context.push()
    for (let i =  0; i < curDigit; i++) {

      const x1 = Math.sin(Math.PI*2 * (i-1) / curDigit) * canvas.width/4
      const y1 = Math.cos(Math.PI*2 * (i-1) / curDigit) * canvas.height/4
      const x2 = Math.sin(Math.PI*2 * (i) / curDigit) * canvas.width/4
      const y2 = Math.cos(Math.PI*2 * (i) / curDigit) * canvas.height/4

      context.strokeStyle = 'white';
      context.lineWidth = .8
      context.beginPath()
      context.moveTo(x1,y1)
      context.lineTo(x2,y2)
      context.stroke()

      const dotColor = mapNumber(i, 0, curDigit, 0, 333)
      context.fillStyle = `hsla(${dotColor},100%,70%, 0.5)`;                  
      context.beginPath()
      context.arc(x1, y1, 2, 0, Math.PI*2)
      context.fill()
    }

}

function mapNumber (number, min1, max1, min2, max2) {
  return ((number - min1) * (max2 - min2) / (max1 - min1) + min2);
};

// Append elements to DOM
testDiv.appendChild(piMsg);
testDiv.appendChild(piDis);
testDiv.appendChild(piPad);
