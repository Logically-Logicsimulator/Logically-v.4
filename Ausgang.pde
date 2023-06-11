class Ausgang {
  
  int xPos;
  int yPos; 
  int mausX;
  int mausY;
  int multiplierX;
  int multiplierY;
  
  boolean ausgewählt = false;
  boolean sichtbar = false;
  
  Textfeld text = new Textfeld();
  Punkt eingang = new Punkt();
  
  
  //########################################################################################################################
  
  
  //Zeichnen
  void Zeichnen() {
    
    if(ausgewählt) {
      
      multiplierX = int((mouseX - mausX) / 20);
      multiplierY = int((mouseY - mausY) / 20);
      
      xPos = 20 * multiplierX;
      yPos = 20 * multiplierY;
      
      if(xPos > 320) {
        sichtbar = true;
        eingang.xPos = xPos;
        eingang.yPos = yPos + 20;
      } else {
        sichtbar = false;
        eingang.xPos = 340;
        eingang.yPos = yPos + 20;
      }
    }
    
    if(sichtbar) {
      
      eingang.Zeichnen();
      
      fill(255);
      strokeWeight(2);
      
      if(ausgewählt) {
        stroke(100);
      } else {
        stroke(0);
      }
      
      ellipse(xPos + 20, yPos + 20, 30, 30);
      line(xPos, yPos + 20, xPos + 5, yPos + 20);
      
      strokeWeight(1);
      
      if(ausgewählt) {
        fill(100);
      } else {
        if(eingang.an) {
          fill(0, 200, 0);
        } else {
          fill(0, 100, 0);
        }
      }
      
      ellipse(xPos + 20, yPos + 20, 22, 22);
      
      fill(255);
      textSize(15);
      textAlign(CENTER, CENTER);
      
      if(eingang.an) {
        text("1", xPos + 20, yPos + 20 - textAscent() * 0.15);
      } else {
        text("0", xPos + 20, yPos + 20 - textAscent() * 0.15);
      }
      
      strokeWeight(0);
      if(ausgewählt) {
        fill(100);
      } else {
        fill(0);
      }
      
      textSize(20);
      textAlign(LEFT, CENTER);
      
      text.xPos = xPos + 40;
      text.yPos = yPos + 20;
      text.Zeichnen();

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
      if(mouseX >= xPos + 5 & mouseY >= yPos + 5 & mouseX <= xPos + 35 & mouseY <= yPos + 35) {
        ausgewählt = true;
        mausX = mouseX - xPos;
        mausY = mouseY - yPos;
        bewegungsmod = true;
      } else {
        textSize(20);
        if(mouseX >= xPos + 40 & mouseY >= yPos + 20 - textAscent() / 2 & mouseX <= xPos + 40 + textWidth(text.inhalt) & mouseY <= yPos + 20 + textAscent() / 2) {
          text.ausgewählt = true;
          text.originalInhalt = text.inhalt;
          skip = true;
        }
      }
    }
  }
  
  
  //########################################################################################################################
  
  
  //Key Pressed 
  void keyPressed() {
    textSize(20);
    text.zeichenAnzahl = 4;
    text.textlänge = 0;
    text.freiraum = false;
    text.keyPressed();
  }
}
