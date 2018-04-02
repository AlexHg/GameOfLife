void jsonf() {
  JSONObject json = loadJSONObject("patterns.json");
  JSONArray patterns = json.getJSONArray("patterns");
  
  
  int patternSize = patterns.size();
  for(int p = 0; p < patternSize; p++){
    JSONObject pattern = patterns.getJSONObject(p);
    String name = pattern.getString("name");
    JSONArray structure = pattern.getJSONArray("structure");
    println(name);  
    
    JSONArray firstRow = structure.getJSONArray(0);
    int rowSize = structure.size();
    int colSize = firstRow.size();
    
    println(colSize+"x"+rowSize);
    
    
    for(int i = 0; i < rowSize; i++){
      JSONArray row = structure.getJSONArray(i);
      String col = "";
      for(int j = 0; j < colSize; j++){
        int cell = row.getInt(j);
        col += str(cell)+",";
      }
      println(col);
    }
    println();
  }  
}
