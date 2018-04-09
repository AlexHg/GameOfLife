

int ssub = 4;
int sdimX = 500;
int sdimY = 500;
int[][][] subpat;
int[][][] patternsCollection;
int[][] pats;
int patsC = 0;
int it = 0;
int itpc = 0;
String patternsCollectionOut = "";

int patSum = 0;
int patProm = 0;
int patFin = 0;

//Busqueda de coincidencias
void searching(){
  //Tamaño del subconjunto a estudiar
  if(itpc >= 1000 ){
    println(patternsCollectionOut);
    itpc = 0;
    patternsCollection = new int[dimX][dimY][1000];
  }
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
        if(patsBuffer[x][y] > 3 ){
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
  
  
   // Recorre la grilla en bloques de tamaño "ssubxssub"
  for (int x=0; x<sdimX; x+=ssub) {
    
    for (int y=0; y<sdimY; y+=ssub) {
      String bin = "";
      //Transforma el bloque en un numero binario
      for(int fx = 0; fx < ssub; fx++){
        for(int fy = 0; fy < ssub; fy++){
          bin += cells[x+fx][y+fy];
        }
      }
      
      //Conversion binario a decimal
      int binDec = unbinary(bin);
      
      //Guarda el valor decimal obtenido 
      subpat[x][y][it] = binDec;
      patternsCollection[x][y][itpc] = binDec;
      
      //Recorre las generaciones en busqueda de patrones
      for(int i = it-1; i > 0; i--){
        if(subpat[x][y][i] == binDec){
          if(binDec != 0 ){
            
            for(int xi = 0; xi < ssub; xi++){
              for(int yi = 0; yi < ssub; yi++){
                
                searchF[x+xi][y+yi] = cells[x+xi][y+yi];
                pats[x+xi][y+yi]++;
              }
            }
            break;// Si encuentra coincidencia rompe con la busqueda del patron
          }
          
          //pats[patsC][patsC] = 1;
          //patsC++;
          
        }
      }


    }

  }
  int patcont = 0;
  for(int x=0; x<sdimX; x+=ssub) {
    
    for (int y=0; y<sdimY; y+=ssub) {
      int itpc2 = itpc-10;
      if(itpc2 < 0){
        itpc2 = 0;
      }
      
      int dontcont = 0;
      if(patternsCollection[x][y][itpc] == 0){
        dontcont += 10;
      }
      for(int dc = itpc2; dc < itpc; dc++){
        if(patternsCollection[x][y][dc] == patternsCollection[x][y][itpc]){
          dontcont++;
        }
        if(patternsCollection[x][y][dc] == patternsCollection[x][y][dc+1]){
          dontcont++;
        }
      }
      
      if(searchF[x][y]==1 && pats[x][y] > 3 && dontcont < 4){
        patcont++;
        patsC++;
        patSum += patcont;
        patProm = patsC/genCont;
        //print("[");
        int ini = itpc-10;
        if(ini < 0){
          ini = 0;
        }
        for (int z=ini; z<itpc; z++) {
           //print(patternsCollection[x][y][z]+",");
        }
        //print("]");
        //println();
      }
      
    }
    
  }

  it++;
  itpc++;
  
 
  println("Generacion: "+genCont+";");
  println("Nuevos patrones encontrados: "+patcont+"; Tendencia (patrones): "+patProm+";");
  println("Inicio: "+aliveIni+"; Con vida: "+aliveCont+"; Tendencia (vivos): "+aliveProm+";");
  if(aliveFin != 0){
     println("A las 1000 generaciones: "+aliveFin);
  }
  println("=================================================");
  
}
