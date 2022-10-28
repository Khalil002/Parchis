class Game {
  int cP, winByRoll=0;
  Player[]  p;
  int[][] positions;
  ArrayList<ColorContainer> winners;
  CircularLinkedList board;
  LinkedList bluePath;
  LinkedList redPath;
  LinkedList greenPath;

  public Game(ArrayList<ColorContainer> colors) {
    winners = new ArrayList();
    cP=0;
    iniBoard();
    p = new Player[3];
    int i=0;
    for (ColorContainer col : colors) {
      if (col.c==color(34, 177, 76)) {
        p[i]= new Player(530, 465, col.c, board.getNode(5), 51);
      } else if (col.c==color(74, 156, 206)) {
        p[i]= new Player(375, 188, col.c, board.getNode(22), 17);
      } else {
        p[i]= new Player(220, 465, col.c, board.getNode(39), 34);
      }
      i++;
    }
    iniPositions();
  }

  public void drawGame() {

    fill(p[cP].c);
    textSize(25);
    int j=cP+1;
    text("Turno del jugador "+j, width/2, 50);
    pushMatrix();
    translate(width/2, height/2);
    imageMode(CENTER);
    image(parchis, 0, 0);
    imageMode(CORNER);
    popMatrix();

    strokeWeight(1);
    stroke(1);
    drawb(0, color(34, 177, 76));
    drawb(4.19, color(74, 156, 206));
    drawb(2.09, color(198, 16, 49));


    for (int i=0; i<3; i++) {
      p[i].drawPlayer();
    }
  }

  public void turn(int m) {
    int moves = m;
    int sw = 0;
    //Spawnea el jugador si todavia no ha spawneado
    if (p[cP].playerPos==null && moves==6) {
      p[cP].spawn();
      //Se activa el switch para comerse si hay un jugador que esta donde el currentPlayer va a moverse
      if (moves==1 && p[cP].playerPos.value!=0) {
        sw = p[cP].playerPos.value;
      }
      p[cP].move(positions[p[cP].playerPos.pos-1][0], positions[p[cP].playerPos.pos-1][1]);
      p[cP].playerPos.value=cP+1;
      moves--;
    }

    //Revisa si el jugador ha spawneado para moverlo
    if (p[cP].playerPos!=null) {

      //Revisa si los movimientos no exeden el limite de la lista (el punto final)
      if (moves+p[cP].sw<=9) {

        while (moves!=0) {

          //Revisa si ya se tiene que mover la ficha a una de las LinkedLists
          if (p[cP].playerPos.child!=null && p[cP].playerPos.pos==p[cP].pNum) {
            p[cP].playerPos.value=0;
            p[cP].move(positions[p[cP].playerPos.child.pos-1][0], positions[p[cP].playerPos.child.pos-1][1]);
            p[cP].playerPos= p[cP].playerPos.child;
            p[cP].playerPos.value=cP+1;
            p[cP].sw++;
          } else {
            //Sino simplemente se mueve la ficha
            if (moves==1 && p[cP].playerPos.next.value!=0) {
              sw = p[cP].playerPos.next.value;
            }      
            p[cP].playerPos.value=0;
            p[cP].move(positions[p[cP].playerPos.next.pos-1][0], positions[p[cP].playerPos.next.pos-1][1]);
            p[cP].playerPos= p[cP].playerPos.next;
            p[cP].playerPos.value=cP+1;
            if (p[cP].sw!=1) {
              p[cP].sw++;
            }
            if (sw!=0) {
              p[sw-1].moveToJail();
            }
            if (p[cP].sw==9) {
              p[cP].won = true;
              winners.add(new ColorContainer(p[cP].c));
            }
          }
          moves--;
        }
      }
    }
    if (winByRoll==2 && m==6) {
      winByRoll++;
      p[cP].won=true;
      winners.add(new ColorContainer(p[cP].c));
      if (p[cP].c==color(34, 177, 76)) {
        p[cP].move(positions[74][0], positions[74][1]);
      } else if (p[cP].c==color(74, 156, 206)) {
        p[cP].move(positions[58][0], positions[58][1]);
      } else {
        p[cP].move(positions[66][0], positions[66][1]);    
      }
    }

    
    
    if (m==6 && winByRoll != 3) {
      winByRoll++;
    } else {
      winByRoll=0;
      switch(cP) {
      case 0:
        if (p[1].won) {
          cP=2;
        } else {
          cP=1;
        }
        break;
      case 1:
        if (p[2].won) {
          cP=0;
        } else {
          cP=2;
        }
        break;
      case 2:
        if (p[0].won) {
          cP=1;
        } else {
          cP=0;
        }
        break;
      }
    }
    
  }


  ///////Aqui
  public void gameOver() {
    if ((winners.get(0).c==color(198, 16, 49) && winners.get(1).c==color(34, 177, 76)) || (winners.get(1).c==color(198, 16, 49) && winners.get(0).c==color(34, 177, 76))) {
      winners.add(new ColorContainer(color(74, 156, 206)));
    } else if ((winners.get(0).c==color(198, 16, 49) && winners.get(1).c==color(74, 156, 206)) || (winners.get(1).c==color(198, 16, 49) && winners.get(0).c==color(74, 156, 206))) {
      winners.add(new ColorContainer(color(34, 177, 76)));
    } else {
      winners.add(new ColorContainer(color(198, 16, 49)));
    }
  }

  public void drawGameOver() {

  
    for (int i=0; i<3; i++) {
      StringBuffer sb = new StringBuffer();
      int equix,ye;
      if (i==0) {
        equix=380;
        ye=365;
      } else if (i==1) {
        equix=235;
        ye=395;
      } else {
        equix=525;
        ye=430;
      }
      if (winners.get(i).c==color(198, 16, 49)) {
        sb.append("Rojo");
      } else if (winners.get(i).c==color(34, 177, 76)) {
        sb.append("Verde");
      } else {
        sb.append("Azul");
      }
      fill(winners.get(i).c);
      textSize(47);
      text(""+sb, equix, ye);
      
    }
  }

  private void iniBoard() {
    board = new CircularLinkedList(51);
    greenPath = new LinkedList(8, 68);
    bluePath = new LinkedList(8, 52);
    redPath = new LinkedList(8, 60);

    board.getNode(17).child = bluePath.ptr;
    board.getNode(34).child = redPath.ptr;
    board.getNode(51).child = greenPath.ptr;
  }

  private void iniPositions() {
    positions = new int[75][2];
    for (int i=0; i<8; i++) {
      //1 to 8
      positions[0+i][0]=433;
      positions[0+i][1]=597-25*i;
      //9 to 16
      positions[8+i][0]=445+22*i;
      positions[8+i][1]=400-12*i;
      //18 to 25
      positions[17+i][0]=540-22*i;
      positions[17+i][1]=213+12*i;
      //26 to 33
      positions[25+i][0]=364-22*i;
      positions[25+i][1]=297-12*i;
      //35 to 42
      positions[34+i][0]=150+22*i;
      positions[34+i][1]=316+12*i;
      //43 to 50
      positions[42+i][0]=317;
      positions[42+i][1]=423+25*i;
      //52 to 59
      positions[51+i][0]=547-22*i;
      positions[51+i][1]=278+12*i;
      //60 to 67
      positions[59+i][0]=203+22*i;
      positions[59+i][1]=278+12*i;
      //68 to 75
      positions[67+i][0]=375;
      positions[67+i][1]=572-25*i;
    }
    //17, 34 y 51
    positions[16][0]=569;
    positions[16][1]=265;
    positions[33][0]=182;
    positions[33][1]=264;
    positions[50][0]=375;
    positions[50][1]=598;
  }

  private void drawb(float r, color c) {
    pushMatrix();
    translate(width/2, height/2);
    fill(c);
    rotate(r);
    beginShape();
    vertex(247, -42);
    vertex(87, 50);
    vertex(87, 235);
    vertex(217, 125);
    endShape(CLOSE);
    popMatrix();
  }
}



/*

 Code Graveyard (Por si acaso lo neceistamos en el futuro)
 
 pushMatrix();
 translate(width/2, height/2);
 fill(255);
 rotate(4.71239);
 polygon(0, 0, 250, 9);
 //polygon(0, 0, 68, 3);
 popMatrix();
 
 pushMatrix();
 translate(width/2, height/2);
 
 stroke(0);
 drawb(0);
 drawb(2.1);
 drawb(2.1);
 
 popMatrix();
 
 
 
 void polygon(float x, float y, float radius, int npoints) {
 float angle = TWO_PI / npoints;
 beginShape();
 for (float a = 0; a < TWO_PI; a += angle) {
 float sx = x + cos(a) * radius;
 float sy = y + sin(a) * radius;
 vertex(sx, sy);
 }
 endShape(CLOSE);
 }
 */

/*
  public void turn(int m){
 int w=0;
 for(int i=0; i<3; i++){
 if(p[i].won){
 w++;
 }
 }
 
 if(w!=2){
 int moves = m;
 int sw;
 
 
 if(moves+p[cP].sw>9){
 
 }else{
 do{
 if(!p[cP].won){
 sw = 0;
 if(p[cP].playerPos==null){
 if(moves==6){
 p[cP].spawn();
 if(moves==1 && p[cP].playerPos.value!=0){
 sw = p[cP].playerPos.value;
 }
 p[cP].move(positions[p[cP].playerPos.pos-1][0], positions[p[cP].playerPos.pos-1][1]);
 p[cP].playerPos.value=cP+1;
 }else{
 moves=1;
 }
 }else if(p[cP].playerPos.child!=null && p[cP].playerPos.pos==p[cP].pNum){
 p[cP].playerPos.value=0;
 p[cP].move(positions[p[cP].playerPos.child.pos-1][0], positions[p[cP].playerPos.child.pos-1][1]);
 p[cP].playerPos= p[cP].playerPos.child;
 p[cP].playerPos.value=cP+1;
 p[cP].sw++;
 }else{
 if(moves==1 && p[cP].playerPos.next.value!=0){
 sw = p[cP].playerPos.next.value;
 }      
 p[cP].playerPos.value=0;
 p[cP].move(positions[p[cP].playerPos.next.pos-1][0], positions[p[cP].playerPos.next.pos-1][1]);
 p[cP].playerPos= p[cP].playerPos.next;
 p[cP].playerPos.value=cP+1;
 if(p[cP].sw!=1){
 p[cP].sw++;
 }
 
 if(p[cP].sw==9){
 p[cP].won = true;
 }
 }
 if(sw!=0){
 p[sw-1].moveToJail();
 }
 }
 moves--;
 }while(moves!=0);
 }
 
 if(m==6){
 winByRoll++;
 }else{
 winByRoll=0;
 switch(cP){
 case 0:
 if(p[1].won){
 cP=2;
 }else{
 cP=1;
 }
 break;
 case 1:
 if(p[2].won){
 cP=0;
 }else{
 cP=2;
 }
 break;
 case 2:
 if(p[0].won){
 cP=1;
 }else{
 cP=0;
 }
 break;
 }
 }
 if(winByRoll==3){
 p[cP].won=true;
 winByRoll=0;
 }
 
 }else{
 page=3;
 }
 }
 */
