int[][] searchVisited;
int cellSize = 5; // Tamaño de las celdas (PX)
float probabilityOfAliveAtStart = 15; // Probabilidad de iniciar vivo 

int interval = 1; // TIMER (1)
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

void setup() {
  //jsonf();
  println("Dimensiones de la matriz");
  println(width/cellSize);
  println(height/cellSize);
  size (1580, 700);

  cells = new int[width/cellSize][height/cellSize]; //Inicia las matrices
  searchVisited = new int[width/cellSize][height/cellSize];
  cellsBuffer = new int[width/cellSize][height/cellSize]; //Inicia las matrices

  // Color de la grilla
  stroke(48);

  noSmooth();

  //INICIA 
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      float state = random (100);
      if (state > probabilityOfAliveAtStart) { 
        state = 0;
      }
      else {
        state = 1;
      }
      cells[x][y] = int(state); 
      searchVisited[x][y] = 0;
    }
  }
  background(0); 
}


void draw() {

  //Dibuja la grilla
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      
      if (cells[x][y]==1) {
        fill(alive); // Vivo
      }
      else {
        fill(dead); // Muerto
      }
      
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
  
  // Iteracion 
  if (millis()-lastRecordedTime>interval) {
    if (!pause) {
      iteration();
      lastRecordedTime = millis();
    }
  }

  mouseDrawing();
  
  // Re dibuja la grilla buscando coincidencias
  //searching();
  thread("searching");
  
}

//Busqueda de coincidencias
void searching(){
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        if(searchVisited[x][y] != 1){ // si no fue visitado aun
          searchPattern(x, y);
        }
      }
    }
  }



void iteration() { // iteracion
  // Guarda la grilla en un bufer 
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      cellsBuffer[x][y] = cells[x][y];
    }
  }

  // Visita cada celda
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      
      // Revisa los vecinos
      int neighbours = 0;
      for (int xx=x-1; xx<=x+1;xx++) {
        for (int yy=y-1; yy<=y+1;yy++) {  
          if (((xx>=0)&&(xx<width/cellSize))&&((yy>=0)&&(yy<height/cellSize))) { // verifica que no se pasa 
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
        }
      } 
      else if (neighbours == 3 ) {
          cells[x][y] = 1; 
      } 
    }
  } 
} 
