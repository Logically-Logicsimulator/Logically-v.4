class Punkt {
  
  int xPos;
  int yPos;
  
  boolean ausgewählt = false;
  boolean verbunden = false;
  boolean an = false;
  
  
  //########################################################################################################################
  
  
  //Zeichnen
  void Zeichnen() {
    if(ausgewählt & !verbunden & !bewegungsmod) {
      stroke(0);
      strokeWeight(1);
      line(xPos - 10, yPos - 10, xPos + 10, yPos - 10);
      line(xPos + 10, yPos - 10, xPos + 10, yPos + 10);
      line(xPos + 10, yPos + 10, xPos - 10, yPos + 10);
      line(xPos - 10, yPos + 10, xPos - 10, yPos - 10);
    }
  }
  
  
  //########################################################################################################################
  
  
  //Mouse Moved
  void mouseMoved() {
    if(mouseX >= xPos - 10 & mouseY >= yPos - 10 & mouseX <= xPos + 10 & mouseY <= yPos + 10 & !verbunden & !bewegungsmod) {
      ausgewählt = true;
    } else {
      ausgewählt = false;
    }
  }
}
