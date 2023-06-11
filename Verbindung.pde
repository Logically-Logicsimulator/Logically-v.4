class Verbindung {
  
  int differenzX;
  int differenzY;
  
  boolean ausgewählt = false;
  
  Punkt eingang = null;
  Punkt ausgang = null;
  
  //########################################################################################################################
  
  
  //Zeichnen
  void Zeichnen() {
    if(eingang != null & ausgang != null) {
      if(ausgewählt) {
        stroke(100);
      } else {
        stroke(0);
      }
      strokeWeight(2);
      //Die x-Koordinaten und die y-Koordinaten von Eingang und Ausgang sind verschieden
      if(eingang.xPos != ausgang.xPos & eingang.yPos != ausgang.yPos) {
        //Eingang befindet sich vor dem Ausgang 
        if(eingang.xPos < ausgang.xPos) {
          differenzX = ausgang.xPos - eingang.xPos;
          differenzX = differenzX / 20; 
          if(differenzX > 1) {
            if(differenzX % 2 == 0) {
              differenzX = eingang.xPos + differenzX / 2 * 20;
            } else {
              differenzX = eingang.xPos + (differenzX + 1) / 2 * 20;
            }
            line(eingang.xPos, eingang.yPos, differenzX, eingang.yPos);
            line(differenzX, eingang.yPos, differenzX, ausgang.yPos);
            line(differenzX, ausgang.yPos, ausgang.xPos, ausgang.yPos);
          } else {
            line(eingang.xPos, eingang.yPos, ausgang.xPos, eingang.yPos);
            line(ausgang.xPos, eingang.yPos, ausgang.xPos, ausgang.yPos);
          }
          //Eingang befindet sich hinter dem Ausgang
        } else {
          differenzY = ausgang.yPos - eingang.yPos;
          differenzY = differenzY / 20;
          if(differenzY != 1 & differenzY != -1) {
            if(differenzY % 2 == 0) {
              differenzY = eingang.yPos + differenzY / 2 * 20;
            } else {
              if(differenzY > 0) {
                differenzY = eingang.yPos + (differenzY + 1) / 2 * 20;
              } else {
                differenzY = eingang.yPos + (differenzY - 1) / 2 * 20;
              }
            }
            line(eingang.xPos, eingang.yPos, eingang.xPos, differenzY);
            line(eingang.xPos, differenzY, ausgang.xPos, differenzY);
            line(ausgang.xPos, differenzY, ausgang.xPos, ausgang.yPos);
          } else {
            line(eingang.xPos, eingang.yPos, eingang.xPos, ausgang.yPos);
            line(eingang.xPos, ausgang.yPos, ausgang.xPos, ausgang.yPos);
          }    
        }
        //Nur die x-Koordinaten von Eingang und Ausgang sind verschieden, die y-Koordinaten sind gleich 
      } else if(eingang.xPos != ausgang.xPos & eingang.yPos == ausgang.yPos) {
        line(eingang.xPos, eingang.yPos, ausgang.xPos, ausgang.yPos);
        //Nur die x-Koordinaten von Eingang und Ausgang sind gleich, die y-Koordinaten sind verschieden 
      } else if(eingang.xPos == ausgang.xPos & eingang.yPos != ausgang.yPos) {
        line(eingang.xPos, eingang.yPos, ausgang.xPos, ausgang.yPos);
      }
    }
  }

  
  //########################################################################################################################
  
  
  //Operation
  void Operation() {
    if(eingang != null & ausgang != null) {
      if(eingang.an) {
        ausgang.an = true;
      } else {
        ausgang.an = false;
      }
    }
  }
  
  
  //########################################################################################################################
  
  
  //Mouse Pressed 
  void mousePressed() {
    //Die x-Koordinaten und die y-Koordinaten von Eingang und Ausgang sind verschieden
    if(eingang.xPos != ausgang.xPos & eingang.yPos != ausgang.yPos) {
      //Eingang befindet sich vor dem Ausgang 
      if(eingang.xPos < ausgang.xPos) {
        if(differenzX > 1) {
          //Eingang befindet sich über dem Ausgang
          if(eingang.yPos < ausgang.yPos) {
            if(mouseX >= eingang.xPos - 1 & mouseY >= eingang.yPos - 1 & mouseX <= differenzX + 1 & mouseY <= eingang.yPos + 1) {
              ausgewählt = true;
            } else if(mouseX >= differenzX - 1 & mouseY >= eingang.yPos - 1 & mouseX <= differenzX + 1 & mouseY <= ausgang.yPos + 1) {
              ausgewählt = true;
            } else if(mouseX >= differenzX - 1 & mouseY >= ausgang.yPos - 1 & mouseX <= ausgang.xPos + 1 & mouseY <= ausgang.yPos + 1) {
              ausgewählt = true;
            }
          } else {
            //Eingang befindet sich unter dem Ausgang
            if(mouseX >= eingang.xPos - 1 & mouseY >= eingang.yPos - 1 & mouseX <= differenzX + 1 & mouseY <= eingang.yPos + 1) {
              ausgewählt = true;
            } else if(mouseX >= differenzX - 1 & mouseY >= ausgang.yPos - 1 & mouseX <= differenzX + 1 & mouseY <= eingang.yPos + 1) {
              ausgewählt = true;
            } else if(mouseX >= differenzX - 1 & mouseY >= ausgang.yPos - 1 & mouseX <= ausgang.xPos + 1 & mouseY <= ausgang.yPos + 1) {
              ausgewählt = true;
            }
          }
        } else {
          //Eingang befindet sich über dem Ausgang
          if(eingang.yPos < ausgang.yPos ) {
            if(mouseX >= eingang.xPos - 1 & mouseY >= eingang.yPos - 1 & mouseX <= ausgang.xPos + 1 & mouseY <= eingang.yPos + 1) {
              ausgewählt = true;
            } else if(mouseX >= ausgang.xPos - 1 & mouseY >= eingang.yPos - 1 & mouseX <= ausgang.xPos + 1 & mouseY <= ausgang.yPos + 1) {
              ausgewählt = true;
            }
            //Eingang befindet sich unter dem Ausgang
          } else {
            if(mouseX >= eingang.xPos - 1 & mouseY >= eingang.yPos - 1 & mouseX <= ausgang.xPos + 1 & mouseY <= eingang.yPos + 1) {
              ausgewählt = true;
            } else if(mouseX >= ausgang.xPos - 1 & mouseY >= ausgang.yPos - 1 & mouseX <= ausgang.xPos + 1 & mouseY <= eingang.yPos + 1) {
              ausgewählt = true;
            }
          }
        }
        //Eingang befindet sich hinter dem Ausgang
      } else {
        if(differenzY > 1) {
          //Eingang befindet sich über dem Ausgang
          if(eingang.yPos < ausgang.yPos) {
            if(mouseX >= eingang.xPos - 1 & mouseY >= eingang.yPos - 1 & mouseX <= eingang.xPos + 1 & mouseY <= differenzY + 1) {
              ausgewählt = true;
            } else if(mouseX >= ausgang.xPos - 1 & mouseY >= differenzY - 1 & mouseX <= eingang.xPos + 1 & mouseY <= differenzY + 1) {
              ausgewählt = true;
            } else if(mouseX >= ausgang.xPos - 1 & mouseY >= differenzY - 1 & mouseX <= ausgang.xPos + 1 & mouseY <= ausgang.yPos + 1) {
              ausgewählt = true;
            }
            //Eingang befindet sich unter dem Ausgang
          } else {
            if(mouseX >= eingang.xPos - 1 & mouseY >= differenzY - 1 & mouseX <= eingang.xPos + 1 & mouseY <= eingang.yPos + 1) {
              ausgewählt = true;
            } else if(mouseX >= ausgang.xPos - 1 & mouseY >= differenzY - 1 & mouseX <= eingang.xPos + 1 & mouseY <= differenzY + 1) {
              ausgewählt = true;
            } else if(mouseX >= ausgang.xPos - 1 & mouseY >= ausgang.yPos - 1 & mouseX <= ausgang.xPos + 1 & mouseY <= differenzY + 1) {
              ausgewählt = true;
            }
          }
        } else {
          //Eingang befindet sich über dem Ausgang
          if(eingang.yPos < ausgang.yPos) {
            if(mouseX >= eingang.xPos - 1 & mouseY >= eingang.yPos - 1 & mouseX <= eingang.xPos + 1 & mouseY <= ausgang.yPos + 1) {
              ausgewählt = true;
            } else if(mouseX >= ausgang.xPos - 1 & mouseY >= ausgang.yPos - 1 & mouseX <= eingang.xPos + 1 & mouseY <= ausgang.yPos + 1) {
              ausgewählt = true;
            }
            //Eingang befindet sich unter dem Ausgang
          } else {
            if(mouseX >= eingang.xPos - 1 & mouseY >= ausgang.yPos - 1 & mouseX <= eingang.xPos + 1 & mouseY <= eingang.yPos + 1) {
              ausgewählt = true;
            } else if(mouseX >= ausgang.xPos - 1 & mouseY >= ausgang.yPos - 1 & mouseX <= eingang.xPos + 1 & mouseY <= ausgang.yPos + 1) {
              ausgewählt = true;
            }
          }
        }
      }
      //Nur die x-Koordinaten von Eingang und Ausgang sind verschieden, die y-Koordinaten sind gleich
    } else if(eingang.xPos != ausgang.xPos & eingang.yPos == ausgang.yPos) {
      //Eingang befindet sich vor dem Ausgang
      if(eingang.xPos < ausgang.xPos) {
        if(mouseX >= eingang.xPos - 1 & mouseY >= eingang.yPos - 1 & mouseX <= ausgang.xPos + 1 & mouseY <= eingang.yPos + 1) {
          ausgewählt = true;
        }
        //Eingang befindet sich hinter dem Ausgang
      } else {
        if(mouseX >= ausgang.xPos - 1 & mouseY >= ausgang.yPos - 1 & mouseX <= eingang.xPos + 1 & mouseY <= ausgang.yPos + 1) {
          ausgewählt = true;
        }
      }
      //Nur die x-Koordinaten von Eingang und Ausgang sind gleich, die y-Koordinaten sind verschieden
    } else if(eingang.xPos == ausgang.xPos & eingang.yPos != ausgang.yPos) {
      //Eingang befindet sich über dem Ausgang
      if(eingang.yPos < ausgang.yPos) {
        if(mouseX >= eingang.xPos - 1 & mouseY >= eingang.yPos - 1 & mouseX <= eingang.xPos + 1 & mouseY <= ausgang.yPos + 1) {
          ausgewählt = true;
        }
        //Eingang befindet sich unter dem Ausgang
      } else {
        if(mouseX >= ausgang.xPos - 1 & mouseY >= ausgang.yPos - 1 & mouseX <= ausgang.xPos + 1 & mouseY <= eingang.yPos + 1) {
          ausgewählt = true;
        }
      }
    }
  }
}
    
    
