void keyPressed() {
  // Reinicio 'tecla rR'
  if (key=='r' || key == 'R') {
    for (int x=0; x<dimX; x++) {
      for (int y=0; y<dimY; y++) {
        float state = random (100);
        if (state > probabilityOfAliveAtStart) {
          state = 0;
        }
        else {
          state = 1;
        }
        cells[x][y] = int(state);
      }
    }
  }
  // Pausa 'barra espaciadora'
  if (key==' ') { 
    pause = !pause;
  }
  // Finalizar 'tecla fF'
  if (key=='f' || key == 'F') { 
    for (int x=0; x<dimX; x++) {
      for (int y=0; y<dimY; y++) {
        cells[x][y] = 0; 
      }
    }
  }
}
