class Eingang {
  
  int xPos;
  int yPos;
  int mausX;
  int mausY;
  int multiplierX;
  int multiplierY;
  
  boolean ausgewählt = false;
  boolean sichtbar = false;
  boolean basic = true;
  boolean an = false;
  
  Textfeld text = new Textfeld();
  Punkt[] ausgang = new Punkt[86];
  
  
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
        if(basic) {
          ausgang[0].xPos = xPos + 40;
          ausgang[0].yPos = yPos + 20;
        } else {
          for(int index = 0; index < ausgang.length; index++) {
            if(index < 43) {
              ausgang[index].xPos = xPos + 20;
              ausgang[index].yPos = yPos + 100 + 20 * index;
            } else {
              ausgang[index].xPos = xPos + 40;
              ausgang[index].yPos = yPos + 100 + 20 * (index - 43);
            }
          }
        }
      } else {
        sichtbar = false;
        if(basic) {
          ausgang[0].xPos = 340;
          ausgang[0].yPos = yPos + 20;
        } else {
          for(int index = 0; index < ausgang.length; index++) {
            if(index < 43) {
              ausgang[index].xPos = 340;
              ausgang[index].yPos = yPos + 100 + 20 * index;
            } else {
              ausgang[index].xPos = 340;
              ausgang[index].yPos = yPos + 100 + 20 * (index - 43);
            }
          }
        }
      }
    }
    
    if(sichtbar) {
      
      if(basic) {
        ausgang[0].Zeichnen();  
      } else {
        for(int index = 0; index < ausgang.length; index++) {
          ausgang[index].Zeichnen();
        }
      }

      fill(255);
      strokeWeight(2);
      
      if(ausgewählt) {
        stroke(100);
      } else {
        stroke(0);
      }
      
      if(basic) {
        ellipse(xPos + 20, yPos + 20, 30, 30);
        line(xPos + 20 + 15, yPos + 20, xPos + 20 + 20, yPos + 20);
      } else {
        ellipse(xPos + 20, yPos + 20, 30, 30);
        line(xPos + 20, yPos + 20 + 15, xPos + 20, yPos + 940);
        line(xPos + 20, yPos + 40, xPos + 40, yPos + 40);
        line(xPos + 40, yPos + 40, xPos + 40, yPos + 40 + 5);
        rect(xPos + 30, yPos + 45, 20, 30);
        ellipse(xPos + 40, yPos + 79, 8, 8);
        line(xPos + 40, yPos + 83, xPos + 40, yPos + 940);
        fill(0);
        textSize(15);
        textAlign(CENTER, CENTER);
        if(ausgewählt) {
          fill(100);
        } else {
          fill(0);
        }
        text("1", xPos + 40, yPos + 60 - textAscent() * 0.15);
      } 
      
      strokeWeight(1);
      
      if(ausgewählt) {
        fill(100);
      } else {
        if(an) {
          fill(0, 200, 0);
        } else {
          fill(0, 100, 0);
        }
      }
      
      ellipse(xPos + 20, yPos + 20, 22, 22);
      
      fill(255);
      textSize(15);
      textAlign(CENTER, CENTER);
      
      if(an) {
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
      
      textAlign(LEFT, CENTER);
      textSize(20);
      if(basic) {
        text.xPos = xPos - int(textWidth(text.inhalt));
        text.yPos = yPos + 20;
        text.Zeichnen();
      } else {
        text.xPos = xPos + 20 - int(textWidth(text.inhalt)) / 2;
        text.yPos = yPos - int(textAscent()) / 2;
        text.Zeichnen();
      }
     
    }
  }
  
  
  //########################################################################################################################
  
  
  //Operation
  void Operation() {
    if(basic) {
      if(an) {
        ausgang[0].an = true;
      } else {
        ausgang[0].an = false;
      }
    } else {
      if(an) {
        for(int index = 0; index < ausgang.length; index++) {
          if(index < 43) {
            ausgang[index].an = true;
          } else {
            ausgang[index].an = false;
          }
        }
      } else {
        for(int index = 0; index < ausgang.length; index++) {
          if(index < 43) {
            ausgang[index].an = false;
          } else {
            ausgang[index].an = true;
          } 
        }
      }
    }     
  }
  
  
  //########################################################################################################################
  
  
  //Mouse Pressed
  void mousePressed() {
    if(bearbeitungsmod) {
      if(mouseX >= xPos + 5 & mouseY >= yPos + 5 & mouseX <= xPos + 35 & mouseY <= yPos + 35) {
        if(an) {
          an = false;
        } else {
          an = true;
        }
        skip = true;
      }
    } else {
      if(ausgewählt) {
        ausgewählt = false;
        bewegungsmod = false;
        direktVerbindung();
      } else {
        if(basic) {
          if(mouseX >= xPos + 5 & mouseY >= yPos + 5 & mouseX <= xPos + 35 & mouseY <= yPos + 35) {
            ausgewählt = true;
            mausX = mouseX - xPos;
            mausY = mouseY - yPos;
            bewegungsmod = true;
          } else {
            textSize(20);
            if(mouseX >= xPos - textWidth(text.inhalt) & mouseY >= yPos + 20 - textAscent() / 2 & mouseX <= xPos & mouseY <= yPos + 20 + textAscent() / 2) {
              text.ausgewählt = true;
              text.originalInhalt = text.inhalt;
              skip = true;
            }
          }
        } else {
          if(mouseX >= xPos + 5 & mouseY >= yPos + 5 & mouseX <= xPos + 35 & mouseY <= yPos + 35) {
            ausgewählt = true;
            mausX = mouseX - xPos;
            mausY = mouseY - yPos;
            bewegungsmod = true;
          } else if(mouseX >= xPos + 30 & mouseY >= yPos + 45 & mouseX <= xPos + 50 & mouseY <= yPos + 75) {
            ausgewählt = true;
            mausX = mouseX - xPos;
            mausY = mouseY - yPos;
            bewegungsmod = true;
          } else {
            textSize(20);
            if(mouseX >= xPos + 20 - textWidth(text.inhalt) / 2 & mouseY >= yPos - textAscent() & mouseX <= xPos + 20 + textWidth(text.inhalt) / 2 & mouseY <= yPos) {
              text.ausgewählt = true;
              text.originalInhalt = text.inhalt;
              skip = true;
            }
          }
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
