
var flag            = 0;
var canvas_element  = document.querySelector("canvas#game-of-life");
var bench_start = false;
var canvas_config   = {
    cols: canvas_element.dataset.cols,
    rows: canvas_element.dataset.rows,
    frequency: canvas_element.dataset.frequency, 
    style: {
        width: canvas_element.width,
        height: canvas_element.height,
        cellcolor: canvas_element.dataset.cellcolor,
        fillcolor: canvas_element.dataset.fillcolor,
        zoom: canvas_element.dataset.zoom
    },
    rules: {
        superu: 2,
        superd: 3,
        born: 3,
    }
}, 
canvas          = canvas_element.getContext('2d'), 
cells           = [];

canvas.strokeStyle  = canvas_config.style.cellcolor;
canvas.fillStyle    = canvas_config.style.fillcolor;

function getParams(){
    canvas_element.width = canvas_config.style.width = document.controls.width.value;
    canvas_element.height = canvas_config.style.height = document.controls.height.value;

    canvas_config.cols = document.controls.cols.value;
    canvas_config.rows = document.controls.rows.value;
    canvas_config.frequency = document.controls.freq.value;
    canvas_config.style.cellcolor = document.controls.cellcolor.value;
    canvas_config.style.fillcolor = document.controls.fillcolor.value;
    canvas_config.style.zoom = document.controls.zoom.value;
    canvas_config.alive_rate = document.controls.rate.value;
    canvas_config.structure = document.controls.structure.value;
    canvas.strokeStyle  = canvas_config.style.cellcolor;
    canvas.fillStyle    = canvas_config.style.fillcolor;

    canvas_config.rules.superu = parseInt(document.controls.superu.value);
    canvas_config.rules.superd = parseInt(document.controls.superd.value);
    canvas_config.rules.born = parseInt(document.controls.born.value);
}

var alive_count = 0;
var generation = 0;
var dataPlot = [];
var suma = 0;
var promedio = 0;
var inig = 0;
var fing = 0;

function benchmark(){
    if(!bench_start){
        plotting();
        bench_start = true;
        setInterval(function(){
            document.querySelector("#alive .value").innerText = alive_count;
            document.querySelector("#generation .value").innerText = generation;
            dataPlot[dataPlot.length] = {y:alive_count};
            suma += alive_count;
            promedio = suma/dataPlot.length;
            document.querySelector("#promedio .value").innerText = parseInt(promedio);
            if(generation == 1000) document.querySelector("#fin .value").innerText = alive_count;
        },canvas_config.frequency);  
        setInterval(plotting,1000)
 
    }
}

function plotting(){
    var chart = new CanvasJS.Chart("chartContainer", {
        theme: "light2",
        axisY:{
            includeZero: false
        },
        data: [{        
            type: "line",       
            dataPoints: dataPlot
        }]
    });
    chart.render();
}



function start() {
    var antcell = [];
    alive_count = 0;
    generation = 0;
    dataPlot = [];
    suma = 0;
    promedio = 0;
    inid = true;
    flag = 1;
    inig = 0;
    fing = 0;
    if(cells.lenght > 0){
        antcell = cells;
    }

    setTimeout(function(){

        getParams();
        killcell(canvas_config.rows,canvas_config.cols);        
        
        initialState();
        inig = alive_count;
        document.querySelector("#inicio .value").innerText = inig;
        flag = 0;
        paint();
    },canvas_config.frequency*3)

    benchmark();
    
}


function killcell(rows, cols){
    for (var i=0; i < cols; i++) {
        cells[i] = [];
        for (var j=0; j < rows; j++) {
            cells[i][j] = 0;//muerto
        }
    }
}

function initialState(){
    var state1 = [];
    var glider_gun = [
        [2,6],[3,6],
        [2,7],[3,7],

                    [14,4],[15,4],
              [13,5],
        [12,6],
        [12,7],
        [12,8], 
              [13,9],   
                    [14,10],[15,10],   

               [17,5],
                      [18,6],
        [16,7],       [18,7],[19,7],
                      [18,8],
               [17,9],

                               [26,2],
                        [24,3],[26,3],
                [22,4],[23,4],
                [22,5],[23,5],
                [22,6],[23,6],
                        [24,7],[26,7],
                               [26,8],
            
            [36,4],[37,4],
            [36,5],[37,5],
    ];
    var sonar = [[31,19],[31,20],[31,21],[31,25],[31,26],[31,27],[33,17],[33,22],[33,24],[33,29],[34,17],[34,22],[34,24],[34,29],[35,17],[35,22],[35,24],[35,29],[36,19],[36,20],[36,21],[36,25],[36,26],[36,27],[38,19],[38,20],[38,21],[38,25],[38,26],[38,27],[39,17],[39,22],[39,24],[39,29],[40,17],[40,22],[40,24],[40,29],[41,17],[41,22],[41,24],[41,29],[43,19],[43,20],[43,21],[43,25],[43,26],[43,27],];

    var ppattern = [[13,24],[13,28],[15,23],[15,24],[15,25],[15,27],[15,28],[15,29],];

    var ppattern2 = [[13,14],[14,14],[15,14],[16,14],
                            [14,15],[15,15],[16,15],
                            [14,16],[15,16],[16,16],
                            [14,17],[15,17],[16,17]];

    var blinkers = [
                         [4,3],
                               [5,4],[6,4],
                    [3,5],[4,5],
                                [5,6],

                          [20,4],
                    [19,5],[20,5],[21,5],
                          [20,6],

                                [37,4],[38,4],
                                [37,5],[38,5],
                    [35,6],[36,6],
                    [35,7],[36,7],
                    ];
    console.log(sonar.length);
    switch(canvas_config.structure){
        case 'random':
            random(canvas_config.rows,canvas_config.cols); 
            break;
        case 'glider_gun':
            glider_gun.forEach(function(point) {
                cells[point[0]][point[1]] = 1;
                alive_count++;
            });
            break;
        case 'sonar':  
            sonar.forEach(function(point) {
                cells[point[0]][point[1]] = 1;
                alive_count++;
            });
            break;
        case 'blinkers':
            blinkers.forEach(function(point) {
                cells[point[0]][point[1]] = 1;
                alive_count++;
            });
            break;
        case 'ppattern':
            ppattern.forEach(function(point) {
                cells[point[0]][point[1]] = 1;
                alive_count++;
            });
            break;
        case 'ppattern2':
            ppattern2.forEach(function(point) {
                cells[point[0]][point[1]] = 1;
                alive_count++;
            });
            break;

    }
     
}

function random(rows, cols){
    for (var i=0; i < cols; i++) {
        for (var j=0; j < rows; j++) {
            var d = Math.random();
            if (d < (canvas_config.alive_rate/100)){
                cells[i][j] = 1;//vivo
                alive_count++;
            }
        }
    }
}


function update() {
    
    var result = [];
    
    function neighbours(x, y) {
        var neighbours = 0;
        
        function isAlive(x, y) {
            return cells[x] && cells[x][y] ? 1 : 0;
        }
        
        return (
            isAlive(x-1, y-1) + 
            isAlive(x-1, y) + 
            isAlive(x-1, y+1) + 
            isAlive(x, y-1) + 
            isAlive(x, y+1) + 
            isAlive(x+1, y-1) + 
            isAlive(x+1, y) + 
            isAlive(x+1, y+1)
        );

    }
    
    cells.forEach(function(row, x) {
        result[x] = [];
        row.forEach(function(cell, y) {
            var alive   = 0,
                cn      = neighbours(x, y);
            
            if (cell > 0) {
                alive = cn === canvas_config.rules.superu || cn === canvas_config.rules.superd ? 1 : 0;
                alive_count += (alive-1); 
            } else {
                alive = cn === canvas_config.rules.born ? 1 : 0;
                alive_count += alive;
            }
            /*
            if (cell > 0) {
                alive = cn === 7 ? 1 : 0;
                alive_count += (alive-1); 
            } else {
                alive = cn === 2 ? 1 : 0;
                alive_count += alive;
            }*/
            
            result[x][y] = alive;
        });
    });
    generation++;
    cells = result;
    
    paint();
}

function paint() {
    canvas.clearRect(0, 0, canvas_config.style.width, canvas_config.style.height);
    //console.log(cells);
    cells.forEach(function(row, x) {
        row.forEach(function(cell, y) {
            canvas.beginPath();
            canvas.rect(x*canvas_config.style.zoom, y*canvas_config.style.zoom, canvas_config.style.zoom, canvas_config.style.zoom);
            if (cell) {
                canvas.fill();
            } else {
                canvas.stroke();
            }
        });
    });
    setTimeout(function() {
        if(flag==0) 
            update();
    }, canvas_config.frequency);
    
}
