
let helloTimes = 3


const convertToBinary = (decimal) => {
    let binary = (decimal >>> 0).toString(2); // Convert to binary
    const byteLength = 8; // Each byte consists of 8 bits
    const paddedLength = Math.ceil(binary.length / byteLength) * byteLength; // Ensure binary is padded to the nearest byte
    binary = binary.padStart(paddedLength, '0'); // Pad with leading zeros if necessary

    // Insert space between each byte
    const bytes = [];
    for (let i = 0; i < paddedLength; i += byteLength) {
        bytes.push(binary.slice(i, i + byteLength));
    }
    return bytes.join(' ');
}

let count = -100

function delayedLoop(delay) {
    let i = 0;
    setInterval(() => {
        console.log(convertToBinary(i) + " - base10: " + i)
        i++;
        if (i % 10 == 0) {
            // console.log(delay);
            delay = delay > 0 ? delay - 1 : 0;
        }
    }, delay);
}

// Example usage:
delayedLoop(100); 