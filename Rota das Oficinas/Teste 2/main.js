const canvas = document.getElementById("canvas");
const context = canvas.getContext("2d");
const size = 600;
const scale = 6;
const resolution = size / scale;

let cells;

setup();
randomCells();
drawCells();

function setup() {
    canvas.width = size;
    canvas.height = size;
    context.scale(scale, scale);
    context.fillStyle = "white";
    cells = createCells();
}

function createCells() {
    let arr = new Array(resolution);
    for (let x = 0; x < resolution; x++) {
        let columns = new Array(resolution);
        for (let y = 0; y < resolution; y++) {
            columns[y] = false;
        }
        arr[x] = columns;
    }
    return arr;
}

function randomCells() {
    for (let y = 0; y < resolution; y++) {
        for (let x = 0; x < resolution; x++) {
            if (Math.random() < 0.25) {
                cells[x][y] = true;
            }
        }
    }
}

function drawCells() {
    context.fillStyle = "black";
    context.fillRect(0, 0, resolution, resolution);
    context.fillStyle = "white";

    for (let y = 0; y < resolution; y++) {
        for (let x = 0; x < resolution; x++) {
            if (cells[x][y]) {
                context.fillRect(x, y, 1, 1);
            }
        }
    }
}

function step() {
    let newCells = createCells();
    for (let y = 0; y < resolution; y++) {
        for (let x = 0; x < resolution; x++) {
            const neighbours = getNeighbourCount(x, y);
            if (cells[x][y] && neighbours >= 2 && neighbours <= 3) newCells[x][y] = true;
            else if (!cells[x][y] && neighbours === 3) newCells[x][y] = true;
        }
    }
    cells = newCells;
    drawCells();
}

function getNeighbourCount(row, column) {
    let count = 0;
    for (let y = -1; y < 2; y++) {
        for (let x = -1; x < 2; x++) {
            if (x == 0 && y == 0) continue;
            if (row + x < 0 || row + x > resolution - 1) continue;
            if (column + y < 0 || column + y > resolution - 1) continue;
            if (cells[row + x][column + y]) count++;
        }
    }
    return count;
}

let time = 500;
let myTime = [];

function Play() {
    if(myTime){
        Pause();
    }
    console.log(time);
    myTime.push(setInterval(step, time));
}

function Pause() {
    myTime.forEach(function (item) {
        clearInterval(item);
    })
}

function Accelerate() {
    if (time > 50) time -= 50;
    else if (time > 5) time -= 5;
    Play();
}

function slowDown() {
    if (time > 50) time += 50;
    else if (time >= 5) time += 5;
    Play();
}

function Reset() {
    Pause();
    randomCells();
    drawCells();
}