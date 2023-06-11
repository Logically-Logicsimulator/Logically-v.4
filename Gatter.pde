class Gatter {
  
  int xPos;
  int yPos;
  int xSize = 60;
  int ySize = 80;
  
  int mausX;
  int mausY;
  
  int multiplierX;
  int multiplierY;
  
  boolean ausgewählt = false;
  boolean sichtbar = false;
  
  String name = "";
  
  Punkt[] eingang = {new Punkt(), new Punkt()};
  Punkt ausgang = new Punkt();
  
  
  //########################################################################################################################
  
  
  //Zeichnen
  void Zeichnen() {
        
    if(ausgewählt) {
      
      multiplierX = int((mouseX - mausX) / 20);
      multiplierY = int((mouseY - mausY) / 20);
      
      xPos = 20 * multiplierX;
      yPos = 20 * multiplierY;
        
      if(xPos - 20 > 320) {
        sichtbar = true;
        for(int index = 0; index < eingang.length; index++) {
          eingang[index].xPos = xPos - 20;
          eingang[index].yPos = yPos + 20 + 40 * index;
        }
        ausgang.xPos = xPos + 80;
        ausgang.yPos = yPos + ySize / 2;
      } else {
        sichtbar = false;
        for(int index = 0; index < eingang.length; index++) {
          eingang[index].xPos = 340;
          eingang[index].yPos = yPos + 20 + 40 * index;
        }
        ausgang.xPos = 340;
        ausgang.yPos = yPos + 40;
      }
    } 
      
    if(sichtbar) {
      
      for(int index = 0; index < eingang.length; index++) {
        eingang[index].Zeichnen();
      }
      
      ausgang.Zeichnen();
          
      fill(255);
      strokeWeight(2);
      
      if(ausgewählt) {
        stroke(100);
      } else {
        stroke(0);
      }
      
      rect(xPos, yPos, xSize, ySize);
      
      for(int index = 0; index < eingang.length; index++) {
        line(xPos - 20, yPos + 20 + 40 * index, xPos, yPos + 20 + 40 * index);
      }
      
      switch(name) {
        case "Nand":
        case "Nor":
        case "Xnor":
        ellipse(xPos + xSize + 4, yPos + ySize / 2, 8, 8);
        line(xPos + xSize + 8, yPos + ySize / 2, xPos + xSize + 20, yPos + ySize / 2);
        break;
        case "And":
        case "Or":
        case "Xor":
        line(xPos + xSize, yPos + ySize / 2, xPos + xSize + 20, yPos + ySize / 2);
        break;
      }
      
      textSize(12);
      textAlign(LEFT, CENTER);
      
      if(ausgewählt) {
        fill(100); 
      } else {
        fill(0);
      }
      
      for(int index = 0; index < eingang.length; index++) {
        if(eingang[index].an) {
          text("1", xPos + 5, yPos + 20 + 40 * index - textAscent() * 0.15);
        } else {
          text("0", xPos + 5, yPos + 20 + 40 * index - textAscent() * 0.15);
        }
      }
      
      if(ausgang.an) {
        text("1", xPos + xSize - 5 - textWidth("1"), yPos + ySize / 2 - textAscent() * 0.15);
      } else {
        text("0", xPos + xSize - 5 - textWidth("0"), yPos + ySize / 2 - textAscent() * 0.15);
      }
      
      textSize(20);
      text("+", xPos + xSize - 5 - textWidth("+"), yPos + ySize - textAscent() / 2 - textAscent() * 0.15);
      
      textSize(23);
      text("-", xPos + xSize - 5 - textWidth("+") - 5 - textWidth("-"), yPos + ySize - textAscent() / 2 - textAscent() * 0.15);
      
      textSize(30);
      textAlign(CENTER, CENTER);
      
      switch(name) {
        case "And":
        case "Nand":
        text("&", xPos + xSize / 2, yPos + ySize / 2 - textAscent() * 0.15);
        break;
        case "Or":
        case "Nor":
        text("≥1", xPos + xSize / 2, yPos + ySize / 2 - textAscent() * 0.15);
        break;
        case "Xor":
        case "Xnor":
        text("=1", xPos + xSize / 2, yPos + ySize / 2 - textAscent() * 0.15);
        break;
      }
    }
  }
  
  
  //########################################################################################################################
  
  
  //Operation
  void Operation() {
    switch(name) {
      case "And":
      ausgang.an = true;
      for(int index = 0; index < eingang.length; index++) {
        if(!eingang[index].an) {
          ausgang.an = false;
        }
      }
      break;
      case "Nand":
      ausgang.an = false;
      for(int index = 0; index < eingang.length; index++) {
        if(!eingang[index].an) {
          ausgang.an = true;
        }
      }
      break;
      case "Or":
      ausgang.an = false;
      for(int index = 0; index < eingang.length; index++) {
        if(eingang[index].an) {
          ausgang.an = true;
        }
      }
      break;
      case "Nor":
      ausgang.an = true;
      for(int index = 0; index < eingang.length; index++) {
        if(eingang[index].an) {
          ausgang.an = false;
        }
      }
      break;
      case "Xor":
      ausgang.an = false;
      boolean einmal = false;
      for(int index = 0; index < eingang.length; index++) {
        if(eingang[index].an) {
          if(!einmal) {
            einmal = true;
            ausgang.an = true;
          } else {
            ausgang.an = false;
          }
        }
      }
      break;
      case "Xnor":
      if(eingang[0].an) {
        ausgang.an = true;
        for(int index = 1; index < eingang.length; index++) {
          if(!eingang[index].an) {
            ausgang.an = false;
          }
        }
      } else {
        ausgang.an = true;
        for(int index = 1; index < eingang.length; index++) {
          if(eingang[index].an) {
            ausgang.an = false;
          }
        }
      }
      break;
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
      if(mouseX >= xPos & mouseY >= yPos & mouseX <= xPos + xSize & mouseY <= yPos + ySize) {
        textSize(20);
        float a = textWidth("+");
        float c = textAscent();
        textSize(23);
        float b = textWidth("-");
        float d = textAscent();
        if(mouseX >= xPos + xSize - 5 - a & mouseY >= yPos + ySize - c & mouseX <= xPos + xSize - 5 & mouseY <= yPos + ySize) {
          if(eingang.length < 10) {
            eingang = (Punkt[]) expand(eingang, eingang.length + 1);
            eingang[eingang.length - 1] = new Punkt();
            eingang[eingang.length - 1].xPos = xPos - 20;
            eingang[eingang.length - 1].yPos = yPos + 40 * eingang.length - 20;
            updateEingänge();
            xSize = 60;
            ySize = eingang.length * 40;
            ausgang.yPos = yPos + ySize / 2;
            skip = true;
          }
        } else if(mouseX >= xPos + xSize- 5 - a - 5 - b & mouseY >= yPos + ySize - d & mouseX <= xPos + xSize - 5 - a - 5 & mouseY <= yPos + ySize) {
          if(eingang.length > 2) {
            for(int index = 0; index < verbindung.length; index++) {
              if(verbindung[index].ausgang == eingang[eingang.length - 1]) {
                removeIndexVerbindung(index, false);
              }
            }
            Punkt[] eingang1 = (Punkt[]) subset(eingang, 0, eingang.length - 1);
            Punkt[] eingang2 = (Punkt[]) subset(eingang, eingang.length, eingang.length - eingang.length);
            eingang = (Punkt[]) concat(eingang1, eingang2);
            updateEingänge();
            xSize = 60;
            ySize = eingang.length * 40;
            ausgang.yPos = yPos + ySize / 2;
            skip = true;
          }
        } else {
          ausgewählt = true;
          mausX = mouseX - xPos;
          mausY = mouseY - yPos;
          bewegungsmod = true;
        }
      }
    }
  }
}
