class Button{
  boolean isHovering;
  String txt;
  float txtSize, x, y, w, h;
  color c;
  
  //Constructor del boton
  Button(String txt, float txtSize, float x, float y, float w, float h, color c){
    this.txt= txt;
    this.txtSize= txtSize;
    this.x= x;
    this.y= y;
    this.w= w;
    this.h= h;
    this.c = c;
  }
  
  //Dibuja el boton
  void display(){
    rectMode(CENTER);
    fill(c);
    stroke(isInside()? color(0,255,0) : color(225));
    strokeWeight(8);
    rect(x,y,w,h, 20);
    
    //Dibuja el texto del boton
    textAlign(CENTER, CENTER);
    textSize(txtSize);
    fill(225);
    text(txt, x, y-5);
  }
  //Verifica si el cursor esta dentro del boton
  boolean isInside() {
    return isHovering = mouseX > (x-w/2) & mouseX < (x+w/2) & mouseY > (y-h/2) & mouseY < (y+h/2);
  }
}
