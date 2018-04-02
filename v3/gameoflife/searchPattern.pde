
int[][] coinc = new int[width*height/cellSize][2];
int searchPattern(int px, int py) {
    
  JSONObject json = loadJSONObject("patterns.json");
  JSONArray patterns = json.getJSONArray("patterns");
  
  searchVisited[px][py] = 1;
  
  int patternSize = patterns.size();
  for(int p = 0; p < patternSize; p++){
    JSONObject pattern = patterns.getJSONObject(p);
    String name = pattern.getString("name");
    JSONArray structure = pattern.getJSONArray("structure");
    //println(name);  
    
    JSONArray firstRow = structure.getJSONArray(0);
    int rowSize = structure.size();
    int colSize = firstRow.size();
    
    //println(colSize+"x"+rowSize);
    
    int coincidence = 0;
    
    for(int i = 0; i < rowSize; i++){
      JSONArray row = structure.getJSONArray(i);
      String col = "";
      int rowCoincidence = 1;
      for(int j = 0; j < colSize; j++){
        int cell = row.getInt(j);
        if(px+i < width/cellSize && py+j < height/cellSize){
          //println(px+i);
          //println(py+j);
          if(cells[px+i][py+j] != cell){
            rowCoincidence = 0;
            break;
          }else{
            //coinc[coinc.length][0] = px+i;
            //coinc[coinc.length][1] = py+j;
            searchVisited[px+i][py+j] = 1;
            
          }
        }
        col += str(cell)+",";
      }
      if(rowCoincidence == 0){
        break;
      }
      //println(col);
    }
    
    //println();
    if(coincidence == 1){
      println(name);
      break; // SI COINCIDIÓ CON UN PATRÓN, DEJA DE BUSCAR;
    }
  }  
  return 1;
}
