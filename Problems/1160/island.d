import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    for (;;) {
        auto wh = readln.split.to!(int[]);
        auto w = wh[0];
        auto h = wh[1];
        if (w == 0 && h == 0) return;

        auto MAP = new int[][](h, w);
        foreach (i; 0..h) {
            foreach (j, n; readln.split.to!(int[])) MAP[i][j] = n;
        }

        int c = 1;
        foreach (j; 0..w) foreach (i; 0..h) if (MAP[i][j] == 1) {
            ++c;
            void go(int x, int y) {
                MAP[y][x] = c;
                foreach (dx; [-1,0,1]) foreach (dy; [-1,0,1]) {
                    auto xx = x+dx;
                    auto yy = y+dy;
                    if (xx < 0 || xx >= w || yy < 0 || yy >= h || MAP[yy][xx] != 1) continue;
                    go(xx, yy);
                }
            }
            go(j, i);
        }
        writeln(c-1);
    }
}