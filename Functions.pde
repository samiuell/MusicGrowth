//Cells neighbouring a show have a 30% of becoming a fan and 10% chance of becoming a hater 
void closeShow(int i, int j) {

  for(int a = -1; a <= 1; a++) {  
    for(int b = -1; b <= 1; b++) { 

      float chance = random(0,1); 

      try {

        if(chance <= 0.1)
          cellCol[i+a][j+b] = hater; 
        
        else if(chance <= 0.3)
          cellCol[i+a][j+b] = fan;               

      }

      catch(IndexOutOfBoundsException e) {

      }
    }
  }
}


//Both fans and haters grow through 'word of mouth' 
void spread(int i, int j) {
  
  for(int a = -1; a <= 1; a++) {  
    for(int b = -1; b <= 1; b++) { 

      float chance = random(0,1); 
      
      if(cellCol[i][j] == hater) {

        try {

          if(chance <= haterSpread) 
            cellCol[i+a][j+b] = hater; 

        }

        catch(IndexOutOfBoundsException e) {

         }
      }
      
      if(cellCol[i][j] == fan) {

        try {

          if(chance <= fanSpread) 
            cellCol[i+a][j+b] = fan; 

        }

        catch(IndexOutOfBoundsException e) {

        }
      }
    }
  }
}


//Counts total number of fans 
int countFan(int i, int j) {
  
  if(cellCol[i][j] == fan)
    numFans++; 
 
  return numFans; 
  
}


//Counts total number of haters
int countHater(int i, int j) {
  
  if(cellCol[i][j] == hater); 
    numHaters++; 

  return numHaters; 
  
}
