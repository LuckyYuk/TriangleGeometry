// OSC通信
void oscEvent( OscMessage theOscMessage ) {
  if ( theOscMessage.checkAddrPattern("/vvc/updown") == true ) {
    if (theOscMessage.checkTypetag("f")) {
      float value = theOscMessage.get(0).floatValue();
      //println("receive " + value);
      if (value > 50) {
        this.cursor.y -= 50.0;
      } else if (value < -50) {
        this.cursor.y += 50.0;
      }
    }
  } else if ( theOscMessage.checkAddrPattern("/vvc/leftright") == true ) {
    if (theOscMessage.checkTypetag("f")) {
      float value = theOscMessage.get(0).floatValue();
      println("receive " + value);
      if (value > 50) {
        this.cursor.x += 50.0;
      } else if (value < -50) {
        this.cursor.x -= 50.0;
      }
    }
  } else if ( theOscMessage.checkAddrPattern("/vvc/draw") == true ) {
    if (theOscMessage.checkTypetag("i")) {
      // trueきたとき
      if (theOscMessage.get(0).intValue()==1) {
        c = color( r, g, b);
        this.click();
      }
      // falseきたとき
      else {
      }
    }
  } else if ( theOscMessage.checkAddrPattern("/vvc/fill") == true ) {
    if (theOscMessage.checkTypetag("i")) {
      // trueきたとき
      if (theOscMessage.get(0).intValue()==1) {
        this.fill  = true;
        this.frame = false; 
        this.moire = false;
      }
    }
  } else if ( theOscMessage.checkAddrPattern("/vvc/frame") == true ) {
    if (theOscMessage.checkTypetag("i")) {
      // trueきたとき
      if (theOscMessage.get(0).intValue()==1) {
        this.frame = true;
        this.fill  = false;
        this.moire = false;
      }
    }
  } else if ( theOscMessage.checkAddrPattern("/vvc/moire") == true ) {
    if (theOscMessage.checkTypetag("i")) {
      // trueきたとき
      if (theOscMessage.get(0).intValue()==1) {
        this.moire = true;
        this.frame = false;
        this.fill  = false;
      }
    }
  } else if ( theOscMessage.checkAddrPattern( "/vvc/color" ) == true ) {
    if (theOscMessage.checkTypetag("s")) {
      println("color :" + theOscMessage.get(0));
      receivedColor = splitTokens(theOscMessage.get(0).toString(), "z");
      println("color R =" + receivedColor[0]  + ", G=" + receivedColor[1] + ", B=" + receivedColor[2]);
      r = Integer.parseInt(receivedColor[0]);
      g = Integer.parseInt(receivedColor[1]);
      b = Integer.parseInt(receivedColor[2]);
      r*=2.55;
      g*=2.55;
      b*=2.55;
    }
  }
}
