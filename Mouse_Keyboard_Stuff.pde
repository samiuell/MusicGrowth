// Spawns a 'show' wherever clicked 
void mousePressed() {

  try {
    int a = int((mouseX - padding)/cellSize);   
    int b = int((mouseY - padding)/cellSize); 
    xBand = mouseX;
    yBand = mouseY; 
    
    cellCol[b][a] = artist; 
    closeShow(b,a);
    show = true; 
  }
  
  //If clicking outside of the boarder do nothing
  catch(IndexOutOfBoundsException e) {

  }
 
}


//Pause and play 
void keyPressed() {
  
  if(key == ' ') {
    
    pause++;
    
    if(pause % 2 != 0)
      noLoop(); 
      
    else
      loop(); 
      
  }
}
