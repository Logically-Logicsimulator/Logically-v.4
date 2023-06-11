Verbindung[] verbindung = new Verbindung[0];
Eingang[] eingang = new Eingang[0];
Ausgang[] ausgang = new Ausgang[0];
Nicht[] nicht = new Nicht[0];
Gatter[] gatter = new Gatter[0];

Punkt[] eingänge = new Punkt[0];
Punkt[] ausgänge = new Punkt[0];

Textfeld text = new Textfeld();

String[] komponenten = {"InputBasic", "InputAdvanced", "Output", "Not", "And", "Nand", "Or", "Nor", "Xor", "Xnor"};

boolean verbindungsmod = false;
boolean bewegungsmod = false;
boolean bearbeitungsmod = false;
boolean skip = false;

boolean y = false;

Table table;


//########################################################################################################################


//Setup
void setup() {
  background(255);
  //Auflösung ändern:
  size(1920, 1080);
  surface.setTitle("Logically v.4 by Marian Fischer");
  PImage icon = loadImage("icon.png");
  surface.setIcon(icon);
}


//########################################################################################################################


//Draw
void draw() {
  
  background(255);
  
  int spalte = 1;
  int zeile = 1;
  
  fill(0);
  stroke(0);
  strokeWeight(1);
  
  //Bei Auflösungsänderung: 
  int anzahl = ((1920 - 340) / 20) * ((1080 - 20) / 20);
  
  for(int index = 0; index < anzahl; index++) {

    ellipse(320 + 20 * spalte, 20 * zeile, 1, 1);
    
    //Bei Auflösungsänderung: 
    if(spalte == (1920 - 340) / 20) {
      zeile++;
      spalte = 1;
    } else {
      spalte++;
    }
  }
  
  for(int index = 0; index < verbindung.length; index++) {
    verbindung[index].Operation();
  }
  
  for(int index = 0; index < eingang.length; index++) {
    eingang[index].Operation();
    eingang[index].Zeichnen();
  }
  
  for(int index = 0; index < ausgang.length; index++) {
    ausgang[index].Zeichnen();
  }
  
  for(int index = 0; index < nicht.length; index++) {
    nicht[index].Operation();
    nicht[index].Zeichnen();
  }
    
  for(int index = 0; index < gatter.length; index++) {
    gatter[index].Operation();
    gatter[index].Zeichnen();
  }
  
  for(int index = 0; index < verbindung.length; index++) {
    verbindung[index].Zeichnen();
  }
  
  stroke(0);
  strokeWeight(2);
  //Bei Auflösungsänderung: 
  line(320, 0, 320, 1080);

  fill(255);
  
  rect(20, 20, 35, 35);
  rect(75, 20, 35, 35);
  
  PImage cursor = loadImage("arrow.png");
  image(cursor, 25, 25, 25, 25);
  
  PImage cursorHand = loadImage("hand.png");
  image(cursorHand, 80, 25, 25, 25);

  line(0, 85, 320, 83);
  
  textSize(30);
  textAlign(LEFT, CENTER);
  
  button(20, 105, 280, 50);
  strokeWeight(1);
  text.xPos = 35;
  text.yPos = 105 + 25;
  if(text.ausgewählt) {
    fill(0);
    text.Zeichnen();
  } else {
    if(text.inhalt.length() > 0) {
      fill(0);
      text.Zeichnen();
    } else {
      fill(100);
      text("Type...", 35, 105 + 25 - textAscent() * 0.15);
    }
  }
  
  button(20, 175, 80, 50);
  fill(0);
  text("Load", 30, 175 + 25 - textAscent() * 0.15);
  
  button(120, 175, 80, 50);
  fill(0);
  text("Save", 130, 175 + 25 - textAscent() * 0.15);
  
  button(220, 175, 80, 50);
  fill(0);
  text("New", 230, 175 + 25 - textAscent() * 0.15);

  stroke(0);
  strokeWeight(2);
  line(0, 245, 320, 245);

  for(int index = 0; index < komponenten.length; index++) {
    if(index == 0) {
      textSize(40);
      fill(0);
      text("Input", 20, 318 - textAscent() / 2 - textAscent() * 0.15 + 60 * index);
      line(20, 325 + 60 * index, 300, 325 + 60 * index);
      textSize(25);
      fill(100);
      text("basic", 300 - textWidth("basic") - 10, 318 - textAscent() / 2 - textAscent() * 0.15 + 60 * index);
    } else if(index == 1) {
      textSize(40);
      fill(0);
      text("Input", 20, 318 - textAscent() / 2 - textAscent() * 0.15 + 60 * index);
      line(20, 325 + 60 * index, 300, 325 + 60 * index);
      textSize(25);
      fill(100);
      text("advanced", 300 - textWidth("advanced") - 10, 318 - textAscent() / 2 - textAscent() * 0.15 + 60 * index);
    } else {
      textSize(40);
      fill(0);
      text(komponenten[index], 20, 318 - textAscent() / 2 - textAscent() * 0.15 + 60 * index);
      if(index == 4) {
        textSize(30);
        fill(100);
        text("&", 300 - textWidth("&") - 10, 318 - textAscent() / 2 - textAscent() * 0.15 + 60 * index);
      }
      if(index == 6) {
        textSize(30);
        fill(100);
        text("≥1", 300 - textWidth("≥1") - 10, 318 - textAscent() / 2 - textAscent() * 0.15 + 60 * index);
      }
      if(index == 8) {
        textSize(30);
        fill(100);
        text("=1", 300 - textWidth("=1") - 10, 318 - textAscent() / 2 - textAscent() * 0.15 + 60 * index);
      }
      line(20, 325 + 60 * index, 300, 325 + 60 * index);
    }
  }
}


//########################################################################################################################


//Mouse Pressed
void mousePressed() {
  for(int index = 0; index < verbindung.length; index++) {
    if(verbindung[index].ausgewählt) {
      verbindung[index].ausgewählt = false;
    }
  }
  for(int index = 0; index < eingang.length; index++) {
    if(eingang[index].text.ausgewählt) {
      eingang[index].text.ausgewählt = false;
      if(eingang[index].text.inhalt.length() < 1) {
        eingang[index].text.inhalt = eingang[index].text.originalInhalt;
      } 
    }
  }
  for(int index = 0; index < ausgang.length; index++) {
    if(ausgang[index].text.ausgewählt) {
      ausgang[index].text.ausgewählt = false;
      if(ausgang[index].text.inhalt.length() < 1) {
        ausgang[index].text.inhalt = ausgang[index].text.originalInhalt;
      }
    }
  }
  if(text.ausgewählt) {
    text.ausgewählt = false;
  }
  if(mouseX <= 320) {
    if(bearbeitungsmod) {
      if(mouseX >= 20 & mouseY >= 20 & mouseX <= 55 & mouseY <= 55) {
        bearbeitungsmod = false;
        cursor(ARROW);
      }
    } else {
      if(bewegungsmod) {
        for(int index = 0; index < eingang.length; index++) {
          if(eingang[index].ausgewählt) {
            removeIndexEingang(index);
          }
        }
        for(int index = 0; index < ausgang.length; index++) {
          if(ausgang[index].ausgewählt) {
            removeIndexAusgang(index);
          }
        }
        for(int index = 0; index < nicht.length; index++) {
          if(nicht[index].ausgewählt) {
            removeIndexNicht(index);
          }
        }
        for(int index = 0; index < gatter.length; index++) {
          if(gatter[index].ausgewählt) {
            removeIndexGatter(index);
          }
        }
        bewegungsmod = false;
      }
      if(verbindungsmod) {
        if(y) {
          removeIndexVerbindung(verbindung.length - 1, true);
        } else {
          removeIndexVerbindung(verbindung.length - 1, false);
        }
        verbindungsmod = false;
      }
      if(mouseX >= 75 & mouseY >= 20 & mouseX <= 110 & mouseY <= 55) {
        bearbeitungsmod = true;
        cursor(HAND);
      }
      if(mouseX >= 20 & mouseY >= 105 & mouseX <= 300 & mouseY <= 155) {
        text.ausgewählt = true;
      }
      if(mouseX >= 20 & mouseY >= 175 & mouseX <= 100 & mouseY <= 225) {
        laden();
      }
      if(mouseX >= 120 & mouseY >= 175 & mouseX <= 200 & mouseY <= 225) {
        speichern();
      }
      if(mouseX >= 220 & mouseY >= 175 & mouseX <= 300 & mouseY <= 225) {
        neu();
      }
      for(int index = 0; index < komponenten.length; index++) {
        if(mouseY >= 275 + 60 * index & mouseY <= 335 + 60 * index) {
          if(index <= 1) {
            eingang = (Eingang[]) expand(eingang, eingang.length + 1);
            int last = eingang.length - 1;
            eingang[last] = new Eingang();
            eingang[last].ausgewählt = true;
            eingang[last].mausX = 20;
            eingang[last].mausY = 20;
            if(komponenten[index] == "InputBasic") {
              eingang[last].basic = true;
              eingang[last].ausgang[0] = new Punkt();
            } else {
              eingang[last].basic = false;
              for(int index1 = 0; index1 < eingang[last].ausgang.length; index1++) {
                eingang[last].ausgang[index1] = new Punkt();
              }
            }
            eingang[last].text.inhalt = "A";
            updateAusgänge();
            bewegungsmod = true;
          }
          if(index == 2) {
            ausgang = (Ausgang[]) expand(ausgang, ausgang.length + 1);
            int last = ausgang.length - 1;
            ausgang[last] = new Ausgang();
            ausgang[last].ausgewählt = true;
            ausgang[last].mausX = 20;
            ausgang[last].mausY = 20;
            ausgang[last].text.inhalt = "Y";
            updateEingänge();
            bewegungsmod = true;
          }
          if(index == 3) {
            nicht = (Nicht[]) expand(nicht, nicht.length + 1);
            int last = nicht.length - 1;
            nicht[last] = new Nicht();
            nicht[last].ausgewählt = true;
            nicht[last].mausX = 20;
            nicht[last].mausY = 20;
            updateEingänge();
            updateAusgänge();
            bewegungsmod = true;
          }
          if(index > 3) {
            gatter = (Gatter[]) expand(gatter, gatter.length + 1);
            int last = gatter.length - 1;
            gatter[last] = new Gatter();
            gatter[last].name = komponenten[index];
            gatter[last].ausgewählt = true;
            gatter[last].mausX = 30;
            gatter[last].mausY = 40;
            updateEingänge();
            updateAusgänge();
            bewegungsmod = true;
          }
        }
      }
    }
  } else {
    if(bearbeitungsmod) {
      for(int index = eingang.length - 1; index >= 0; index--) {
        if(!skip) {
          eingang[index].mousePressed();
        }
      }
      if(skip) {
        skip = false;
      }
    } else {
      if(bewegungsmod) {
        for(int index = 0; index < eingang.length; index++) {
          if(eingang[index].ausgewählt) {
            eingang[index].mousePressed();
          }
        }
        for(int index = 0; index < ausgang.length; index++) {
          if(ausgang[index].ausgewählt) {
            ausgang[index].mousePressed();
          }
        }
        for(int index = 0; index < nicht.length; index++) {
          if(nicht[index].ausgewählt) {
            nicht[index].mousePressed();
          }
        }
        for(int index = 0; index < gatter.length; index++) {
          if(gatter[index].ausgewählt) {
            gatter[index].mousePressed();
          }
        }
      } else {
        if(verbindungsmod) {
          if(y) {
            for(int index = 0; index < ausgänge.length; index++) {
              if(ausgänge[index].ausgewählt & verbindungsmod) {
                verbindung[verbindung.length - 1].eingang = ausgänge[index];
                verbindungsmod = false;
              }
            }
            if(verbindungsmod) {
              removeIndexVerbindung(verbindung.length - 1, true);
              verbindungsmod = false;
              auswählen();
            }
          } else {
            for(int index = 0; index < eingänge.length; index++) {
              if(eingänge[index].ausgewählt & verbindungsmod) {
                verbindung[verbindung.length - 1].ausgang = eingänge[index];
                eingänge[index].verbunden = true;
                verbindungsmod = false;
              }
            }
            if(verbindungsmod) {
              removeIndexVerbindung(verbindung.length - 1, false);
              verbindungsmod = false;
              auswählen();
            }
          }     
        } else {
          auswählen();     
        }
      }
    }
  }
}
          
              
//########################################################################################################################

 
//Mouse Moved
void mouseMoved() {
  if(!bearbeitungsmod) {
    for(int index = 0; index < eingänge.length; index++) {
      eingänge[index].mouseMoved();
    }
    for(int index = 0; index < ausgänge.length; index++) {
      ausgänge[index].mouseMoved();
    }
  }
}

      
//########################################################################################################################


//Key Pressed
void keyPressed() {
  if(keyCode == ESC) {
    exit();
  } else if(text.ausgewählt) {
    textSize(30);
    text.zeichenAnzahl = 0;
    text.textlänge = 230;
    text.keyPressed();
  } else if(keyCode == DELETE) {
    for(int index = 0; index < eingang.length; index++) {
      if(eingang[index].ausgewählt) {
        removeIndexEingang(index);
        bewegungsmod = false;
      }
    }
    for(int index = 0; index < ausgang.length; index++) {
      if(ausgang[index].ausgewählt) {
        removeIndexAusgang(index);
        bewegungsmod = false;
      }
    }
    for(int index = 0; index < nicht.length; index++) {
      if(nicht[index].ausgewählt) {
        removeIndexNicht(index);
        bewegungsmod = false;
      }
    }
    for(int index = 0; index < gatter.length; index++) {
      if(gatter[index].ausgewählt) {
        removeIndexGatter(index);
        bewegungsmod = false;
      }
    }
    for(int index = 0; index < verbindung.length; index++) {
      if(verbindung[index].ausgewählt) {
        removeIndexVerbindung(index, true);
      }
    }
  } else {
    for(int index = 0; index < eingang.length; index++) {
      if(eingang[index].text.ausgewählt) {
        eingang[index].keyPressed();
      }
    }
    for(int index = 0; index < ausgang.length; index++) {
      if(ausgang[index].text.ausgewählt) {
        ausgang[index].keyPressed();
      }
    }
  }   
}
  

//########################################################################################################################


//Update Eingänge
void updateEingänge() {
  eingänge = new Punkt[0];
  for(int index = gatter.length - 1; index >= 0; index--) {
    for(int index1 = 0; index1 < gatter[index].eingang.length; index1++) {
      eingänge = (Punkt[]) expand(eingänge, eingänge.length + 1);
      eingänge[eingänge.length - 1] = gatter[index].eingang[index1];
    }
  }
  for(int index = nicht.length - 1; index >= 0; index--) {
    eingänge = (Punkt[]) expand(eingänge, eingänge.length + 1);
    eingänge[eingänge.length - 1] = nicht[index].eingang;
  }
  for(int index = ausgang.length - 1; index >= 0; index--) {
    eingänge = (Punkt[]) expand(eingänge, eingänge.length + 1);
    eingänge[eingänge.length - 1] = ausgang[index].eingang;
  }
}


//########################################################################################################################


//Update Ausgänge 
void updateAusgänge() {
  ausgänge = new Punkt[0];
  for(int index = gatter.length - 1; index >= 0; index--) {
    ausgänge = (Punkt[]) expand(ausgänge, ausgänge.length + 1);
    ausgänge[ausgänge.length - 1] = gatter[index].ausgang;
  }
  for(int index = nicht.length - 1; index >= 0; index--) {
    ausgänge = (Punkt[]) expand(ausgänge, ausgänge.length + 1);
    ausgänge[ausgänge.length - 1] = nicht[index].ausgang;
  }
  for(int index = eingang.length - 1; index >= 0; index--) {
    if(eingang[index].basic) {
      ausgänge = (Punkt[]) expand(ausgänge, ausgänge.length + 1);
      ausgänge[ausgänge.length - 1] = eingang[index].ausgang[0];
    } else {
      for(int index1 = 0; index1 < eingang[index].ausgang.length; index1++) {
        ausgänge = (Punkt[]) expand(ausgänge, ausgänge.length + 1);
        ausgänge[ausgänge.length - 1] = eingang[index].ausgang[index1];
      }
    }
  }
}


//########################################################################################################################


//Verbindung löschen 
void removeIndexVerbindung(int index, boolean x) {
  if(x) {
    for(int index1 = 0; index1 < eingänge.length; index1++) {
      if(verbindung[index].ausgang == eingänge[index1]) {
        eingänge[index1].verbunden = false;
      }
    }
  }
  Verbindung[] verbindung1 = (Verbindung[]) subset(verbindung, 0, index);
  Verbindung[] verbindung2 = (Verbindung[]) subset(verbindung, index + 1, verbindung.length - (index + 1));
  verbindung = (Verbindung[]) concat(verbindung1, verbindung2);
}


//########################################################################################################################


//Eingang löschen 
void removeIndexEingang(int index) {
  if(eingang[index].basic) {
    for(int index1 = 0; index1 < verbindung.length; index1++) {
      if(verbindung[index1].eingang == eingang[index].ausgang[0]) {
        removeIndexVerbindung(index1, true);
      }
    }
  } else {
    for(int index1 = 0; index1 < eingang[index].ausgang.length; index1++) {
      for(int index2 = 0; index2 < verbindung.length; index2++) {
        if(eingang[index].ausgang[index1] == verbindung[index2].eingang) {
          removeIndexVerbindung(index2, true);
        }
      }
    }
  }
  Eingang[] eingang1 = (Eingang[]) subset(eingang, 0, index);
  Eingang[] eingang2 = (Eingang[]) subset(eingang, index + 1, eingang.length - (index + 1));
  eingang = (Eingang[]) concat(eingang1, eingang2);
  updateAusgänge();
}


//########################################################################################################################


//Ausgang löschen 
void removeIndexAusgang(int index) {
  for(int index1 = 0; index1 < verbindung.length; index1++) {
    if(verbindung[index1].ausgang == ausgang[index].eingang) {
      removeIndexVerbindung(index1, false);
    }
  }
  Ausgang[] ausgang1 = (Ausgang[]) subset(ausgang, 0, index);
  Ausgang[] ausgang2 = (Ausgang[]) subset(ausgang, index + 1, ausgang.length - (index + 1));
  ausgang = (Ausgang[]) concat(ausgang1, ausgang2);
  updateEingänge();
}


//########################################################################################################################


//Nicht löschen 
void removeIndexNicht(int index) {
  for(int index1 = 0; index1 < verbindung.length; index1++) {
    if(verbindung[index1].ausgang == nicht[index].eingang) {
      removeIndexVerbindung(index1, false);
    } else {
      if(verbindung[index1].eingang == nicht[index].ausgang) {
        removeIndexVerbindung(index1, true);
      }
    }
  }
  Nicht[] nicht1 = (Nicht[]) subset(nicht, 0, index);
  Nicht[] nicht2 = (Nicht[]) subset(nicht, index + 1, nicht.length - (index + 1));
  nicht = (Nicht[]) concat(nicht1, nicht2);
  updateEingänge();
  updateAusgänge();
}


//########################################################################################################################


//Gatter löschen 
void removeIndexGatter(int index) {
  for(int index1 = 0; index1 < gatter[index].eingang.length; index1++) {
    for(int index2 = 0; index2 < verbindung.length; index2++) {
      if(gatter[index].eingang[index1] == verbindung[index2].ausgang) {
        removeIndexVerbindung(index2, false);
      }
    }
  }
  for(int index1 = 0; index1 < verbindung.length; index1++) {
    if(verbindung[index1].eingang == gatter[index].ausgang) {
      removeIndexVerbindung(index1, true);
    }
  }
  Gatter[] gatter1 = (Gatter[]) subset(gatter, 0, index);
  Gatter[] gatter2 = (Gatter[]) subset(gatter, index + 1, gatter.length - (index + 1));
  gatter = (Gatter[]) concat(gatter1, gatter2);
  updateEingänge();
  updateAusgänge();
}


//########################################################################################################################


//Direktverbindung 
void direktVerbindung() {
  for(int index = 0; index < eingänge.length; index++) {
    for(int index1 = 0; index1 < ausgänge.length; index1++) {
      if(eingänge[index].xPos == ausgänge[index1].xPos & eingänge[index].yPos == ausgänge[index1].yPos & !eingänge[index].verbunden) {
        verbindung = (Verbindung[]) expand(verbindung, verbindung.length + 1);
        int last = verbindung.length - 1;
        verbindung[last] = new Verbindung();
        verbindung[last].ausgang = eingänge[index];
        verbindung[last].eingang = ausgänge[index1];
        eingänge[index].verbunden = true;
      }
    }
  }
}


//########################################################################################################################


//Laden
void laden() {
  if(text.inhalt.length() > 0) {
    table = loadTable(text.inhalt + ".csv", "header");
    if(table != null) {
      neu();
      for(int index = 0; index < table.getRowCount(); index++) {
        TableRow row = table.getRow(index);
        if(row.getString("name").equals("InputBasic") == true || row.getString("name").equals("InputAdvanced")) {
          eingang = (Eingang[]) expand(eingang, eingang.length + 1);
          int last = eingang.length - 1;
          eingang[last] = new Eingang();
          eingang[last].xPos = row.getInt("xPos");
          eingang[last].yPos = row.getInt("yPos");
          if(row.getInt("basic") > 0) {
            eingang[last].basic = true;
            eingang[last].ausgang[0] = new Punkt();
            eingang[last].ausgang[0].xPos = row.getInt("xPos") + 40;
            eingang[last].ausgang[0].yPos = row.getInt("yPos") + 20;
          } else {
            eingang[last].basic = false;
            for(int index1 = 0; index1 < eingang[last].ausgang.length; index1++) {
              if(index1 < 43) {
                eingang[last].ausgang[index1] = new Punkt();
                eingang[last].ausgang[index1].xPos = row.getInt("xPos") + 20;
                eingang[last].ausgang[index1].yPos = row.getInt("yPos") + 100 + 20 * index1;
              } else {
                eingang[last].ausgang[index1] = new Punkt();
                eingang[last].ausgang[index1].xPos = row.getInt("xPos") + 40;
                eingang[last].ausgang[index1].yPos = row.getInt("yPos") + 100 + 20 * (index1 - 43);
              }
            }
          }
          eingang[last].text.inhalt = row.getString("Bezeichnung");
          eingang[last].sichtbar = true;
          updateAusgänge();
        }
        if(row.getString("name").equals("Output") == true) {
          ausgang = (Ausgang[]) expand(ausgang, ausgang.length + 1);
          int last = ausgang.length - 1;
          ausgang[last] = new Ausgang();
          ausgang[last].xPos = row.getInt("xPos");
          ausgang[last].yPos = row.getInt("yPos");
          ausgang[last].eingang.xPos = row.getInt("xPos");
          ausgang[last].eingang.yPos = row.getInt("yPos") + 20;
          ausgang[last].text.inhalt = row.getString("Bezeichnung");
          ausgang[last].sichtbar = true;
          updateEingänge();
        }
        if(row.getString("name").equals("Not") == true) {
          nicht = (Nicht[]) expand(nicht, nicht.length + 1);
          int last = nicht.length - 1;
          nicht[last] = new Nicht();
          nicht[last].xPos = row.getInt("xPos");
          nicht[last].yPos = row.getInt("yPos");
          nicht[last].eingang.xPos = row.getInt("xPos");
          nicht[last].eingang.yPos = row.getInt("yPos") + 20;
          nicht[last].ausgang.xPos = row.getInt("xPos") + 40;
          nicht[last].ausgang.yPos = row.getInt("yPos") + 20;
          nicht[last].sichtbar = true;
          updateEingänge();
          updateAusgänge();
        }
        for(int index1 = 4; index1 < 10; index1++) {
          if(row.getString("name").equals(komponenten[index1]) == true) {
            gatter = (Gatter[]) expand(gatter, gatter.length + 1);
            int last = gatter.length - 1;
            gatter[last] = new Gatter();
            gatter[last].name = row.getString("name");
            gatter[last].xPos = row.getInt("xPos");
            gatter[last].yPos = row.getInt("yPos");
            gatter[last].ySize = row.getInt("ySize");
            gatter[last].eingang[0].xPos = row.getInt("xPos") - 20;
            gatter[last].eingang[0].yPos = row.getInt("yPos") + 20;
            gatter[last].eingang[1].xPos = row.getInt("xPos") - 20;
            gatter[last].eingang[1].yPos = row.getInt("yPos") + 60;
            for(int index2 = 2; index2 < row.getInt("ySize") / 40; index2++) {
              gatter[last].eingang = (Punkt[]) expand(gatter[last].eingang, index2 + 1);
              gatter[last].eingang[index2] = new Punkt();
              gatter[last].eingang[index2].xPos = row.getInt("xPos") - 20;
              gatter[last].eingang[index2].yPos = row.getInt("yPos") + 40 * index2 + 20;
            }
            gatter[last].ausgang.xPos = row.getInt("xPos") + 80;
            gatter[last].ausgang.yPos = row.getInt("yPos") + row.getInt("ySize") / 2; 
            gatter[last].sichtbar = true;
            updateEingänge();
            updateAusgänge();
          }
        }
        if(row.getString("name").equals("Connection") == true) {
          verbindung = (Verbindung[]) expand(verbindung, verbindung.length + 1);
          verbindung[verbindung.length - 1] = new Verbindung();
          for(int index1 = 0; index1 < ausgänge.length; index1++) {
            if(row.getInt("xPos") == ausgänge[index1].xPos & row.getInt("yPos") == ausgänge[index1].yPos) {
              verbindung[verbindung.length - 1].eingang = ausgänge[index1];
            }
          }
          for(int index1 = 0; index1 < eingänge.length; index1++) {
            if(row.getInt("xPos1") == eingänge[index1].xPos & row.getInt("yPos1") == eingänge[index1].yPos) {
              verbindung[verbindung.length - 1].ausgang = eingänge[index1];
              eingänge[index1].verbunden = true;
            }
          } 
        }
      }
    }
  }
}



//########################################################################################################################


//Speichern
void speichern() {
  if(text.inhalt.length() > 0) {
    table = new Table();
    table.addColumn("name");
    table.addColumn("xPos");
    table.addColumn("yPos");
    table.addColumn("ySize");
    table.addColumn("xPos1");
    table.addColumn("yPos1");
    table.addColumn("basic");
    table.addColumn("Bezeichnung");
    for(int index = 0; index < eingang.length; index++) {
      TableRow newRow = table.addRow();
      if(eingang[index].basic) {
        newRow.setString("name", "InputBasic");
        newRow.setInt("basic", 1);
      } else {
        newRow.setString("name", "InputBasic");
        newRow.setInt("basic", 0);
      }
      newRow.setInt("xPos", eingang[index].xPos);
      newRow.setInt("yPos", eingang[index].yPos);
      newRow.setString("Bezeichnung", eingang[index].text.inhalt);
    }
    for(int index = 0; index < ausgang.length; index++) {
      TableRow newRow = table.addRow();
      newRow.setString("name", "Output");
      newRow.setInt("xPos", ausgang[index].xPos);
      newRow.setInt("yPos", ausgang[index].yPos);
      newRow.setString("Bezeichnung", ausgang[index].text.inhalt);
    }
    for(int index = 0; index < nicht.length; index++) {
      TableRow newRow = table.addRow();
      newRow.setString("name", "Not");
      newRow.setInt("xPos", nicht[index].xPos);
      newRow.setInt("yPos", nicht[index].yPos);
    }
    for(int index = 0; index < gatter.length; index++) {
      TableRow newRow = table.addRow();
      newRow.setString("name", gatter[index].name);
      newRow.setInt("xPos", gatter[index].xPos);
      newRow.setInt("yPos", gatter[index].yPos);
      newRow.setInt("ySize", gatter[index].ySize);
    }
    for(int index = 0; index < verbindung.length; index++) {
      TableRow newRow = table.addRow();
      newRow.setString("name", "Connection");
      newRow.setInt("xPos", verbindung[index].eingang.xPos);
      newRow.setInt("yPos", verbindung[index].eingang.yPos);
      newRow.setInt("xPos1", verbindung[index].ausgang.xPos);
      newRow.setInt("yPos1", verbindung[index].ausgang.yPos);
    } 
    saveTable(table, "data/" + text.inhalt + ".csv");
  }
}


//########################################################################################################################


//Neu
void neu() {
  for(int index = eingang.length - 1; index >= 0; index--) {
    removeIndexEingang(index);
  }
  for(int index = ausgang.length - 1; index >= 0; index--) {
    removeIndexAusgang(index);
  }
  for(int index = nicht.length - 1; index >= 0; index--) {
    removeIndexNicht(index);
  }
  for(int index = gatter.length - 1; index >= 0; index--) {
    removeIndexGatter(index);
  }
}


//########################################################################################################################


//Button 
void button(int xpos, int ypos, int xsize, int ysize) {
  noStroke();
  fill(0);
  arc(xpos + 15, ypos + 15, 30, 30, radians(180), radians(270));
  arc(xpos + xsize - 15, ypos + 15, 30, 30, radians(270), radians(360));
  arc(xpos + xsize - 15, ypos + ysize - 15, 30, 30, radians(0), radians(90));
  arc(xpos + 15, ypos + ysize - 15, 30, 30, radians(90), radians(180));
  rect(xpos + 15, ypos, xsize - 30, 15);
  rect(xpos + xsize - 15, ypos + 15, 15, ysize - 30);
  rect(xpos + 15, ypos + ysize - 15, xsize - 30, 15);
  rect(xpos, ypos + 15, 15, ysize - 30);
  
  fill(255);
  arc(xpos + 15, ypos + 15, 24, 24, radians(180), radians(270));
  arc(xpos + xsize - 15, ypos + 15, 24, 24, radians(270), radians(360));
  arc(xpos + xsize - 15, ypos + ysize - 15, 24, 24, radians(0), radians(90));
  arc(xpos + 15, ypos + ysize - 15, 24, 24, radians(90), radians(180));
  rect(xpos + 15, ypos + 3, xsize - 30, 12);
  rect(xpos + xsize - 15, ypos + 15, 12, ysize - 30);
  rect(xpos + 15, ypos + ysize - 15, xsize - 30, 12);
  rect(xpos + 3, ypos + 15, 12, ysize - 30);
  rect(xpos + 15, ypos + 15, xsize - 30, ysize - 30);
}


//########################################################################################################################


void auswählen() {
  for(int index = verbindung.length - 1; index >= 0; index--) {
    if(index < verbindung.length - 1) {
      if(verbindung[index + 1].ausgewählt) {
        index = 0;
        skip = true;
      } else {
        verbindung[index].mousePressed();
      }
    } else {
      verbindung[index].mousePressed();
    }
  }
  for(int index = gatter.length - 1; index >= 0; index--) {
    if(!bewegungsmod & !skip) {
      gatter[index].mousePressed();
    }
  }
  if(!bewegungsmod & !skip) {
    for(int index = nicht.length - 1; index >= 0; index--) {
      if(!bewegungsmod & !skip) {
        nicht[index].mousePressed();
      }
    }
  }
  if(!bewegungsmod & !skip) {
    for(int index = ausgang.length - 1; index >= 0; index--) {
      if(!bewegungsmod & !skip) {
        ausgang[index].mousePressed();
      }
    }
  }
  if(!bewegungsmod & !skip) {
    for(int index = eingang.length - 1; index >= 0; index--) {
      if(!bewegungsmod & !skip) {
        eingang[index].mousePressed();
      }
    }
  }
  if(!bewegungsmod & !skip) {
    for(int index = 0; index < eingänge.length; index++) {
      if(eingänge[index].ausgewählt & !verbindungsmod) {
        verbindung = (Verbindung[]) expand(verbindung, verbindung.length + 1);
        verbindung[verbindung.length - 1] = new Verbindung();
        verbindung[verbindung.length - 1].ausgang = eingänge[index];
        eingänge[index].verbunden = true;
        verbindungsmod = true;
        y = true;
      }
    }
    if(!verbindungsmod) {
      for(int index = 0; index < ausgänge.length; index++) {
        if(ausgänge[index].ausgewählt & !verbindungsmod) {
          verbindung = (Verbindung[]) expand(verbindung, verbindung.length + 1);
          verbindung[verbindung.length - 1] = new Verbindung();
          verbindung[verbindung.length - 1].eingang = ausgänge[index];
          verbindungsmod = true;
          y = false;
        }
      }
    }
  }
  if(skip) {
    skip = false;
  }
}     
