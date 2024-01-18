//A Musician's Journey in Growth 
//Sam Gupta
//ICS4UI-01

//***** VARIABLES CHANGE AS YOU WISH :) *****

int n = 50; //How many cells in each row/column
String setting = "city"; //Growth within "city", "rural", "random", or "custom" 
int blinksPerSecond = 3; //Framerate
boolean gridlines = false; //Show gridlines

//What colour represents each cell state
color hater = color(224, 109, 105); //red default
color fan = color(107, 170, 214); //blue default
color neutral = color(51, 35, 66); //purple default
color artist = color(80, 180, 120); //green default

//If "custom" setting (Maybe keep them low...) 

  //Choose percent of fans/haters in first gen 
float custPercentFan = 0.003; 
float custPercentHater = 0.001; 

  //Percent chance of fans/haters spreading
float custSpreadFan = 0.03;
float custSpreadHater = 0.03; 
  

//***** NECESSARY VARIABLES *****

int padding = 50; 
int numFans = 0; 
int numHaters = 0;
int pause = 0; 
int xSpeed;
int ySpeed; 
int cellSize; 
float percentFan; 
float percentHater; 
float fanSpread; 
float haterSpread; 
float xBand;
float yBand; 


boolean show = false; 
int[][] nextCells = new int[n][n];
color[][] cellCol = new color[n][n];


void setup() {
  size(800,800); 
  frameRate(blinksPerSecond); 
  cellSize = (width - (2 * padding)) / n;
 
 //City
 if(setting == "city") {
   percentFan = 0.005; 
   percentHater = 0.002;
   fanSpread = 0.05; 
   haterSpread = 0.04;
}

 //Rural
 else if(setting == "rural") {
   percentFan = 0.0025; 
   percentHater = 0.001; 
   fanSpread = 0.02;
   haterSpread = 0.02;
}
  
  //Custom 
  else if(setting == "custom") {
   percentFan = custPercentFan; 
   percentHater = custPercentHater;
   fanSpread = custSpreadFan; 
   haterSpread = custSpreadHater; 
  }
  
  //Random
  else {
    percentFan = random(0.003, 0.005); 
    percentHater = random(0.001, 0.003); 
    fanSpread = random(0.02, 0.06); 
    haterSpread = random(0.01, 0.05); 
    
}
 
 setFirstPositions();
 
}


void draw() {

  background(200); 
  
  numFans = 0; 
  numHaters = 0; 
  
  float y = padding; 
  
  for(int i=0; i < n; i++) {
    for(int j=0; j < n; j++) {
      
      if(cellCol[i][j] == fan)
        numFans++; 
      
      else if(cellCol[i][j] == hater)
        numHaters++;
      
      float x = padding + j*cellSize;
      
      fill(cellCol[i][j]);
      
      if(gridlines == false)
        stroke(cellCol[i][j]);
      else
        stroke(0); 
        
      rect(x, y, cellSize, cellSize);
      
    }
    
    y += cellSize;
  }
  
  fill(0); 
  
  //Text stuff
  String fanStat = "Fans: " + numFans;
  String haterStat = "Haters: " + numHaters; 
  String mode = "Mode: " + setting;
  textFont(createFont("Times New Roman", 24));
  text(fanStat, 50, 25); 
  text(haterStat, 175, 25); 
  text("Press space to pause/play animation", 400, 25); 
  text("Click to 'perform' a show", 50, 775);
  text(mode, 600, 775); 
  
  nextGen();
  copyGen();

}


//Sets starting colours 
void setFirstPositions() {
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {

      float colPercent = random(0, 1);

      if(colPercent <= percentHater) 
        cellCol[i][j] = hater; 

      else if(colPercent <= percentFan) 
        cellCol[i][j] = fan; 

      else  
        cellCol[i][j] = neutral;

    }
  }  
}


void copyGen() {
  
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++)  {
      
      cellCol[i][j] = nextCells[i][j];

    }
  }
}


void nextGen() {
  
  //Reseting values
  nextCells = new color[n][n];
  int xSpeed = 0; 
  int ySpeed = 0; 

  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {

      xSpeed = round(random(-1,1));
      ySpeed = round(random(-1,1));                       
      
      //Evolutions
      if(cellCol[i][j] == fan) { 
      
        try {
          
          int iNext = i + ySpeed;  
          int jNext = j + xSpeed; 
          
          if(nextCells[iNext][jNext] != fan && nextCells[iNext][jNext] != hater && nextCells[iNext][jNext] != artist)
            nextCells[iNext][jNext] = fan; 

          if(nextCells[i][j] != hater && nextCells[i][j] != fan && nextCells[i][j] != artist)
            nextCells[i][j] = neutral;
              
          }

          catch(Exception e) { 
            nextCells[i][j] = neutral;

          }
        }

      else if(cellCol[i][j] == hater) {
        
        try {
          
          int iNext = i - ySpeed; 
          int jNext = j - xSpeed;

          if(nextCells[iNext][jNext] != fan && nextCells[iNext][jNext] != hater && nextCells[iNext][jNext] != artist)
            nextCells[iNext][jNext] = hater; 

          if(nextCells[i][j] != hater && nextCells[i][j] != fan && nextCells[i][j] != artist)
            nextCells[i][j] = neutral; 

         }

        catch(Exception e) {
           nextCells[i][j] = neutral; 
 
        }
      }
      
      else if(cellCol[i][j] == artist) 
        nextCells[i][j] = artist; 
      
      else if(cellCol[i][j] == neutral && nextCells[i][j] != hater && nextCells[i][j] != fan && nextCells[i][j] != artist) {
        nextCells[i][j] = neutral;

      }
       
      spread(i,j);
      
    }
  }
}
