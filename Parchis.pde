import ddf.minim.*;
Minim minim;
AudioPlayer player;
int page, index=0;
ArrayList <Button> botones;
PImage  menu, bg, parchis, uno, dos, tres, cuatro, cinco, seis, bgFinal ;
PImage imagedado;
PImage  [] tirar = new PImage[3];
ArrayList<ColorContainer> playerColors;
Game g;

//Inicializa la ventana y las variables
void setup() {
  size(750, 750);
  surface.setLocation(0, 0);
  surface.setTitle("Parchis");
  page=0;
  minim = new Minim(this);
  player = minim.loadFile("assets/Musica.wav");
  
  botones =  new ArrayList();
  botones.add( new Button("JUGAR", 50, 250, 420, 200, 90, 0));
  botones.add( new Button("SALIR", 50, 500, 420, 200, 90, 0));
  botones.add( new Button("ROJO", 25, 200, 375, 150, 150, color(198, 16, 49)));
  botones.add( new Button("VERDE", 25, 375, 375, 150, 150, color(34, 177, 76)));
  botones.add( new Button("AZUL", 25, 550, 375, 150, 150, color(74, 156, 206)));
  botones.add( new Button("", 1, 79, 680, 110, 110, color(0)));
  botones.add( new Button("regresar al menu", 20, 600, 650, 200, 100, color(0)));
  menu = loadImage("assets/Menu.jpg");
  bg = loadImage("assets/BG.png");
  bgFinal = loadImage("assets/BG.final.png");
  parchis = loadImage("assets/parchis2.png");
  uno = loadImage("assets/dado 1.png");
  dos = loadImage("assets/dado 2.png");
  tres = loadImage("assets/dado 3.png");
  cuatro = loadImage("assets/dado 4.png");
  cinco = loadImage("assets/dado 5.png");
  seis = loadImage("assets/dado 6.png");
  for (int i = 0; i<3; i++) {
    tirar[i] = loadImage("assets/dado moviendo"+ i+".png");
    tirar[i].resize(190, 190);
  }
  frameRate(15);
  parchis.resize(495, 495);
  imagedado = uno;
  playerColors = new ArrayList();
}

//Un ciclo que podemos utilizar para dibujar la parte grafica
void draw() {
  pageSelector();

}

//Elige cual pagina se va a dibujar
private void pageSelector() {
  switch(page) {
  case 0:
    page0();
    break;
  case 1:
    page1();
    break;
  case 2:
    page2();
    break;
  case 3:
    page3();
    break;
  }
}

//Dibuja la pagina0 (el menu)
private void page0() {
  image(menu, 0, 0);
  for (int i=0; i<2; i++) {
    botones.get(i).display();
  }
  textSize(20);
  text("Presione cualquier teclar para mutear o para activar sonido",430, 720);
}

//Dibuja la pagina1 (Pre Juego)
private void page1() {
  image(bg, 0, 0);
  int p = playerColors.size()+1;
  text("Eliga el color para el jugador "+p, width/2, 100);
  for (int i=2; i<5; i++) {
    if (botones.get(i)!=null) {
      botones.get(i).display();
    }
  }
}



//Dibuja la pagina2 (El juego)
private void page2() {
  image(bg, 0, 0);
  if (g.winners.size()<2) {
    g.drawGame();
  } else {
    g.gameOver();
    page=3;
  }

  botones.get(5).display();
  if (mousePressed && mouseX > 30 && mouseX < 140 && mouseY > 630 && mouseY<740) {
    image(tirar[index], -6, 430);

    index= ( index+1)%3;
  } else {  
    image(imagedado, 30, 630);
  }
}

//Dibuja la pagina3 (Pos Juego)
private void page3() {
  image(bgFinal, 0, 0);
  g.drawGameOver();
  botones.get(6).display();
}

void mousePressed() {
  if (page==0) {
    if (botones.get(0).isHovering) page=1;
    if (botones.get(1).isHovering) exit();
  } else if (page==1) {
    if (botones.get(2)!=null && botones.get(2).isHovering) {
      playerColors.add(new ColorContainer(color(198, 16, 49)));
      botones.set(2, null);
    } else if (botones.get(3)!=null && botones.get(3).isHovering) {
      playerColors.add(new ColorContainer(color(34, 177, 76)));
      botones.set(3, null);
    } else if (botones.get(4)!=null && botones.get(4).isHovering) {
      playerColors.add(new ColorContainer(color(74, 156, 206)));
      botones.set(4, null);
    }
    if (playerColors.size()==2) {

      if ((playerColors.get(0).c==color(198, 16, 49) && playerColors.get(1).c==color(34, 177, 76)) || (playerColors.get(1).c==color(198, 16, 49) && playerColors.get(0).c==color(34, 177, 76))) {
        playerColors.add(new ColorContainer(color(74, 156, 206)));
      } else if ((playerColors.get(0).c==color(198, 16, 49) && playerColors.get(1).c==color(74, 156, 206)) || (playerColors.get(1).c==color(198, 16, 49) && playerColors.get(0).c==color(74, 156, 206))) {
        playerColors.add(new ColorContainer(color(34, 177, 76)));
      } else {
        playerColors.add(new ColorContainer(color(198, 16, 49)));
      }

      g = new Game(playerColors);
      page=2;
    }
  } else if (page==2) {
    if (botones.get(5).isHovering) {


      g.turn(dado());
    }
  } else if (page==3) {
    if (botones.get(6).isHovering) { 
      page=0;
      playerColors = new ArrayList();
      botones.set(2, new Button("ROJO", 25, 200, 375, 150, 150, color(198, 16, 49)));
      botones.set(3, new Button("VERDE", 25, 375, 375, 150, 150, color(34, 177, 76)));
      botones.set(4, new Button("AZUL", 25, 550, 375, 150, 150, color(74, 156, 206)));
    }
  }
}

int dado() {
  int dado=0;
  float num = random(1, 7);

  if (num>=1&&num<2) {
    dado=1;


    imagedado=uno;
  } else if (num>=2&&num<3) {
    dado=2;

    imagedado=dos;
  } else if (num>=3&&num<4) {
    dado=3;


    imagedado=tres;
  } else if (num>=4&&num<5) {
    dado=4;

    imagedado=cuatro;
  } else if (num>=5&&num<6) {
    dado=5;

    imagedado=cinco;
  } else if (num>=6&&num<7) {
    dado=6;


    imagedado=seis;
  } else {
    dado();
  }
  return dado;
}
void keyPressed(){
  if (key =='m'|| key=='M') {
if (player.isPlaying()){
player.pause();
}else {
player.play();}

}}
