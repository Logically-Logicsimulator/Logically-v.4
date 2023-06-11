class Textfeld {
  
  int xPos;
  int yPos;
  
  int m; 
  int sm;
  int gm;
  
  int zeichenAnzahl;
  int textlänge;
  
  String inhalt = "";
  String originalInhalt = "";
  
  boolean ausgewählt = false;
  boolean zuerst = true;
  boolean schwarz = true;
  boolean freiraum = true;
   
  
  //########################################################################################################################
  
  
  //Zeichnen
  void Zeichnen() {
    text(inhalt, xPos, yPos - textAscent() * 0.15);
    if(ausgewählt) {
      stroke(0);
      if(zuerst) {
        m = millis();
        zuerst = false;
      } else {
        sm = millis() - m;
        gm = gm + sm;
        m = millis();
        if(gm > 420) {
          if(schwarz) {
            schwarz = false;
          } else {
            schwarz = true;
          }
          gm = 0;
        }
      }
      if(schwarz) {
        rect(xPos + textWidth(inhalt) + 2, yPos - textAscent() / 2, 2, textAscent());
      }
    }
  }
  
  
  //########################################################################################################################
  
  
  //Inhalt löschen
  void inhaltLöschen() {
    String teilInhalt = "";
    String neuerInhalt = "";
    for(int index = 1; index < inhalt.length(); index++) {
      teilInhalt = inhalt.substring(index - 1, index);
      neuerInhalt = neuerInhalt + teilInhalt;
    }
    inhalt = neuerInhalt;
  }
  
  
  //########################################################################################################################
  
  
  //Key Pressed
  void keyPressed() {
    if(inhalt.length() < zeichenAnzahl || textWidth(inhalt) < textlänge) {
      if(key >= 'a' & key <= 'z') {
        inhalt = inhalt + key;
      } else if(key >= 'A' & key <= 'Z') {
        inhalt = inhalt + key;
      } else if(key >= 'ä' & key <= 'ü') {
        inhalt = inhalt + key;
      } else if(key >= 'Ä' & key <= 'Ü') {
        inhalt = inhalt + key;
      } else if(key >= '0' & key <= '9') {
        inhalt = inhalt + key;
      } else if(key == 'ß') {
        inhalt = inhalt + key;
      } else if(key == '§' || key == '$' || key == '%' || key == '&' || key == '=' || key == '+' || key == '#' || key == '-' || key == '_') {
        inhalt = inhalt + key;
      } else if(key == ' ' & freiraum) {
        inhalt = inhalt + key;
      } else if(keyCode == BACKSPACE) {
        inhaltLöschen();
      } else if(keyCode == ENTER) {
        ausgewählt = false;
        if(inhalt.length() < 1) {
          inhalt = originalInhalt;
        }
      }
    } else {
      if(keyCode == BACKSPACE) {
        inhaltLöschen();
      } else if(keyCode == ENTER) {
        ausgewählt = false;
      }
    }
  }
}
