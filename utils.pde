// スクリーンショット名用のファイル書き込み
void dispose() {
  // counterをテキストファイルに書き込み
  String msg = String.valueOf(this.counter);
  String[] list = split(msg, '\n');
  saveStrings(filename, list);
  println("exit");
}

// 各頂点と4点目の距離を出し、一番遠い点の配列番号を返す
int distance(int[] x, int[] y) {
  for (int i = 0; i < x.length-1; i++) {
    switch(i) {
    case 0:
      d1 = (int)dist( x[i], y[i], x[3], y[3] );
      break;
    case 1:
      d2 = (int)dist( x[i], y[i], x[3], y[3] );
      break;
    case 2:
      d3 = (int)dist( x[i], y[i], x[3], y[3] );
      max = Math.max(d1, d2);
      max = Math.max(max, d3);
      for (int n = 0; n < x.length-1; n++) {
        if (max == d1) {
          return 0;
        } else if (max == d2) {
          return 1;
        } else if (max == d3) {
          return 2;
        }
      }
      break;
    }
  }
  return 0;
}

// (最初)各頂点と重心とのベクトル計算
void centerOfGravity( int g_x, int g_y ) {
  for ( int i = 0; i < x.length; i++ ) {
    switch( i ) {
    case 0:
      vx[i] = x[i] - g_x;
      vy[i] = y[i] - g_y;
      break;
    case 1:
      vx[i] = x[i] - g_x;
      vy[i] = y[i] - g_y;
      break;
    case 2:
      vx[i] = x[i] - g_x;
      vy[i] = y[i] - g_y;
      break;
    }
  }
}

// (2つ目以降)各頂点と重心とのベクトル計算
void SecondCenterOfGravity( int g_x, int g_y ) {
  for ( int i = 0; i < x.length; i++ ) {
    if (i != farPoint) {
      switch( i ) {
      case 0:
        vx[i] = x[i] - g_x;
        vy[i] = y[i] - g_y;
        break;
      case 1:
        vx[i] = x[i] - g_x;
        vy[i] = y[i] - g_y;
        break;
      case 2:
        vx[i] = x[i] - g_x;
        vy[i] = y[i] - g_y;
        break;
      case 3:
        vx[i] = x[i] - g_x;
        vy[i] = y[i] - g_y;
        break;
      }
    }
  }
}


// (最初)三角形の描画と重心を計算
void FirstTriangle() {
  pg.beginShape(TRIANGLES);
  for (int i = 0; i < x.length-1; i++) {
    pg.vertex(x[i], y[i]);
    g_x += x[i];
    g_y += y[i];
  }
  g_x /= 3;
  g_y /= 3;
  pg.endShape(CLOSE);
}

// (2つ目以降)三角形描画と重心計算
void SecondTriangle() {
  pg.beginShape(TRIANGLES);
  for (int i = 0; i < x.length; i++) {
    if (i != farPoint ) {
      pg.vertex(x[i], y[i]);
      g_x += x[i];
      g_y += y[i];
    }
  }
  g_x /= 3;
  g_y /= 3;
  pg.endShape();
}

// (最初)複数の三角形を描画する
void FirstTriangles( int[] x, int[] y ) {
  x_s = copyArrayX(x);
  y_s = copyArrayY(y);
  while (true) {
    if ( ratio < 0.0 ) break;
    // 線の色を毎回変える場合
    //stroke( random( 0,255 ), random( 0,255 ), random( 0,255 ), 150 );

    pg.beginShape(TRIANGLES);
    for ( int i = 0; i < x_s.length-1; i++ ) {
      x_s[i] = (int)( vx[i] * ratio ) + g_x;
      y_s[i] = (int)( vy[i] * ratio ) + g_y;
      pg.vertex( x_s[i], y_s[i] );
    }
    pg.endShape( CLOSE );
    ratio -= diff;
  }
}

// (2つ目以降)複数の三角形を描画する
void SecondTriangles( int[] x, int[] y ) {
  x_s = copyArrayX(x);
  y_s = copyArrayY(y);
  while (true) {
    if ( ratio < 0.0 ) break;
    // 線の色を毎回変える場合
    //stroke( random( 0,255 ), random( 0,255 ), random( 0,255 ), 150 );

    pg.beginShape(TRIANGLES);
    for ( int i = 0; i < x_s.length; i++ ) {
      if (i != farPoint) {
        x_s[i] = (int)( vx[i] * ratio ) + g_x;
        y_s[i] = (int)( vy[i] * ratio ) + g_y;
        pg.vertex( x_s[i], y_s[i] );
      }
    }
    pg.endShape( CLOSE );
    ratio -= diff;
  }
}

// 画面クリア,変数リセット
void reset() {
  pg = createGraphics( width, height );
  click = 0;
  x   = new int[4];
  y   = new int[4];
  x_s = new int[4];
  y_s = new int[4];
  vx  = new int[4];
  vy  = new int[4];
  d1 = d2 = d3 = 0;
  max       = 0;
  farPoint  = 0;
  g_x = g_y = 0;
  ratio = n;
  first = true;
  dot   = true;
  c = color(0);
}

// 配列コピー(X)
int[] copyArrayX(int[] x) {
  for (int i = 0; i < x.length; i++)
    x_s[i] = x[i];
  return x_s;
}

// 配列コピー(Y)
int[] copyArrayY(int[] y) {
  for (int i = 0; i < y.length; i++)
    y_s[i] = y[i];
  return y_s;
}
