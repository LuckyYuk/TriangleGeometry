// X -> 点を打つ
// Y -> fill(塗りつぶし)
// A -> moire(モアレ)
// B -> frame(枠線)

import netP5.*;
import oscP5.*;

OscP5 oscP5;
PVector cursor;             // カーソル
PGraphics pg;
String[] receivedColor;     // VIVITAカラーセンサー
int r, g, b;                // カラーセンサー用 Red, Green, Blue
color c;                    // 色変数
int[] x, y;                 // x,y 座標
int[] x_s, y_s;             // x,y 配列のコピー用
int[] vx, vy;               // 各頂点から重心を引いたベクトル
int click;                  // クリック数
int d1, d2, d3;             // 各頂点と4点目の距離
int max;                    // 2点間の距離の最大値 -> 一番遠い
int farPoint;               // 各頂点と4点目の距離と一番遠い点の配列番号
int g_x, g_y;               // 三角形の重心
float penWidth;             // ペンの太さ
float n, ratio, diff;       // 割合
boolean first;              // 最初の三角形描画の判定
boolean dot;                // 背景等の描画
boolean fill, frame, moire; // 塗りつぶし,フレーム,モアレ モード変更
String modeMsg;             // fill, frame, moireメッセージ用
String filename;            // counter用ファイル
int counter;                // 保存画像名用

void settings() {
  fullScreen();
}

void setup() {
  background(255);
  textSize(50);

  oscP5 = new OscP5(this, 22222);

  // テキストファイル読み込み
  // counterに数を代入
  filename = ".//data//counter.txt";
  String[] lines = loadStrings(filename);
  for(int i = 0; i < lines.length; i++) {
    println(lines[i]);
    counter = Integer.parseInt(lines[i]);
  }

  cursor = new PVector(50.0, 50.0);
  pg = createGraphics(width, height);

  click = 0;
  x   = new int[4];
  y   = new int[4];
  x_s = new int[4];
  y_s = new int[4];
  vx  = new int[4];
  vy  = new int[4];

  d1 = d2 = d3 = 0;
  max          = 0;
  farPoint     = 0;
  g_x = g_y    = 0;
  c            = color(0);
  
  first = true;
    dot = true;
  moire = false;
  fill  = false;
  frame = true;
  modeMsg = "";

  /* 各種設定 */
  penWidth = 0.5; // ペンの太さ
  n = 1.0;        // 三角形の重心から各頂点へのベクトルの割合 <- 1.0固定がいいかも
  ratio = n;
  diff  = 0.05;   // 細かさ <- 0.01でもいける
}

void draw() {
  background( 255 );  

  pg.beginDraw();
  if (click == 3 && first) {
    pg.background(255);
    // 線の太さ
    pg.strokeWeight(penWidth);
    // 線の色の変更 stroke( R, G, B ) <- R( 0~255 )...
    //pg.stroke(0);
    if (frame) {
      pg.noFill();
      pg.stroke(c);
    } else if (fill) {
      pg.noStroke();
      pg.fill(c);
    }

    // 三角形を描画
    FirstTriangle();
    // 重心を出す
    centerOfGravity(g_x, g_y);
    // 複数の三角形を描画
    if (moire) {
      pg.stroke(c);
      FirstTriangles(x, y);
    }
    first = false;
  } else if (click == 4) {
    // 各変数リセット
    click = 3;
    g_x = g_y = 0;
    ratio = n;
    // 3つの頂点と4点目の距離を出し、一番遠い点の配列番号を返す
    farPoint = distance(x, y);

    // 線の太さ
    pg.strokeWeight(penWidth);
    // 線の色の変更 stroke( R, G, B ) <- R( 0~255 )...
    //pg.stroke(0);
    if (frame) {
      pg.noFill();
      pg.stroke(c);
    } 
    if (fill) {
      pg.noStroke();
      pg.fill(c);
    } else {
      pg.noFill();
      pg.stroke(c);
    }
    // 三角形を描画
    SecondTriangle();
    // 一番遠い点に4点目の座標を入れる
    x[farPoint] = x[3];
    y[farPoint] = y[3];
    // 重心を出す
    SecondCenterOfGravity(g_x, g_y);
    // 複数の三角形を描画
    if (moire) {
      pg.noFill();
      pg.stroke(c);
      SecondTriangles(x, y);
    }
  }
  pg.endDraw();
  image(pg, 0, 0);

  if (this.dot) {
    this.modeMsg = this.fill  ? "fill"  : this.modeMsg;    
    this.modeMsg = this.frame ? "frame" : this.modeMsg;
    this.modeMsg = this.moire ? "moire" : this.modeMsg;
    
    noStroke();
    fill(255, 0, 0, 150);
    text(modeMsg, 50, 50);
    ellipse(this.cursor.x, this.cursor.y, 10, 10);
    strokeWeight(2);
    stroke(0, 150);
    for (int y = 0; y <= height; y+=50)
      for (int x = 0; x <= width; x+=50)
        point(x, y);
  } else {
    save(dataPath("") + "\\sketch" + this.counter + ".png");
    this.counter++;
    this.dot = true;
  }
  
  this.cursor.x = constrain(this.cursor.x, 0, width-width%50);
  this.cursor.y = constrain(this.cursor.y, 0, height-height%50);
  
}
