// キーボード操作
void keyPressed() {
  switch(key) {
  case ESC:
    // プログラム終了
    this.dispose();
    break;
  case 'w':
    // カーソルを上に動かす
    this.cursor.y -= 50;
    break;
  case 's':
    // カーソルを下に動かす
    this.cursor.y += 50;
    break;
  case 'a':
    // カーソルを左に動かす
    this.cursor.x -= 50;
    break;
  case 'd':
    // カーソルを右に動かす
    this.cursor.x += 50;
    break;
  case 'c':
    // 画面をクリアする
    this.reset();
    break;
  case 'p':
    // クリック処理, 描画
    this.click();
    break;
  case ENTER:
    // スクリーンショット
    this.dot = false;
    break;
  case 'j':
    // 描画モードを frame(枠線のみ)にする
    this.frame = true;
    this.fill  = false;
    this.moire = false;
    break;
  case 'k':
    // 描画モードを moire(縞模様)にする
    this.moire = true;
    this.frame = false;
    this.fill  = false;
    break;
  case 'l':
    // 描画モードを fill(塗りつぶし)にする
    this.fill  = true;
    this.frame = false;
    this.moire = false;
    break;
  }
}

// マウスクリック
void click() {
  // 最初の3点を点で描画し、x,y配列にマウス座標を入れる
  if (click < 4 && first ) {
    pg.beginDraw();
    pg.strokeWeight(5);
    pg.stroke(255, 0, 0);
    pg.beginShape(POINTS);
    x[click] = (int)this.cursor.x;
    y[click] = (int)this.cursor.y;
    pg.vertex(x[click], y[click]);
    pg.endShape();
    pg.stroke(0);
    pg.endDraw();
  } else {
    // x,y配列にマウス座標を入れる
    x[click] = (int)this.cursor.x;
    y[click] = (int)this.cursor.y;
  }
  click++;
}
