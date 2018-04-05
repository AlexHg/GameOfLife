

int ssub = 2;
int sdimX = 500;
int sdimY = 500;
int[][][] subpat;
int[][] pats;
int patsC = 0;
int it = 0;
//Busqueda de coincidencias
void searching(){
  //Tamaño del subconjunto a estudiar
  
  if(it >= 10){
    int[][][] subpatBuffer = new int[dimX][dimY][10];
    int[][] searchFBuffer = new int[dimX][dimY];
    int[][] patsBuffer = new int[dimX][dimY];
    
    subpatBuffer = subpat;
    searchFBuffer = searchF;
    patsBuffer = pats;
    
    subpat = new int[dimX][dimY][10];
    searchF = new int[dimX][dimY];
    pats = new int[dimX][dimY];
    it = 1;
    for (int x=0; x<dimX; x++) {
      for (int y=0; y<dimY; y++) {
        if(pats[x][y] > 3){
          subpat[x][y][0] = subpatBuffer[x][y][0];
          searchF[x][y] = searchFBuffer[x][y];
          pats[x][y] = patsBuffer[x][y];
        }else{
          searchF[x][y] = 0;
          pats[x][y] = 0;
        }
      }
    }
    //pats = new int[100][2];
  }
  
  int xc = 0;
  int yc = 0;
  
   
  for (int x=0; x<sdimX; x+=ssub) {
    
    for (int y=0; y<sdimY; y+=ssub) {
      //print(x+","+y+"\n");
      String bin = "";
      for(int fx = 0; fx < ssub; fx++){
        for(int fy = 0; fy < ssub; fy++){
          bin += cells[x+fx][y+fy];
        }
        //println();
      }
      
      byte binDec = Byte.parseByte(bin,2);
      subpat[x][y][it] = binDec;
      for(int i = it-1; i > 0; i--){
        if(subpat[x][y][i] == binDec){
          if(binDec != 0 ){
            //println("Patron encontrado: "+binDec+" en "+x+","+y+" entre "+it+" y "+ i);
            for(int xi = 0; xi < ssub; xi++){
              for(int yi = 0; yi < ssub; yi++){
                
                searchF[x+xi][y+yi] = cells[x+xi][y+yi];
                pats[x+xi][y+yi]++;
              }
            }
            break;
          }
          
          //pats[patsC][patsC] = 1;
          //patsC++;
          
        }
      }
      //println(Byte.parseByte(bin,2));
      //println();
      
      yc++;
    }
    
    xc++;
  }
  it++;
  //println(it);
  
}
