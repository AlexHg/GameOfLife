void mouseDrawing() {
  // Agrega celdas vivas al clickear en ella solo si esta en pausa
  if (pause && mousePressed) {

    int xCellOver = int(map(mouseX, 0, width, 0, width/cellSize));
    xCellOver = constrain(xCellOver, 0, width/cellSize-1);
    int yCellOver = int(map(mouseY, 0, height, 0, height/cellSize));
    yCellOver = constrain(yCellOver, 0, height/cellSize-1);


    if (cellsBuffer[xCellOver][yCellOver]==1) { // Si la celda esta viva
      cells[xCellOver][yCellOver]=0; 
      fill(dead); 
    }
    else { // si no
      cells[xCellOver][yCellOver]=1;
      fill(alive); 
    }
  } 
}
