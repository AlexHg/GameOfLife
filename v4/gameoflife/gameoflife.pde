int[][] searchF;
int cellSize= 1; // Tamaño de las celdas (PX)
float probabilityOfAliveAtStart = 30; // Probabilidad de iniciar vivo 

float interval = 1; // TIMER (1)
int lastRecordedTime = 0; // TIMER (2)

color azul = color(51, 121, 180);
color verde = color(0, 200, 0);
color rosa = color(254, 0, 129);
color amarillo = color(243, 197, 13);
color negro = color(0);

color alive = azul; // Color vivos
color dead = negro; // Color muertos/vacio

int[][] cells; // Matriz del juego
int[][] cellsBuffer; // Buffer del juego (Mientras se cambia la matriz principal, se usa esta) -Buffer to record the state of the cells and use this while changing the others in the interations

boolean pause = false; // Pausa
int dimX; //= width/cellSize;
int dimY; //= height/cellSize;

int aliveCont = 0;
int aliveProm = 0;
int aliveSum = 0;
int aliveIni = 0;
int aliveFin = 0;
int genCont = 0;
void setup() {
  

  //jsonf();
  dimX = 500;//width/cellSize;
  dimY = 500;//height/cellSize;
  
  println("Dimensiones de la matriz");
  println(dimX);
  println(dimY);
  size (1000, 1000);
  surface.setResizable(true);

  patternsCollection = new int[dimX][dimY][1000];
  subpat = new int[dimX][dimY][10];
  cells = new int[dimX][dimY]; //Inicia las matrices
  searchF = new int[dimX][dimY];
  pats = new int[dimX][dimY];
  cellsBuffer = new int[dimX][dimY]; //Inicia las matrices

  // Color de la grilla
  noStroke();

  noSmooth();

  //INICIA 
  for (int x=0; x<dimX; x++) {
    for (int y=0; y<dimY; y++) {
      float state = random (100);
      if (state > probabilityOfAliveAtStart) { 
        state = 0;
      }
      else {
        state = 1;
        aliveCont++;
      }
      cells[x][y] = int(state); 
      searchF[x][y] = 0;
    }
  }
  aliveIni = aliveCont;
  background(0); 
  
  //thread("searching");
}


void draw() {

  //Dibuja la grilla
  for (int x=0; x<dimX; x++) {
    for (int y=0; y<dimY; y++) {
      
      if (cells[x][y]==1) {
        fill(alive); // Vivo
        if(searchF[x][y]==1 && pats[x][y] > 3){ 
          fill(amarillo); // Vivo
         }
      }
      else {
        fill(dead); // Muerto
      }
      
      //dibujar patrones encontrados
      
      
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }

  //thread("searching");
  // Iteracion 
  if (millis()-lastRecordedTime>interval) {
    if (!pause) {
      iteration();
      searching();
      lastRecordedTime = millis();
    }
  }

  //mouseDrawing();
  
 
  
}



void iteration() { // iteracion
  // Si pasó la generación 1000, guarda el valor para mostrarlo
  if(genCont == 1000){
    aliveFin = aliveCont;
  }
  genCont++;
  
  // Guarda la grilla en un bufer 
  for (int x=0; x<dimX; x++) {
    for (int y=0; y<dimY; y++) {
      cellsBuffer[x][y] = cells[x][y];
    }
  }
  
  // Visita cada celda
  for (int x=0; x<dimX; x++) {
    for (int y=0; y<dimY; y++) {
      
      // Revisa los vecinos
      int neighbours = 0;
      for (int xx=x-1; xx<=x+1;xx++) {
        for (int yy=y-1; yy<=y+1;yy++) {  
          if (((xx>=0)&&(xx<dimX))&&((yy>=0)&&(yy<dimY))) { // verifica que no se pasa 
            if (!((xx==x)&&(yy==y))) { // revisa que se opera a la misma celda
              if (cellsBuffer[xx][yy]==1){
                neighbours ++; 
              }
            } 
          } 
        } 
      }
      
      // Revisa las reglas
      if (cellsBuffer[x][y]==1) {
        if (neighbours < 2 || neighbours > 3) {
          cells[x][y] = 0; 
          aliveCont--;
        }
      } 
      else if (neighbours == 3 ) {
          cells[x][y] = 1; 
          aliveCont++;
      } 
    }
  } 
} 
