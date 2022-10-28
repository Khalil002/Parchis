class Player{
  int x, y, pNum, sw=0;
  int jailX, jailY;
  color c;
  Node playerPos;
  Node starterPos;
  boolean won=false;
  
  public Player(int jailX, int jailY, color c, Node starterPos, int pNum){
    this.x = jailX;
    this.y = jailY;
    this.jailX = jailX;
    this.jailY = jailY;
    this.c = c;
    this.starterPos = starterPos;
    playerPos=null;
    this.pNum = pNum;
  }
  
  public void drawPlayer(){
    fill(c);
    ellipse(x,y,20,20);
  }
  
  public void move(int x, int y){
    this.x = x;
    this.y = y;
    
  }
  
  public void spawn(){
    playerPos = starterPos;
  }
  
  public void moveToJail(){
    x = jailX;
    y = jailY;
    playerPos=null;
  }
  
  
}
