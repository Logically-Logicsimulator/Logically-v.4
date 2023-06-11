class Nicht {
  
  int xPos;
  int yPos;
  int xSize;
  int ySize;
  
  int mausX;
  int mausY;
  
  int multiplierX;
  int multiplierY;
  
  boolean ausgewählt = false;
  boolean sichtbar = false;
  
  Punkt eingang = new Punkt();
  Punkt ausgang = new Punkt();
  
  
  //########################################################################################################################
  
  
  //Zeichnen
  void Zeichnen() {
    
    eingang.Zeichnen();
    ausgang.Zeichnen();
    
    if(ausgewählt) {
      
      multiplierX = int((mouseX - mausX) / 20);
      multiplierY = int((mouseY - mausY) / 20);
      
      xPos = 20 * multiplierX;
      yPos = 20 * multiplierY;
      
      if(xPos > 320) {
        sichtbar = true;
        eingang.xPos = xPos;
        eingang.yPos = yPos + 20;
        ausgang.xPos = xPos + 40;
        ausgang.yPos = yPos + 20;
      } else {
        sichtbar = false;
        eingang.xPos = 340;
        eingang.yPos = yPos + 20;
        ausgang.xPos = 340;
        ausgang.yPos = yPos + 20;
      }
    }
    
    if(sichtbar) {
      
      fill(255);
      strokeWeight(2);
      
      if(ausgewählt) {
        stroke(100);
      } else {
        stroke(0);
      }
      
      rect(xPos + 6, yPos + 5, 20, 30);
      ellipse(xPos + 30, yPos + 20, 8, 8);
      line(xPos, yPos + 20, xPos + 6, yPos + 20);
      line(xPos + 34, yPos + 20, xPos + 40, yPos + 20);
      fill(0);
      
      
      textAlign(CENTER, CENTER);
      textSize(15);
      
      if(ausgewählt) {
        fill(100);
      } else {
        fill(0);
      }
      
      text("1", xPos + 16, yPos + 20 - textAscent()* 0.15);
      
    }
  }
  
  
  //########################################################################################################################
  
  
  //Operation
  void Operation() {
    if(eingang.an) {
      ausgang.an = false;
    } else {
      ausgang.an = true;
    }
  }
  
  
  //########################################################################################################################
  
  
  //Mouse Pressed
  void mousePressed() {
    if(ausgewählt) {
      ausgewählt = false;
      bewegungsmod = false;
      direktVerbindung();
    } else {
      if(mouseX >= xPos + 6 & mouseY >= yPos + 5 & mouseX <= xPos + 26 & mouseY <= yPos + 35) {
        ausgewählt = true;
        mausX = mouseX - xPos;
        mausY = mouseY - yPos;
        bewegungsmod = true;
      }
    }
  }
}
